// small pot holder that attaches to a pegboard with 1" hole spacing.

include <peg panel.scad>;

$fn = 64;

// dimensions of the pegboard holes
hole_diameter = 6.5;
hole_spacing = 25.4; // 1 inch
hole_depth = 3.4;
hole_lip = 1.0; // the lip that holds the peg in place

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

module pot_holder_assembly(
        panel_size = [3, 4, 2], // in PEG SPACE UNITS, not mm
        outer_dia = 50, //outer diameter of the pot holder, including the lip
        inner_dia = 45,  //inner diameter of the pot holder, where the pot will sit
        height = 10, // height of the pot holder
        base_thickness = 3, //thickness of the base
        offset_y = 5, //offset of the pot holder from the peg panel, in mm
        offset_x = 0, //offset of the pot holder from the side edge of the peg panel, in mm
        base_offset_z = 0 //how high above z=0 the base of the pot holder is. this allows the pot holder to be raised above the peg panel if needed, in mm
    ) {
/*
This creates a pegboard pot holder with a lip. it is offsett away from the peg panel and joined to it
*/
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
    }
    peg_panel(panel_size=panel_size);
}
