/*

creates straight or angled side supports for anything that can be mounted on the pegboard.

*/


/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/29r38";
**/

include <peg panel.scad>;
$fn = 64;


function aoffset(ang, reqlen) = 
    reqlen / cos(ang);

function angle(x, y) = 
    atan2(y, x);


module makewing(
    support_width_x = 20, //width of the support in the x axis, in mm
    support_height_z = 20, //height of the support in the z axis, in mm
    support_distance_y_top = 15, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
    support_distance_y_bottom = 5, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
    support_thickness = 5, //thickness of the support, in mm
    base_support = true //add a base to the support wing
) {
    low_init = 0;
    high_init = support_height_z;
    low_left = 0;
    low_right = support_distance_y_bottom;
    high_left = 0;
    high_right = support_distance_y_top;
    thickness = support_thickness;
    v_points = [
        [low_left, low_init],
        [low_right, low_init],
        [high_right, high_init],
        [high_left, high_init]
    ];
    
    t_offset = angle(high_init, high_right);
    echo (str("angle: ", t_offset));
    a_offset = aoffset(t_offset, thickness);
    echo (str("a_offset: ", a_offset));
    o_points = [
        [low_left, low_init],
        [low_right + a_offset, low_init],
        [high_right + a_offset, high_init],
        [high_left, high_init]
    ];

    rotate([0, 90, 0]) {
    //make the side
    translate([0, 0, 0]) {
        linear_extrude(height = thickness) {
            polygon(points = o_points);
        }
    }
    //make the wing
    difference() {
        translate([0, 0, thickness]) {
            linear_extrude(height = support_width_x) {
                polygon(points = o_points);
            }
        }
        translate([0, 0, thickness]) {
            linear_extrude(height = support_width_x) {
                polygon(points = v_points);
            }
        }
    }
    }
    //make the base
    if (base_support) {
        translate([0, 0, 0]) {
//            cube([support_thickness, support_distance_y_top + a_offset, support_width_x], center = false);
        }
    }

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
    support_distance_y_top = 15, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
    support_distance_y_bottom = 5, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
    support_base = true, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
    //support_angle = 0 //angle of the support from vertical, in degrees. negative angles lean forward from the pegboard at the top


) {
    panel_x = (max(1, panel_size[0]) - 1) * peg_spacing + 2 * peg_offset_x;
    left_support_x = support_offset_left_x;
    right_support_x = panel_x - support_offset_right_x - support_width_x;

    peg_panel(panel_size, peg_spacing, peg_diameter, hole_diameter, hole_depth, hole_lip, peg_offset_x, peg_offset_z);


    makewing(
        support_height_z = support_height_z, //height of the support in the z axis, in mm
        support_distance_y_top = support_distance_y_top, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
        support_distance_y_bottom = support_distance_y_bottom, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
        support_thickness = support_thickness //thickness of the support, in mm
    );

    if (support_side == "left" || support_side == "both") {
    }

    if (support_side == "right" || support_side == "both") {
    }

}

module test01() {
    low_init = 0;
    high_init = 30;
    low_left = 0;
    low_right = 10;
    high_left = 0;
    high_right = 90;
    thickness = 5;
    v_points = [
        [low_left, low_init],
        [low_right, low_init],
        [high_right, high_init],
        [high_left, high_init]
    ];
    
    t_offset = angle(high_init, high_right);
    echo (str("angle: ", t_offset));
    a_offset = aoffset(t_offset, thickness);
    echo (str("a_offset: ", a_offset));
    o_points = [
        [low_left, low_init],
        [low_right + a_offset, low_init],
        [high_right + a_offset, high_init],
        [high_left, high_init]
    ];

    translate([0, 0, 0]) {
        linear_extrude(height = 10) {
            polygon(points = o_points);
        }
    }
    
    translate([0, 0, 10]) {
        linear_extrude(height = 10) {
            polygon(points = v_points);
        }
    }
/*        ,
        faces = concat(
            [[for (i = [3:-1:0]) i]],                               // bottom face (normal -z)
            [[for (i = [0:3])    4 + i]],                           // top face    (normal +z)
            [[0, 1, 5, 4]], // side faces
            [[1, 2, 6, 5]],
            [[2, 3, 7, 6]],
            [[3, 0, 4, 7]]
        )
    );
*/
}