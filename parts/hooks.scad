// generic hook module. creates a rail with hooks.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/30r05";
**/

include <peg panel.scad>;

module round_hook(
        hook_dia = 6.0, // diameter of the hook pin
        hook_length = 20, // length of the hook pin
        hook_tip_length = 10 //length of the hook tip, this part is on the end of the hook and points upwards
) {
/*
Just returns a round hook.
*/
    rotate([270, 0, 0]) {
        cylinder(d = hook_dia, h = hook_length);
        if (hook_tip_length > 0) {
            translate([0, 0, hook_length-hook_dia/2]) {
                rotate([90, 0, 0]) {
                    cylinder(d = hook_dia, h = hook_tip_length);
                }
            }
        }
    }
}

module square_hook(
        hook_dia = 6.0, // diameter of the hook pin
        hook_length = 20, // length of the hook pin
        hook_tip_length = 5 //length of the hook tip, this part is on the end of the hook and points upwards
) {
/*
just returns a square hook
*/
    translate([0, (hook_length/2), 0]) {
        cube([hook_dia, hook_length, hook_dia], center = true);
    }
    if (hook_tip_length > 0) {
        translate([0, hook_length+hook_dia/2, (hook_tip_length/2)]) {
            cube([hook_dia, hook_dia, hook_tip_length+hook_dia], center = true);
        }
    }
}


module hook_rail(
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
        panel_type = "standard", // ["standard", "bent_hook"] type of panel hook, standard or bent hook on top
        bent_peg_radius = 3, // radius of the bend for bent hook pegs, only used if panel_type is "bent_hook"
        bent_peg_angle = 70, // angle of the bend for bent hook pegs
        bent_peg_length_straight1 = hole_depth, // length of the straight part of the bent hook peg before the bend
        bent_peg_length_straight2 = 4, // length of the straight part of the hook that curves up
        hook_dia = 6.0, // diameter of the hook pin
        hook_length = 20, // length of the hook pin
        spacing = 30.0, // spacing between hooks, in mm
        offset_x = 10.0, //offset of the hooks from the side, in mm
        offset_z = 5.0, //offset of the hooks from the bottom edge of the base
        hook_shape = "cylindrical", // ["cylindrical", "square"]
        hook_tip_length = 10, //length of the hook tip, this part is on the end of the hook and points upwards
        hole_spacing = 25.4 // 1 inch - this is PEGBOARD hole spacing, used to calculate the overall size of the panel and the number of holes.
        
    ) {
/*
This creates a pegboard hook rail. it is offset away from the peg panel and joined to it.
the number of holes is determined by the panel size and the spacing between holes.
*/
    rail_width = panel_size[0] * hole_spacing;
    usable_width = max(0, rail_width - 2 * offset_x);
    hole_count = max(1, floor(usable_width / spacing) + 1);
    

    union() {
            for (i = [0:hole_count - 1]) {
                translate([offset_x + i * spacing, 0, (hook_dia/2) + offset_z]) {
                    if (hook_shape == "cylindrical") {
                        round_hook(hook_dia = hook_dia, hook_length = hook_length, hook_tip_length = hook_tip_length);
                    } else if (hook_shape == "square") {
                        square_hook(hook_dia = hook_dia, hook_length = hook_length, hook_tip_length = hook_tip_length);
                    }
                    
                }
            }
        }
        peg_panel(
            panel_size=panel_size,
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            peg_undersize = peg_undersize, //peg undersizing to fit in the hole, in mm. This is subtracted from the hole_diameter
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin
            panel_type = panel_type, // type of panel hook, standard or bent hook on top
            bent_peg_radius = bent_peg_radius,
            bent_peg_angle = bent_peg_angle,
            bent_peg_length_straight1 = bent_peg_length_straight1,
            bent_peg_length_straight2 = bent_peg_length_straight2

        );
    }

