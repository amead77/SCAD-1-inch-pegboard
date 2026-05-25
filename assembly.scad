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
version = "v0.1-2026/05/25r07";
**/



include <screwdriver holder.scad>;
include <pot holder.scad>;
include <hooks.scad>;
include <spirit level.scad>;

/* [Choose part] */
// assembly view all parts are fixed, changing 'which' gives you customising options
which = "assembly"; // ["screwdriver_holder", "pot_holder", "assembly", "hooks"]

/* [panel sizing, for all] */
//PEG UNITS,            MM,                PEG UNITS
panel_size = [
    3, // in PEG SPACE UNITS, not mm
    4, // thickness of the panel, in mm
    2 // in PEG SPACE UNITS, not mm
];

/* [screwdriver rail specific dimensions] */
//diameter of the screwdriver holder holes.
screwdriver_dia = 3.5; 
//thickness of the base
sd_base_thickness = 15; 
//offset of the screwdriver holes from the side, in mm
sd_offset_x = 8; 
//offset of the screwdriver holder from the peg panel, in mm
sd_offset_y = 20; 
//how high above z=0 the screwdriver
screwdriver_rail_position = 10; 
//spacing between screwdriver holes
screwdriver_hole_spacing = 20.0; 
// chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_width = 1; 
// depth of the chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_depth = 5; 
// how far the screwdriver holder is offset from the front edge of the peg panel, in mm
sd_front_edge_offset = 5; 

/* [pot holder specific dimensions] */
// the size of what you want to put in it, plus some clearance
ph_inner_dia = 70;
// choose a value > inner_dia for the outer diameter to create a lip that will hold the pot in place
ph_outer_dia = 74;
// height of the holder that will support the pot
ph_height = 20;
// thickness of the base that the pot sits on, subtracted from height
ph_base_thickness = 5;
// offset of the pot holder from the peg panel, in mm
ph_offset_y = 5;
// offset of the pot holder from the side edge of the peg panel, in mm
ph_offset_x = 0;
// how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
ph_base_offset_z = 0;
//how many times to multiply the pots in X direction. These will be joined to each other.
ph_number_of_pots = 1; 
// whether to cut out the front of the pot holder to make it easier to access the pot, default is 0.25% the diameter of the outer diameter
ph_front_cutout = true; 

/* [hooks specific dimensions] */
// diameter of the hook pin
hook_dia = 6.0;
// length of the hook pin
hook_length = 20;
// spacing between hooks, in mm
hook_spacing = 30.0;
// offset of the hooks from the side, in mm
hook_offset_x = 12.7;
// offset of the hooks from the bottom edge of the base
hook_offset_z = 5.0;
// hook shape
hook_shape = "cylindrical"; // ["cylindrical", "square"]
//hook tip length, this part is on the end of the hook and points upwards. set to 0 for no tip.
hook_tip_length = 15;


module assembly() {
/* the assembly view parts are fixed size and posiotion */    
    translate([0, 0, 0]) {
        screwdriver_holder_assembly(
            panel_size = [
                3, // in PEG SPACE UNITS, not mm
                4, // thickness of the panel, in mm
                2 // in PEG SPACE UNITS, not mm
            ],
            screwdriver_dia = 10, 
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
    translate([100, 0, 0]) {
        pot_holder_assembly(
            panel_size = [
                3, // in PEG SPACE UNITS, not mm
                4, // thickness of the panel, in mm
                2 // in PEG SPACE UNITS, not mm
            ],
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
    translate([200, 0, 0]) {
        hook_rail(
            panel_size = [
                3, // in PEG SPACE UNITS, not mm
                4, // thickness of the panel, in mm
                2 // in PEG SPACE UNITS, not mm
            ], 
            hook_dia = 6.0, 
            hook_length = 20, 
            spacing = 30.0,
            offset_x = 5,
            offset_z = 5.0,
            hook_shape = "cylindrical"
        );
    }
    translate([300, 0, 0]) {
        spirit_level_holder(
            panel_size = [
                3, // in PEG SPACE UNITS, not mm
                4, // thickness of the panel, in mm
                2 // in PEG SPACE UNITS, not mm
            ], 
            offset_y = 1, // how far the holder is offset from the peg panel, in mm
            side = "right"
        );
    }



}

if (which == "screwdriver_holder") {
    render() {
        screwdriver_holder_assembly(
            panel_size = panel_size,  
            screwdriver_dia = screwdriver_dia, 
            base_thickness = sd_base_thickness, 
            offset_x = sd_offset_x, 
            offset_y = sd_offset_y,
            front_edge_offset = sd_front_edge_offset,
            screwdriver_rail_position = screwdriver_rail_position,
            screwdriver_hole_spacing = screwdriver_hole_spacing,
            screwdriver_hole_chamfer_width = screwdriver_hole_chamfer_width,
            screwdriver_hole_chamfer_depth = screwdriver_hole_chamfer_depth
        );
    }
} else if (which == "pot_holder") {
    render() {
        pot_holder_assembly(
            panel_size=panel_size,
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
            hook_dia = hook_dia, 
            hook_length = hook_length, 
            spacing = hook_spacing,
            offset_x = hook_offset_x,
            offset_z = hook_offset_z,
            hook_shape = hook_shape,
            hook_tip_length = hook_tip_length
        );
    }
}