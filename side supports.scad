/*

creates straight or angled side supports for anything that can be mounted on the pegboard.

*/


/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/25r86";
**/

include <peg panel.scad>;
$fn = 64;

// Extrudes a 2D polygon profile (given as a list of [x,y] points, CCW from above)
// from z=z0 to z=z1.  y_shift tilts the top face: each top point gains y_shift in Y.
module _support_extrude(pts2d, z0, z1, y_shift = 0) {
    n = len(pts2d);
    polyhedron(
        points = concat(
            [for (p = pts2d) [p[0], p[1],            z0]],
            [for (p = pts2d) [p[0], p[1] + y_shift,  z1]]
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
    peg_panel(panel_size, peg_spacing, peg_diameter, hole_diameter, hole_depth, hole_lip, peg_offset_x, peg_offset_z);

    // Y shift at the top face due to support_angle (negative = lean forward at top = +y)
    y_shift = support_height_z * tan(support_angle);

    // ── 2D profiles (CCW when viewed from above) ──────────────────────────────
    // Left L: leg on the left side (x = support_offset_x)
    pts_left = [
        [support_offset_x,                     0                 ],  // back-left
        [support_offset_x + support_width_x,   0                 ],  // back-right
        [support_offset_x + support_width_x,   support_thickness ],  // front-right of arm
        [support_offset_x + support_thickness, support_thickness ],  // inner corner
        [support_offset_x + support_thickness, support_distance_y],  // inner-front of leg
        [support_offset_x,                     support_distance_y],  // outer-front of leg
    ];
    // Right L: leg on the right side (x = support_offset_x + support_width_x)
    pts_right = [
        [support_offset_x,                                       0                 ],  // back-left
        [support_offset_x + support_width_x,                     0                 ],  // back-right
        [support_offset_x + support_width_x,                     support_distance_y],  // outer-front of leg
        [support_offset_x + support_width_x - support_thickness, support_distance_y],  // inner-front of leg
        [support_offset_x + support_width_x - support_thickness, support_thickness ],  // inner corner
        [support_offset_x,                                       support_thickness ],  // front-left of arm
    ];
    // Both (U-shape): legs on both sides
    pts_both = [
        [support_offset_x,                                       0                 ],  // back-left
        [support_offset_x + support_width_x,                     0                 ],  // back-right
        [support_offset_x + support_width_x,                     support_distance_y],  // outer-front right
        [support_offset_x + support_width_x - support_thickness, support_distance_y],  // inner-front right
        [support_offset_x + support_width_x - support_thickness, support_thickness ],  // inner corner right
        [support_offset_x + support_thickness,                   support_thickness ],  // inner corner left
        [support_offset_x + support_thickness,                   support_distance_y],  // inner-front left
        [support_offset_x,                                       support_distance_y],  // outer-front left
    ];

    pts = support_side == "right" ? pts_right :
          support_side == "both"  ? pts_both  :
          pts_left;

    // Main body: angled extrusion from z=support_offset_z upward
    _support_extrude(pts, support_offset_z, support_offset_z + support_height_z, y_shift);

    // Base: straight (un-angled) extrusion from z=0 to z=support_offset_z
    if (support_base && support_offset_z > 0) {
        _support_extrude(pts, 0, support_offset_z, 0);
    }

}