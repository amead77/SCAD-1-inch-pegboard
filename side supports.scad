/*

creates straight or angled side supports for anything that can be mounted on the pegboard.

*/


/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/25r92";
**/

include <peg panel.scad>;
$fn = 64;

// Extrudes a 2D polygon profile (given as a list of [x,y] points, CCW from above)
// from z=z0 to z=z1. Points on the peg panel face stay at y=0 while the rest
// expand or contract in +Y at the top.
module _support_extrude(pts2d, z0, z1, y_delta = 0) {
    n = len(pts2d);
    profile_depth = max([for (p = pts2d) p[1]]);
    top_depth = max(0, profile_depth + y_delta);
    y_scale = profile_depth > 0 ? top_depth / profile_depth : 1;
    polyhedron(
        points = concat(
            [for (p = pts2d) [p[0], p[1],            z0]],
            [for (p = pts2d) [p[0], p[1] * y_scale, z1]]
        ),
        faces = concat(
            [[for (i = [n-1:-1:0]) i]],                               // bottom face (normal -z)
            [[for (i = [0:n-1])    n + i]],                           // top face    (normal +z)
            [for (i = [0:n-1]) [i, (i+1)%n, n+(i+1)%n, n+i]]        // side faces
        )
    );
}

module side_support(
    panel_size = [
        3, // in PEG SPACE UNITS, not mm
        4, // thickness of the panel, in mm
        2 // in PEG SPACE UNITS, not mm
    ], 
    peg_spacing = 25.4, //distance between peg centres
    peg_diameter = 4.0, //diameter of the peg pin
    hole_diameter = 6.0, //diameter of the pin part that hooks in the pegboard
    hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
    hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
    peg_offset_x = 12.7, //offset of the first peg pin
    peg_offset_z = 12.7, //offset of the first peg pin          
    
    support_side = "left", //"left", "right", or "both" - which side(s) to put the support on
    support_offset_left_x = 20, //offset of the support from the side of the panel, in mm
    support_offset_right_x = 20, //offset of the support from the side of the panel, in mm
    support_offset_z = 10, //offset of the support from the top of the panel, in mm
    support_width_x = 20, //width of the support in the x axis, in mm
    support_height_z = 20, //height of the support in the z axis, in mm
    support_thickness = 5, //thickness of the support, in mm
    support_distance_y = 5, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
    support_base = true, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
    support_angle = 0 //angle of the support from vertical, in degrees. negative angles lean forward from the pegboard at the top
) {
    panel_x = (max(1, panel_size[0]) - 1) * peg_spacing + 2 * peg_offset_x;
    left_support_x = support_offset_left_x;
    right_support_x = panel_x - support_offset_right_x - support_width_x;

    peg_panel(panel_size, peg_spacing, peg_diameter, hole_diameter, hole_depth, hole_lip, peg_offset_x, peg_offset_z);

    // Negative angles lean forward from the pegboard, which is +Y in this model.
    y_delta = -support_height_z * tan(support_angle);

    // ── 2D profiles (CCW when viewed from above) ──────────────────────────────
    // Left L: vertical leg at the left edge, tied back to the peg panel at y=0.
    pts_left = [
        [left_support_x,                     0                 ],
        [left_support_x + support_width_x,   0                 ],
        [left_support_x + support_width_x,   support_thickness ],
        [left_support_x + support_thickness, support_thickness ],
        [left_support_x + support_thickness, support_distance_y],
        [left_support_x,                     support_distance_y],
    ];
    // Right L: mirrored version using the independent right-side offset.
    pts_right = [
        [right_support_x,                                       0                 ],
        [right_support_x + support_width_x,                     0                 ],
        [right_support_x + support_width_x,                     support_distance_y],
        [right_support_x + support_width_x - support_thickness, support_distance_y],
        [right_support_x + support_width_x - support_thickness, support_thickness ],
        [right_support_x,                                       support_thickness ],
    ];

    if (support_side == "left" || support_side == "both") {
        _support_extrude(pts_left, support_offset_z, support_offset_z + support_height_z, y_delta);
        if (support_base && support_offset_z > 0) {
            _support_extrude(pts_left, 0, support_offset_z, 0);
        }
    }

    if (support_side == "right" || support_side == "both") {
        _support_extrude(pts_right, support_offset_z, support_offset_z + support_height_z, y_delta);
        if (support_base && support_offset_z > 0) {
            _support_extrude(pts_right, 0, support_offset_z, 0);
        }
    }

}