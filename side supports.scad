/*

creates straight or angled side supports for anything that can be mounted on the pegboard.

I tried to get lazy and get AI to do this one. It failed, badly.
If you're thinking of modifying this with AI, think again. AI cannot work in 3 dimensions.
It repeadedly spewed out code that looked good, but didn't work, at all.
AI can work very well to help you fix your mistakes, but not create models.
Maybe next year.
*/


/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/30r00";
**/

include <peg panel.scad>;
$fn = 64;


function aoffset(ang, reqlen) = 
    reqlen / cos(ang);

function angle(x, y) = 
    atan2(y, x);


module makewing(
/*
makes the 'wing' part of the support, which gets mirrored for the other side.
*/
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
    //rotating breaks my brain
    translate(base_support ? [0, 0, thickness] : [0, 0, 0]) {
        rotate([90, 0, 90]) {
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
    }
    //make the base
    if (base_support) {
        translate([0, 0, 0]) {
            cube([support_width_x+thickness, support_distance_y_bottom+a_offset, thickness] , center = false);
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
    peg_undersize = 0.2, //peg undersizing to fit in the hole, in mm. This is subtracted from the hole_diameter
    hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
    hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
    peg_offset_x = 12.7, //offset of the first peg pin
    peg_offset_z = 12.7, //offset of the first peg pin          
    
    support_side = "left", //"left", "right", or "both" - which side(s) to put the support on
    support_offset_left_x = 0, //offset of the support from the side of the panel, in mm
    support_offset_right_x = 0, //offset of the support from the side of the panel, in mm
    support_offset_z = 0, //offset of the support from the bottom of the panel, in mm
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

    peg_panel(
        panel_size=panel_size,
        peg_spacing=peg_spacing,
        peg_diameter=peg_diameter,
        hole_diameter=hole_diameter,
        peg_undersize=peg_undersize,
        hole_depth=hole_depth,
        hole_lip=hole_lip,
        peg_offset_x=peg_offset_x,
        peg_offset_z=peg_offset_z
    );

    if (support_side == "right" || support_side == "both") {
        translate([left_support_x, 0, support_offset_z]) {
            makewing(
                support_width_x = support_width_x, //width of the support in the x axis, in mm
                support_height_z = support_height_z, //height of the support in the z axis, in mm
                support_distance_y_top = support_distance_y_top, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
                support_distance_y_bottom = support_distance_y_bottom, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
                support_thickness = support_thickness, //thickness of the support, in mm
                base_support = support_base //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
            );
        }
    }

    if (support_side == "left" || support_side == "both") {
        mirror([1, 0, 0]) {
            translate([(-panel_x)+support_offset_right_x, 0, support_offset_z]) {
                makewing(
                    support_width_x = support_width_x, //width of the support in the x axis, in mm
                    support_height_z = support_height_z, //height of the support in the z axis, in mm
                    support_distance_y_top = support_distance_y_top, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
                    support_distance_y_bottom = support_distance_y_bottom, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
                    support_thickness = support_thickness, //thickness of the support, in mm
                    base_support = support_base //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
                );
            };
        }
    }

}
