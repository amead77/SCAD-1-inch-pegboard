include <screwdriver holder.scad>;
include <pot holder.scad>;

/* [Choose part] */
which = "assembly"; // ["screwdriver_holder", "pot_holder", "assembly"]

/* [panel sizing, for all] */
//PEG UNITS,            MM,                PEG UNITS
panel_size = [
    3, // in PEG SPACE UNITS, not mm
    4, // thickness of the panel, in mm
    2 // in PEG SPACE UNITS, not mm
];

/* [screwdriver rail specific dimensions] */
screwdriver_dia = 4; //diameter of the screwdriver holder holes.
sd_base_thickness = 15; //thickness of the base
offset_x = 8; //offset of the screwdriver holes from the side, in mm
offset_y = 20; //offset of the screwdriver holder from the peg panel, in mm
screwdriver_rail_position = 10; //how high above z=0 the screwdriver
screwdriver_hole_spacing = 20.0; //spacing between screwdriver holes

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
            offset_y = 10,
            screwdriver_rail_position = 15,
            screwdriver_hole_spacing = 25
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
            offset_x = 0
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
        screwdriver_rail_position = screwdriver_rail_position,
        screwdriver_hole_spacing = screwdriver_hole_spacing
    );
} else if (which == "pot_holder") {
    pot_holder_assembly(panel_size=panel_size,inner_dia = inner_dia, outer_dia = outer_dia, height = height, base_thickness = ph_base_thickness, offset_y = ph_offset_y, offset_x = ph_offset_x, base_offset_z = ph_base_offset_z);
} else if (which == "assembly") {
    assembly();
}