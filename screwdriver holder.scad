// small pot holder that attaches to a pegboard with 1" hole spacing.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/16r28";
**/

include <peg panel.scad>;
$fn = 64;

// dimensions of the pegboard holes
//hole_diameter = 6.5;
//hole_spacing = 25.4; // 1 inch
//hole_depth = 3.4;
//hole_lip = 1.0; // the lip that holds the peg in place


module screwdriver_holder_assembly(
        panel_size = [
            3, // in PEG SPACE UNITS, not mm
            4, // thickness of the panel, in mm
            2 // in PEG SPACE UNITS, not mm
        ], 
        screwdriver_dia = 10, //diameter of the screwdriver holder holes.
        screwdriver_hole_spacing = 25.4, //spacing between screwdriver holes
        screwdriver_hole_chamfer_width = 1, // chamfer for the screwdriver holes
        screwdriver_hole_chamfer_depth = 5, // depth of the chamfer for the screwdriver holes
        base_thickness = 8, //thickness of the base
        offset_x = 25, //offset of the screwdriver holes from the side, in mm
        offset_y = 25, //offset of the screwdriver holder from the peg panel, in mm
        front_edge_offset = 5, // how far the screwdriver holder is offset from the front edge of the peg panel, in mm
        screwdriver_rail_position = 20, //how high above z=0 the screwdriver rail and holes are. in mm
        hole_spacing = 25.4 // 1 inch - this is pegboard hole spacing, used to calculate the overall size of the panel and the number of holes.
    ) {
/*
This creates a pegboard screwdriver holder. it is offset away from the peg panel and joined to it.
the number of holes is determined by the panel size and the spacing between holes.
*/
    rail_width = panel_size[0] * hole_spacing;
    usable_width = max(0, rail_width - 2 * offset_x);
    hole_count = max(1, floor(usable_width / screwdriver_hole_spacing) + 1);
    base_top_z = screwdriver_rail_position + base_thickness;

        union() {
            // base of the screwdriver holder
            difference() {
                translate([0, 0, screwdriver_rail_position]) {
                    cube([
                        rail_width, 
                        (offset_y+screwdriver_dia+front_edge_offset), 
                        base_thickness
                    ], center = false);
                }
                // screwdriver holes
                for (i = [0:hole_count - 1]) {
                    translate([offset_x + i * screwdriver_hole_spacing, offset_y, screwdriver_rail_position - 5]) {
                        cylinder(d = screwdriver_dia, h = base_thickness + 10); // extra height to ensure it cuts through the base
                    }
                    translate([
                        offset_x + i * screwdriver_hole_spacing,
                        offset_y,
                        base_top_z - screwdriver_hole_chamfer_depth
                    ]) {
                            cylinder(
                                d1 = screwdriver_dia, 
                                d2 = screwdriver_dia + 2 * screwdriver_hole_chamfer_width, 
                                h = screwdriver_hole_chamfer_depth, center = false);
                    }
                }
            }
            peg_panel(panel_size=panel_size);
        }

}