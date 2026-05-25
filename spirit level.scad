/*

A spirit level holder for moi pegboard

*/

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/25r71";
**/

include <hooks.scad>;
$fn = 64;


module basic_level_holder(
    level_length = 150, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
    level_depth_y = 22, //how deep the level is in the Y axis.
    level_height_z = 35, //how high the level is in the Z axis. full height not required.
    clamp_thickness = 5, //thickness of the walls that hold the spirit level in place
    side = "none" //"left", "right", "both", or "none" - which side to put a block on the prevent level from sliding out.
) {
    union() {
        difference() {
            //create the outer size
            cube([
                level_length, 
                clamp_thickness+level_depth_y+clamp_thickness, 
                clamp_thickness+level_height_z
                ], center = false
            );
            //now cut out the inner space for the level
            translate([-0.001, clamp_thickness, clamp_thickness]) {
                cube([
                    level_length+0.002, 
                    level_depth_y, 
                    level_height_z+0.001
                    ], center = false
                );

            }
        } //difference
        // if side is not "none", add a block to the specified side.
        if (side != "none") {
            if ((side == "left") || (side == "both")) {
                translate([-clamp_thickness, 0, 0]) {
                    cube([clamp_thickness, level_depth_y+(2 * clamp_thickness), level_height_z+clamp_thickness], center = false);
                }
            }
            if ((side == "right") || (side == "both")) {
                translate([level_length, 0, 0]) {
                    cube([clamp_thickness, level_depth_y+(2 * clamp_thickness), level_height_z+clamp_thickness], center = false);
                }
            }
        }
    }
}


module spirit_level_holder(
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
    offset_x = 0, //how far across the holder is from the edge of the panel, in mm. if not specified, it will be centered.
    offset_y = 2, // how far the holder is offset from the peg panel, in mm
    offset_z = 0, // how high the holder is offset from the peg panel, in mm
    side = "none", //"left", "right", "both", or "none" - which side to put a block on the prevent level from sliding out.
    level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
    level_depth_y = 22, //how deep the level is in the Y axis.
    level_height_z = 35, //how high the level is in the Z axis. full height not required.
    clamp_thickness = 5, //thickness of the walls
    num_levels = 2, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
    end_cap = 2, //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.
    under_reinforce_size = 0 // if > 0, creates a reinforcement under the level holder, just a retangle that is reinforce width, but offset_z high
) {

    union() {
        // Peg panel with holes for mounting on the pegboard
        peg_panel(
            panel_size = panel_size,
            peg_spacing = peg_spacing,
            peg_diameter = peg_diameter,
            hole_diameter = hole_diameter,
            hole_depth = hole_depth,
            hole_lip = hole_lip,
            peg_offset_x = peg_offset_x,
            peg_offset_z = peg_offset_z
        );
        if (offset_x != 0) {
            //use the specified offset, but make sure it's not too big or small
            offset_x = max(0, min(offset_x, (panel_size[0] * 25.4) - level_length));
        }
        if (offset_y != 0) {
            //create the offset part that joins the level holder to the peg panel
            translate([0, 0, offset_z]) {
                cube([
                    panel_size[0] * 25.4, // width of the panel in mm
                    offset_y, // depth of the offset
                    level_height_z+clamp_thickness // height of the panel in mm
                ], center = false);
            }

        }

//        for (i = [0:num_levels - 1]) {
        for (i = [num_levels - 1:-1:0]) {
            //create the level holders, spaced evenly along the Y axis
            translate([offset_x, offset_y + i * (level_depth_y + clamp_thickness), offset_z]) {
                basic_level_holder(
                    level_length = level_length,
                    level_depth_y = level_depth_y,
                    level_height_z = level_height_z,
                    clamp_thickness = clamp_thickness,
                    //side = (i < end_cap) ? side : "none" // add end caps to the specified number of levels
                    side = ((i >= (end_cap-1)-(num_levels-1)) && (i > (num_levels - end_cap - 1))) ? side : "none" // add end caps to the specified number of levels
                );
            }
        }
        
        if (under_reinforce_size > 0 && offset_z > 0) {
            // add a reinforcement under the level holder, just a rectangle that is under_reinforce_size wide, but offset_z high
            translate([offset_x + (level_length/2)-(under_reinforce_size/2), 0, 0]) {
                cube([
                    under_reinforce_size, 
                    clamp_thickness+offset_y + (num_levels * (level_depth_y + clamp_thickness)),
                    offset_z
                    ], center = false
                );
            }
        }


/*        
        //create the level holder
        translate([0,offset_y, 0]) {
            basic_level_holder(
                level_length = level_length,
                level_depth_y = level_depth_y,
                level_height_z = level_height_z,
                clamp_thickness = clamp_thickness,
                side = side
            );
        }
*/
    }

}