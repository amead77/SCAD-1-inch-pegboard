
/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/16r18";
**/



include <screwdriver holder.scad>;
include <pot holder.scad>;

/* [Choose part] */
// assembly view all parts are fixed, changing 'which' gives you customising options
which = "assembly"; // ["screwdriver_holder", "pot_holder", "assembly"]

/* [panel sizing, for all] */
//PEG UNITS,            MM,                PEG UNITS
panel_size = [
    3, // in PEG SPACE UNITS, not mm
    4, // thickness of the panel, in mm
    2 // in PEG SPACE UNITS, not mm
];

/* [screwdriver rail specific dimensions] */
//diameter of the screwdriver holder holes.
screwdriver_dia = 4; 
//thickness of the base
sd_base_thickness = 15; 
//offset of the screwdriver holes from the side, in mm
offset_x = 8; 
//offset of the screwdriver holder from the peg panel, in mm
offset_y = 20; 
//how high above z=0 the screwdriver
screwdriver_rail_position = 10; 
//spacing between screwdriver holes
screwdriver_hole_spacing = 20.0; 
// chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_width = 1; 
// depth of the chamfer for the screwdriver holes, in mm
screwdriver_hole_chamfer_depth = 5; 
// how far the screwdriver holder is offset from the front edge of the peg panel, in mm
front_edge_offset = 5; 

/* [pot holder specific dimensions] */
// the size of what you want to put in it, plus some clearance
inner_dia = 70;
// choose a value > inner_dia for the outer diameter to create a lip that will hold the pot in place
outer_dia = 74;
// height of the holder that will support the pot
height = 20;
// thickness of the base that the pot sits on, subtracted from height
ph_base_thickness = 5;
// offset of the pot holder from the peg panel, in mm
ph_offset_y = 5;
// offset of the pot holder from the side edge of the peg panel, in mm
ph_offset_x = 0;
// how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
ph_base_offset_z = 0;
//how many times to multiply the pots in X direction. These will be joined to each other.
number_of_pots = 1; 


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
            number_of_pots = 1
        );
    }
}

if (which == "screwdriver_holder") {
    screwdriver_holder_assembly(
        panel_size = panel_size,  
        screwdriver_dia = screwdriver_dia, 
        base_thickness = sd_base_thickness, 
        offset_x = offset_x, 
        offset_y = offset_y,
        front_edge_offset = front_edge_offset,
        screwdriver_rail_position = screwdriver_rail_position,
        screwdriver_hole_spacing = screwdriver_hole_spacing,
        screwdriver_hole_chamfer_width = screwdriver_hole_chamfer_width,
        screwdriver_hole_chamfer_depth = screwdriver_hole_chamfer_depth
    );
} else if (which == "pot_holder") {
    pot_holder_assembly(
        panel_size=panel_size,
        inner_dia = inner_dia, 
        outer_dia = outer_dia, 
        height = height, 
        base_thickness = ph_base_thickness, 
        offset_y = ph_offset_y, 
        offset_x = ph_offset_x, 
        base_offset_z = ph_base_offset_z, 
        number_of_pots = number_of_pots
    );
} else if (which == "assembly") {
    assembly();
}