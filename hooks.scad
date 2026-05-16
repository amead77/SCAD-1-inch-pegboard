// generic hook module. creates a rail with hooks.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/16r40";
**/

include <peg panel.scad>;

module hook_rail(
        panel_size = [
            3, // in PEG SPACE UNITS, not mm
            4, // thickness of the panel, in mm
            2 // in PEG SPACE UNITS, not mm
        ], 
        hook_dia = 6.0, // diameter of the hook pin
        hook_length = 20, // length of the hook pin
        spacing = 30.0, // spacing between hooks, in mm
        offset_x = 12.7, //offset of the hooks from the side, in mm
        offset_z = 5.0, //offset of the hooks from the bottom edge of the base
        hook_shape = "cylindrical", // ["cylindrical", "square"]
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
                        rotate([270, 0, 0]) {
                            cylinder(d = hook_dia, h = hook_length);
                        }
                    } else if (hook_shape == "square") {
                        translate([0, (hook_length/2), 0]) {
                            cube([hook_dia, hook_length, hook_dia], center = true);
                        }
                    }
                    
                }
            }
        }
        peg_panel(panel_size=panel_size);
    }

