/*

A spirit level holder for moi pegboard

*/

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/25r24";
**/

include <hooks.scad>;
$fn = 64;


module basic_level_holder(
    level_length = 150, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
    level_depth_y = 22, //how deep the level is in the Y axis.
    level_height_z = 35, //how high the level is in the Z axis. full height not required.
    clamp_thickness = 5, //thickness of the walls that hold the spirit level in place
    side = "none" //"left", "right", or "none" - which side to put a block on the prevent level from sliding out.
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
            if (side == "left") {
                translate([0, clamp_thickness, clamp_thickness]) {
                    cube([clamp_thickness, level_depth_y, level_height_z], center = false);
                }
            } else if (side == "right") {
                translate([level_length - clamp_thickness, clamp_thickness, clamp_thickness]) {
                    cube([clamp_thickness, level_depth_y, level_height_z], center = false);
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
    offset_y = 2, // how far the holder is offset from the peg panel, in mm
    side = "none", //"left", "right", or "none" - which side to put a block on the prevent level from sliding out.
    level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
    level_depth_y = 22, //how deep the level is in the Y axis.
    level_height_z = 35, //how high the level is in the Z axis. full height not required.
    clamp_thickness = 5, //thickness of the walls
    num_levels = 2, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
    end_cap = 2 //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.
) {

    union() {
        // Peg panel with holes for mounting on the pegboard
        peg_panel(panel_size = panel_size);
        
        if (offset_y != 0) {
            //create the offset part that joins the level holder to the peg panel
            translate([0, 0, 0]) {
                cube([
                    panel_size[0] * 25.4, // width of the panel in mm
                    offset_y, // depth of the offset
                    level_height_z+clamp_thickness // height of the panel in mm
                ], center = false);
            }
        }

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
    }
}