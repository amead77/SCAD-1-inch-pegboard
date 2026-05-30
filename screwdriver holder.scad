// small pot holder that attaches to a pegboard with 1" hole spacing.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/30r12";
**/

include <peg panel.scad>;
$fn = 64;

// dimensions of the pegboard holes
//hole_diameter = 6.5;
//hole_spacing = 25.4; // 1 inch
//hole_depth = 3.4;
//hole_lip = 1.0; // the lip that holds the peg in place

module makerail(rail_width, rail_front_y, base_thickness, screwdriver_lip_z = 3, screwdriver_lip_y = 5) {
    cube([
        rail_width, 
        rail_front_y, 
        base_thickness
    ], center = false);
    if (screwdriver_lip_z > 0 && screwdriver_lip_y > 0) {
        translate([0, rail_front_y - screwdriver_lip_y, base_thickness]) {
            cube([
                rail_width, 
                screwdriver_lip_y, 
                screwdriver_lip_z
            ], center = false);
        }
    }
}


module screwdriver_holder_assembly(
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
        screwdriver_dia = 10, //diameter of the screwdriver holder holes.
        screwdriver_hole_spacing = 25.4, //spacing between screwdriver holes
        screwdriver_hole_chamfer_width = 1, // chamfer for the screwdriver holes
        screwdriver_hole_chamfer_depth = 5, // depth of the chamfer for the screwdriver holes
        base_thickness = 8, //thickness of the base
        screwdriver_rail_cutout_width = 0, // width of the cutout in the base for the screwdriver rail. set to 0 for no cutout.
        screwdriver_rail_cutout_chamfer_angle = 20, // angle of the chamfer for the screwdriver rail cutout, in degrees. only used if screwdriver_rail_cutout_width > 0
        offset_x = 25, //offset of the screwdriver holes from the side, in mm
        offset_y = 25, //offset of the screwdriver holder from the peg panel, in mm
        front_edge_offset = 5, // how far the screwdriver holder is offset from the front edge of the peg panel, in mm
        screwdriver_rail_position = 20, //how high above z=0 the screwdriver rail and holes are. in mm
        screwdriver_lip_z = 0, // how high the lip that holds the screwdriver in place is above the base of the holder, in mm. 0 means no lip.
        screwdriver_lip_y = 0 // how far the lip that holds the screwdriver in place extends in the y axis, in mm. 0 means no lip.
        //hole_spacing = 25.4 // 1 inch - this is pegboard hole spacing, used to calculate the overall size of the panel and the number of holes.
    ) {
/*
This creates a pegboard screwdriver holder. it is offset away from the peg panel and joined to it.
the number of holes is determined by the panel size and the spacing between holes.
*/
    rail_width = panel_size[0] * peg_spacing;
    rail_front_y = offset_y + screwdriver_dia + front_edge_offset;
    cutout_run_y = max(0, rail_front_y - offset_y);
    cutout_front_width = screwdriver_rail_cutout_width + 2 * cutout_run_y * tan(screwdriver_rail_cutout_chamfer_angle);
    usable_width = max(0, rail_width - 2 * offset_x);
    hole_count = max(1, floor(usable_width / screwdriver_hole_spacing) + 1);
    base_top_z = screwdriver_rail_position + base_thickness;

        union() {
            // base of the screwdriver holder
            difference() {
                translate([0, 0, screwdriver_rail_position]) {
                    makerail(rail_width, rail_front_y, base_thickness, screwdriver_lip_z, screwdriver_lip_y);
                }
                // screwdriver holes
                for (i = [0:hole_count - 1]) {
                    translate([offset_x + i * screwdriver_hole_spacing, offset_y, screwdriver_rail_position - 5]) {
                        cylinder(d = screwdriver_dia, h = base_thickness+screwdriver_lip_z + 10); // extra height to ensure it cuts through the base
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
                    // cutout for the screwdriver rail, if specified
                    if (screwdriver_rail_cutout_width > 0) {
                        translate([
                            offset_x + i * screwdriver_hole_spacing,
                            0,
                            screwdriver_rail_position-5
                        ]) {
                            linear_extrude(height = base_thickness + screwdriver_lip_z + 10, center = false)
                                polygon([
                                    [-(screwdriver_rail_cutout_width / 2), offset_y],
                                    [ (screwdriver_rail_cutout_width / 2), offset_y],
                                    [ (cutout_front_width / 2), rail_front_y],
                                    [-(cutout_front_width / 2), rail_front_y]
                                ]);
                        }
                    }
                }
            }
            peg_panel(
                panel_size = panel_size,
                peg_spacing = peg_spacing,
                peg_diameter = peg_diameter,
                hole_diameter = hole_diameter,
                peg_undersize = peg_undersize,
                hole_depth = hole_depth,
                hole_lip = hole_lip,
                peg_offset_x = peg_offset_x,
                peg_offset_z = peg_offset_z
            );
        }

}