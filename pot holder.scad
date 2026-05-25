// small pot holder that attaches to a pegboard with 1" hole spacing.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/25r00";
**/


include <peg panel.scad>;

$fn = 64;

// dimension of the pot

pot_diameter = 69.2;
pot_height = 80;


// dimensions of the pot holder
pot_holder_height = 10;
pot_holder_base_thickness = 3;
pot_holder_lip = 4;
pot_holder_lip_clearance = 4;



module pot() {
    color("Silver") {
        cylinder(d=pot_diameter, h=pot_height);
    }
}

module pot_holder(
        panel_size = [
            3, // in PEG SPACE UNITS, not mm
            4, // in MM, thickness of the panel
            2 // in PEG SPACE UNITS, not mm
        ],
        peg_spacing = 25.4, //distance between peg centres
        peg_diameter = 4.0, //diameter of the peg pin
        hole_diameter = 6.0, //diameter of the pin part that hooks in the pegboard
        hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
        hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
        peg_offset_x = 12.7, //offset of the first peg pin
        peg_offset_z = 12.7, //offset of the first peg pin 

        outer_dia = 50, //outer diameter of the pot holder, including the lip
        inner_dia = 45,  //inner diameter of the pot holder, where the pot will sit
        height = 10, // height of the pot holder
        base_thickness = 3, //thickness of the base
        offset_y = 5, //offset of the pot holder from the peg panel, in mm
        offset_x = 0, //offset of the pot holder from the side edge of the peg panel, in mm
        base_offset_z = 0, //how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
        front_cutout = true, // whether to cut out the front of the pot holder to make it easier to access the pot, default is 0.25% the diameter of the outer diameter
        number_of_pots = 1 //how many times to multiply the pots in X direction. These will be joined to each other.

    ) {
    difference() {
        union() {
            translate([offset_x, 0, base_offset_z]) {
                    cube([outer_dia, (outer_dia / 2) + offset_y, height]);
            }
            translate([(outer_dia / 2) + offset_x, (outer_dia / 2) + offset_y, base_offset_z]) {
                difference() {
                    cylinder(d=outer_dia, h=height);
                    translate([0, 0, base_thickness]) {
                        cylinder(d=inner_dia, h=height - base_thickness);
                    }
                }
            }
        }
        translate([(outer_dia / 2) + offset_x, (outer_dia / 2) + offset_y, base_thickness+base_offset_z]) {
            cylinder(d=inner_dia, h=height - base_thickness);
        }

        if (front_cutout) {
            translate([
                (outer_dia / 4) + offset_x, 
                (outer_dia / 2) + offset_y, 
                base_offset_z+base_thickness
            ]) {
                cube([
                    (outer_dia / 2), 
                    (outer_dia / 2), 
                    height-base_thickness
                    ], 
                    center = false
                );
            }
        }

    }

}


module pot_holder_assembly(
        panel_size = [
            3, // in PEG SPACE UNITS, not mm
            4, // in MM, thickness of the panel
            2 // in PEG SPACE UNITS, not mm
        ],

        peg_spacing = 25.4, //distance between peg centres
        peg_diameter = 4.0, //diameter of the peg pin
        hole_diameter = 6.0, //diameter of the pin part that hooks in the pegboard
        hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
        hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
        peg_offset_x = 12.7, //offset of the first peg pin
        peg_offset_z = 12.7, //offset of the first peg pin 

        outer_dia = 50, //outer diameter of the pot holder, including the lip
        inner_dia = 45,  //inner diameter of the pot holder, where the pot will sit
        height = 10, // height of the pot holder
        base_thickness = 3, //thickness of the base
        offset_y = 5, //offset of the pot holder from the peg panel, in mm
        offset_x = 0, //offset of the pot holder from the side edge of the peg panel, in mm
        base_offset_z = 0, //how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
        front_cutout = true, // whether to cut out the front of the pot holder to make it easier to access the pot, default is 0.25% the diameter of the outer diameter
        number_of_pots = 1 //how many times to multiply the pots in X direction. These will be joined to each other.
    ) {
/*
This creates a pegboard pot holder with a lip. it is offsett away from the peg panel and joined to it
*/
    union() {
        for (i = [0:number_of_pots-1]) {
            translate([i*outer_dia, 0, 0]) {
                pot_holder(
                    panel_size = panel_size,
                    outer_dia = outer_dia,
                    inner_dia = inner_dia,
                    height = height,
                    base_thickness = base_thickness,
                    offset_y = offset_y,
                    offset_x = offset_x,
                    base_offset_z = base_offset_z,
                    front_cutout = front_cutout,
                    number_of_pots = number_of_pots
                );
            }
        }
        translate([offset_x, 0, base_offset_z]) {
            cube([
                number_of_pots*outer_dia, 
                (outer_dia / 2) + offset_y, 
                base_thickness]);
        }
    }
    peg_panel(panel_size=panel_size);
}
