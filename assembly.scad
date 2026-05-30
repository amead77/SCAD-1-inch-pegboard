/*
this is the assembly view AND the main file that includes all the parts.
Use the customiser in openscad to choose which part, then adjust to suit.
If you don't want 1" spacing you can modify the "peg panel.scad". Or override
the defaults in peg panel.

when designing your own parts, in the assembly view note that the axis x,y is reversed
for the part you are making, because the wall pegs are on the 'front', so 
you're making on the back.
*/


/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/30r128";
**/



include <parts/screwdriver holder.scad>;
include <parts/pot holder.scad>;
include <parts/hooks.scad>;
include <parts/spirit level.scad>;
include <parts/side supports.scad>;
include <parts/pegboard.scad>;
include <parts-viewonly/basic-models.scad>;


/* [Choose part] */
// assembly view all parts are fixed, changing 'which' gives you customising options
which = "assembly"; // ["assembly", "screwdriver_holder", "pot_holder", "hooks", "BOX_and_spirit_level_holder", "side_supports", "pegboard"]

/* [panel sizing, for all] */
//PEG UNITS,            MM,                PEG UNITS
panel_size = [
    3, // in PEG SPACE UNITS, not mm
    4, // thickness of the panel, in mm
    2 // in PEG SPACE UNITS, not mm
];
//distance between peg centres, change this if you don't have 1" pegboard
peg_spacing = 25.4; 
//diameter of the peg pin
peg_diameter = 4.0; 
//diameter of the pin part that hooks in the pegboard
hole_diameter = 6.0; 
//peg undersizing to fit in the hole, in mm. This is subtracted from the hole_diameter
peg_undersize = 0.2;
//depth of the peg pin that fits in the pegboard
hole_depth = 3.5; 
// depth of the lip that catches inside the pegboard holes
hole_lip = 1.5; 
//offset of the first peg pin
peg_offset_x = 12.7; 
//offset of the first peg pin
peg_offset_z = 12.7; 

/* [screwdriver rail specific dimensions] */
//diameter of the screwdriver holder holes.
screwdriver_dia = 3.5;  // 0.1
//thickness of the base
sd_base_thickness = 15;  // 0.1
//offset of the screwdriver holes from the side, in mm
sd_offset_x = 8;  // 0.1
//offset of the screwdriver holder from the peg panel, in mm
sd_offset_y = 20;  // 0.1
//how high above z=0 the screwdriver
screwdriver_rail_position = 10;  // 0.1
//spacing between screwdriver holes
screwdriver_hole_spacing = 20.0;  // 0.1
// chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_width = 1;  // 0.1
// depth of the chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_depth = 5;  // 0.1
// how far the screwdriver holder is offset from the front edge of the peg panel, in mm
sd_front_edge_offset = 5;  // 0.1
// width of the cutout in the base for the screwdriver rail. set to 0 for no cutout. The width will be increased by a chamfer, as the measurement starts from the centre of the hole
sd_screwdriver_rail_cutout_width = 0;  // 0.1 
// angle of the chamfer for the screwdriver rail cutout, in degrees. only used if screwdriver_rail_cutout_width > 0
sd_screwdriver_rail_cutout_chamfer_angle = 20;  // 0.1 
// how high the lip that holds the screwdriver in place is above the base of the holder, in mm. 0 means no lip.
sd_screwdriver_lip_z = 1; 
// how far the lip that holds the screwdriver in place extends in the y axis, in mm. 0 means no lip.
sd_screwdriver_lip_y = 5; 

/* [pot holder specific dimensions] */
// the size of what you want to put in it, plus some clearance
ph_inner_dia = 70;  // 0.1
// choose a value > inner_dia for the outer diameter to create a lip that will hold the pot in place
ph_outer_dia = 74;  // 0.1
// height of the holder that will support the pot
ph_height = 20;  // 0.1
// thickness of the base that the pot sits on, subtracted from height
ph_base_thickness = 5;  // 0.1
// offset of the pot holder from the peg panel, in mm
ph_offset_y = 5;  // 0.1
// offset of the pot holder from the side edge of the peg panel, in mm
ph_offset_x = 0;  // 0.1
// how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
ph_base_offset_z = 0;  // 0.1
//how many times to multiply the pots in X direction. These will be joined to each other.
ph_number_of_pots = 1; 
// whether to cut out the front of the pot holder to make it easier to access the pot, default is 0.25% the diameter of the outer diameter
ph_front_cutout = true; 

/* [hooks specific dimensions] */
// diameter of the hook pin
hook_dia = 6.0; // 0.1
// length of the hook pin
hook_length = 20; // 0.1
// spacing between hooks, in mm
hook_spacing = 30.0; // 0.1
// offset of the hooks from the side, in mm
hook_offset_x = 12.7; // 0.1
// offset of the hooks from the bottom edge of the base
hook_offset_z = 5.0; // 0.1
// hook shape
hook_shape = "cylindrical"; // ["cylindrical", "square"]
//hook tip length, this part is on the end of the hook and points upwards. set to 0 for no tip.
hook_tip_length = 15;

/* [spirit level holder / box specific dimensions] */
// how far the holder is offset from the peg panel, in mm
sl_offset_x = 0.0; // 0.1
// how far the holder is offset from the peg panel, in mm
sl_offset_y = 2;  // 0.1
// how high the holder is offset from the peg panel, in mm. using this AND under_reinforce_size > 0 will create a reinforcement under the level holder of offset_z high
sl_offset_z = 0;  // 0.1
// which side to put a block on the prevent level from sliding out. "left", "right", "both", or "none"
sl_side = "right"; //["left", "right", "both", "none"]
// length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
sl_level_length = 75;  // 0.1
//how deep the level is in the Y axis.
sl_level_depth_y = 22;  // 0.1
//how high the level is in the Z axis. full height not required.
sl_level_height_z = 35;  // 0.1
//thickness of the walls
sl_clamp_thickness = 5;  // 0.1
//number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
sl_num_levels = 2;
//this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.
sl_end_cap = 2;
//reinforcement under the level holder, just a retangle. Set to 0 for no reinforcement, or a value > 0 for the size in mm. Thickness is based on offset_z, so no offset, no reinforcement. recommended to use same size as level length for easier printing
sl_under_reinforce_size = 75;  // 0.1
// offset the reinforcement because adding side caps to one side only will cause offset reinforcement position
sl_under_reinforce_offset_x = 0; // 0.1
// if > 0, (in mm) create a stepped level holder, where each level from the front is lower than the one behind it
sl_step_level = 0; // 0.01

/* [side supports specific dimensions] */
//offset of the support from the side of the panel, in mm
ss_support_offset_left_x = 0; //0.1
ss_support_offset_right_x = 0; //0.1
//offset of the support from the bottom of the panel, in mm
ss_support_offset_z = 0; //0.1
//width of the support in the x axis, in mm
ss_support_width_x = 25; //0.1
//height of the support in the z axis, in mm
ss_support_height_z = 50; //0.1
//thickness of the support, in mm
ss_support_thickness = 5; //0.1
//how far the top inside edge of the angled part is offset from the back panel
ss_support_distance_y_top = 15; //0.1
//how far the bottom inside edge of the angled part is offset from the back panel
ss_support_distance_y_bottom = 5; //0.1
//whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
ss_support_base = true; //[true, false]
//put the support on the left, right, or both sides of the panel
ss_support_side = "both"; //["left", "right", "both"]

/* [Pegboard specific dimensions] */
//default is 1" spaced holes
//screw hole offset is how far in from the edge of the pegboard the screw holes
pb_screw_hole_offset = 5; //0.1
//whether to include holes for screws to mount the pegboard to the wall
pb_screw_holes = true; //[true, false]
//diameter of the screw holes. //3.7 for 3.5mm screws
pb_screw_hole_diameter = 3.7;  //0.1
//depth of the screw holes, in mm, this is the standoff distance from the wall, ZERO means no standoff, just hole.
pb_screw_hole_mount_depth = 3;  //0.1
//thickness of the wall part of the screw hole, in mm.
pb_screw_hole_mount_wall_thickness = 2.5; //0.1
//diameter of the countersink for the screw head, in mm, 0 means none.
pb_screw_hole_countersink_diameter = 10; //0.1
//depth of the countersink for the screw head, in mm, 0 means none.
pb_screw_hole_countersink_depth = 1.2; //0.1
//add a grid of lines on the back of the panel, half way between the peg holes
pb_panel_reinforcement = true; //[true, false]
//thickness (Z & X axis) of the reinforcement lines, in mm
pb_panel_reinforcement_thickness = 2; //0.1
//depth of the reinforcement lines, in mm (Y axis)
pb_panel_reinforcement_depth = 1; //0.1
//how much to undersize the panel outer dimensions by, in mm. the same amount is applied to all 4 sides. this is for allowing 2 panels to be placed together without interference.
pb_panel_undersizing = 0.05; //0.1



//function to give pegboard units in mm, for positioning parts in the assembly view
function pegboard_units_to_mm(units) = units * peg_spacing;


module assembly() {
/* the assembly view parts are fixed size and posiotion */    
    color("lightblue") { //pegboard accessories in light blue for visibility
        translate([0, 0, 0]) {
            screwdriver_holder_assembly(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ],
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                screwdriver_dia = 10, 
                screwdriver_rail_cutout_width = sd_screwdriver_rail_cutout_width, // width of the cutout in the base for the screwdriver rail. set to 0 for no cutout.
                screwdriver_rail_cutout_chamfer_angle = sd_screwdriver_rail_cutout_chamfer_angle, // angle of the chamfer for the screwdriver rail cutout, in degrees. only used if screwdriver_rail_cutout_width > 0

                base_thickness = 10, 
                offset_x = 10, 
                offset_y = 25,
                front_edge_offset = 5,
                screwdriver_rail_position = 15,
                screwdriver_hole_spacing = 25,
                screwdriver_hole_chamfer_width = 1, // chamfer for the screwdriver holes
                screwdriver_hole_chamfer_depth = 5 // depth of the chamfer for the screwdriver holes
            );
        }
        translate([pegboard_units_to_mm(4), 0, 0]) {
            pot_holder_assembly(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ],
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                inner_dia = 70, 
                outer_dia = 74, 
                height = 20, 
                base_thickness = 5, 
                offset_y = 5,
                offset_x = 0,
                base_offset_z = 0,
                front_cutout = true,
                number_of_pots = 1
            );
        }
        translate([pegboard_units_to_mm(8), 0, 0]) {
            hook_rail(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                hook_dia = 6.0, 
                hook_length = 20, 
                spacing = 30.0,
                offset_x = 5,
                offset_z = 5.0,
                hook_shape = "cylindrical"
            );
        }
        translate([pegboard_units_to_mm(4), 0, pegboard_units_to_mm(7)]) {
            hook_rail(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    1 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                hook_dia = 6.0, 
                hook_length = 20, 
                spacing = 30.0,
                offset_x = 5,
                offset_z = 0.0,
                hook_shape = "square"
            );
        }
        translate([pegboard_units_to_mm(0), 0, pegboard_units_to_mm(4)]) {
            spirit_level_holder(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                offset_y = 1, // how far the holder is offset from the peg panel, in mm
                side = "right",
                level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
                level_depth_y = 22, //how deep the level is in the Y axis.
                level_height_z = 35, //how high the level is in the Z axis. full height not required.
                clamp_thickness = 5, //thickness of the walls
                num_levels = 2, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
                end_cap = 2 //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.

            );
        }
        translate([pegboard_units_to_mm(7), 0, pegboard_units_to_mm(4)]) {
            spirit_level_holder(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                offset_y = 1, // how far the holder is offset from the peg panel, in mm
                side = "left",
                level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
                level_depth_y = 22, //how deep the level is in the Y axis.
                level_height_z = 35, //how high the level is in the Z axis. full height not required.
                clamp_thickness = 5, //thickness of the walls
                num_levels = 2, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
                end_cap = 1 //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.

            );
        }
        translate([pegboard_units_to_mm(17), 0, pegboard_units_to_mm(4)]) {
            spirit_level_holder(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                offset_y = 1, // how far the holder is offset from the peg panel, in mm
                side = "left",
                level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
                level_depth_y = 22, //how deep the level is in the Y axis.
                level_height_z = 35, //how high the level is in the Z axis. full height not required.
                clamp_thickness = 5, //thickness of the walls
                num_levels = 1, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
                end_cap = 1 //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.

            );
        }
        translate([pegboard_units_to_mm(0), 0, pegboard_units_to_mm(7)]) {
            spirit_level_holder(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    3 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                offset_y = 1, // how far the holder is offset from the peg panel, in mm
                side = "both",
                level_length = 75, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
                level_depth_y = 75, //how deep the level is in the Y axis.
                level_height_z = 45, //how high the level is in the Z axis. full height not required.
                clamp_thickness = 3, //thickness of the walls
                num_levels = 1, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
                end_cap = 1 //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.

            );
        }
        translate([pegboard_units_to_mm(8), 0, pegboard_units_to_mm(7)]) {
            screwdriver_holder_assembly(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ],
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                
                screwdriver_dia = 10, 
                screwdriver_rail_cutout_width = 3, // width of the cutout in the base for the screwdriver rail. set to 0 for no cutout.
                screwdriver_rail_cutout_chamfer_angle = 10, // angle of the chamfer for the screwdriver rail cutout, in degrees. only used if screwdriver_rail_cutout_width > 0

                base_thickness = 20, 
                offset_x = 10, 
                offset_y = 25,
                front_edge_offset = 5,
                screwdriver_rail_position = 0,
                screwdriver_hole_spacing = 25,
                screwdriver_hole_chamfer_width = 1, // chamfer for the screwdriver holes
                screwdriver_hole_chamfer_depth = 5, // depth of the chamfer for the screwdriver holes
                screwdriver_lip_z = 1, // how high the lip that holds the screwdriver in place is above the base of the holder, in mm. 0 means no lip.
                screwdriver_lip_y = 5 // how far the lip that holds the screwdriver in place extends in the y axis, in mm. 0 means no lip.
            );
        }
        translate([pegboard_units_to_mm(12), 0, pegboard_units_to_mm(7)]) {
            side_support(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             

                support_offset_left_x = 0, //offset of the support from the left side of the panel, in mm
                support_offset_right_x = 0, //offset of the support from the right side of
                support_offset_z = 0, //offset of the support from the top of the panel, in mm
                support_width_x = 30, //width of the support in the x axis, in mm
                support_height_z = 20, //height of the support in the z axis, in mm
                support_thickness = 5, //thickness of the support, in mm
                support_distance_y_top = 15, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
                support_distance_y_bottom = 5, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
                support_base = true, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
                support_side = "both" //["left", "right", "both"]
            );
        }
        translate([pegboard_units_to_mm(13), 0, pegboard_units_to_mm(0)]) {
            side_support(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             

                support_offset_left_x = 0, //offset of the support from the left side of the panel, in mm
                support_offset_right_x = 0, //offset of the support from the right side of
                support_offset_z = 0, //offset of the support from the top of the panel, in mm
                support_width_x = 50, //width of the support in the x axis, in mm
                support_height_z = 50, //height of the support in the z axis, in mm
                support_thickness = 5, //thickness of the support, in mm
                support_distance_y_top = 25, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
                support_distance_y_bottom = 15, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
                support_base = false, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
                support_side = "right" //["left", "right", "both"]
            );
        }
        translate([pegboard_units_to_mm(17), 0, pegboard_units_to_mm(0)]) {
            side_support(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             

                support_offset_left_x = 0, //offset of the support from the left side of the panel, in mm
                support_offset_right_x = 0, //offset of the support from the right side of
                support_offset_z = 0, //offset of the support from the top of the panel, in mm
                support_width_x = 50, //width of the support in the x axis, in mm
                support_height_z = 50, //height of the support in the z axis, in mm
                support_thickness = 5, //thickness of the support, in mm
                support_distance_y_top = 25, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
                support_distance_y_bottom = 15, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
                support_base = false, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
                support_side = "left" //["left", "right", "both"]
            );
        }
        translate([pegboard_units_to_mm(17), 0, pegboard_units_to_mm(7)]) {
            spirit_level_holder(
                panel_size = [
                    3, // in PEG SPACE UNITS, not mm
                    4, // thickness of the panel, in mm
                    2 // in PEG SPACE UNITS, not mm
                ], 
                peg_spacing = peg_spacing, //distance between peg centres
                peg_diameter = peg_diameter, //diameter of the peg pin
                hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
                hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
                hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
                peg_offset_x = peg_offset_x, //offset of the first peg pin
                peg_offset_z = peg_offset_z, //offset of the first peg pin             
                offset_y = 1, // how far the holder is offset from the peg panel, in mm
                side = "both",
                level_length = 95, // length of the spirit level to hold, in mm, not necessarily the same as the actual level, as the full length doesn't need supporting.
                level_depth_y = 10, //how deep the level is in the Y axis.
                level_height_z = 8, //how high the level is in the Z axis. full height not required.
                offset_x = -10, // how far from the front edge of the panel the level holder is, in mm
                clamp_thickness = 2, //thickness of the walls
                num_levels = 2, // number of levels to hold, they will be spaced evenly along the Y axis, so they protrude outwards.
                end_cap = 2, //this is how many of the levels have end caps on one side if side <> "none". Always from the outer level inwards.
                step_level = 5 //if > 0, (in mm) create a stepped level holder, where each level from the front is lower than the one behind it
            );
        }

    }
    color("red") { //pegboard in red for visibility
        translate([0, -4, 0]) {
            pegboard(panel_size = [
                20, // in PEG SPACE UNITS, not mm
                3.2, // thickness of the panel, in mm
                10 // in PEG SPACE UNITS, not mm
                ],
                screw_hole_offset = 5
            );
        }
    }

    //spirit levels for showing in the holders
    translate([5, 6, 110]) {
        spirit_level(width = 500, depth = 20);
    }
    translate([5, 35, 110]) {
        spirit_level(width = 240, depth = 20);
    }
    //screwdrivers for showing in the holders
    translate([238, 25, 152]) {
        screwdriver(handlelen = 75);
    }
    translate([263, 25, 152]) {
        screwdriver(handlelen = 75);
    }
    translate([138, 42, 6]) {
        pot(height = 70, dia = 68);
    }
    translate([423.5, 4, 186]) {
        bit_holder(bitlen = 40);
    }
    translate([423.5, 16, 181]) {
        bit_holder(bitlen = 20);
    }

    translate([283, 5, 18]) {
        rotate([0, 90, 90]) {
            spanner();
        }
    }

} //end assembly view

if (which == "screwdriver_holder") {
    render() {
        screwdriver_holder_assembly(
            panel_size = panel_size,  
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin             
            screwdriver_dia = screwdriver_dia, 
            screwdriver_rail_cutout_width = sd_screwdriver_rail_cutout_width, // width of the cutout in the base for the screwdriver rail. set to 0 for no cutout.
            screwdriver_rail_cutout_chamfer_angle = sd_screwdriver_rail_cutout_chamfer_angle, // angle of the chamfer for the screwdriver rail cutout, in degrees. only used if screwdriver_rail_cutout_width > 0

            base_thickness = sd_base_thickness, 
            offset_x = sd_offset_x, 
            offset_y = sd_offset_y,
            front_edge_offset = sd_front_edge_offset,
            screwdriver_rail_position = screwdriver_rail_position,
            screwdriver_hole_spacing = screwdriver_hole_spacing,
            screwdriver_hole_chamfer_width = screwdriver_hole_chamfer_width,
            screwdriver_hole_chamfer_depth = screwdriver_hole_chamfer_depth,
            screwdriver_lip_y = sd_screwdriver_lip_y,
            screwdriver_lip_z = sd_screwdriver_lip_z,
        );
    }
} else if (which == "pot_holder") {
    render() {
        pot_holder_assembly(
            panel_size=panel_size,
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin             
            inner_dia = ph_inner_dia, 
            outer_dia = ph_outer_dia, 
            height = ph_height, 
            base_thickness = ph_base_thickness, 
            offset_y = ph_offset_y, 
            offset_x = ph_offset_x, 
            base_offset_z = ph_base_offset_z, 
            front_cutout = ph_front_cutout,
            number_of_pots = ph_number_of_pots
        );
    }
} else if (which == "assembly") {
    render() {
        assembly();
    }
} else if (which == "hooks") {
    render() {
        hook_rail(
            panel_size = panel_size, 
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin             
            hook_dia = hook_dia, 
            hook_length = hook_length, 
            spacing = hook_spacing,
            offset_x = hook_offset_x,
            offset_z = hook_offset_z,
            hook_shape = hook_shape,
            hook_tip_length = hook_tip_length
        );
    }
} else if (which == "BOX_and_spirit_level_holder") {
    render() {
        spirit_level_holder(
            panel_size = panel_size,
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin             
            offset_x = sl_offset_x,
            offset_y = sl_offset_y, 
            offset_z = sl_offset_z,
            side = sl_side,
            level_length = sl_level_length,
            level_depth_y = sl_level_depth_y,
            level_height_z = sl_level_height_z,
            clamp_thickness = sl_clamp_thickness,
            num_levels = sl_num_levels,
            end_cap = sl_end_cap,
            under_reinforce_size = sl_under_reinforce_size,
            under_reinforce_offset_x = sl_under_reinforce_offset_x,
            step_level = sl_step_level
        );
    }
} else if (which == "side_supports") {
    render() {
        side_support(
            panel_size = panel_size,
            peg_spacing = peg_spacing, //distance between peg centres
            peg_diameter = peg_diameter, //diameter of the peg pin
            hole_diameter = hole_diameter, //diameter of the pin part that hooks in the pegboard
            hole_depth = hole_depth, //depth of the peg pin that fits in the pegboard
            hole_lip = hole_lip, // depth of the lip that catches inside the pegboard holes
            peg_offset_x = peg_offset_x, //offset of the first peg pin
            peg_offset_z = peg_offset_z, //offset of the first peg pin             

            support_offset_left_x = ss_support_offset_left_x, //offset of the support from the left side of the panel, in mm
            support_offset_right_x = ss_support_offset_right_x, //offset of the support from the right side of the panel, in mm
            support_offset_z = ss_support_offset_z, //offset of the support from the top of the panel, in mm
            support_width_x = ss_support_width_x, //width of the support in the x axis, in mm
            support_height_z = ss_support_height_z, //height of the support in the z axis, in mm
            support_thickness = ss_support_thickness, //thickness of the support, in mm
            support_distance_y_bottom = ss_support_distance_y_bottom, //distance of the front inside edge of the support from the front edge of the peg panel, in mm
            support_distance_y_top = ss_support_distance_y_top, //distance of the back inside edge of the support from the back edge of the peg panel, in mm
            support_base = ss_support_base, //whether to include the base of the support that attaches to the peg panel. if false, only the vertical part of the support is included.
            support_side = ss_support_side
        );
    }
} else if (which == "pegboard") {
    render() {
        pegboard(
            panel_size = panel_size,
            screw_hole_offset = pb_screw_hole_offset,
            screw_holes = pb_screw_holes,
            screw_hole_diameter = pb_screw_hole_diameter,
            screw_hole_mount_depth = pb_screw_hole_mount_depth,
            screw_hole_mount_wall_thickness = pb_screw_hole_mount_wall_thickness,
            screw_hole_countersink_diameter = pb_screw_hole_countersink_diameter,
            screw_hole_countersink_depth = pb_screw_hole_countersink_depth,
            peg_offset_x = peg_offset_x,
            peg_offset_z = peg_offset_z,
            panel_reinforcement = pb_panel_reinforcement,
            panel_reinforcement_thickness = pb_panel_reinforcement_thickness,
            panel_reinforcement_depth = pb_panel_reinforcement_depth,
            panel_undersizing = pb_panel_undersizing            
        );
    }
}
