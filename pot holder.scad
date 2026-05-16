// small pot holder that attaches to a pegboard with 1" hole spacing.


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



module peg_panel(
    panel_size = [
        4, // in PEG SPACE UNITS, not mm
        20,  // thickness of the panel, in mm
        2 // in PEG SPACE UNITS, not mm
    ], 
    peg_spacing = 25.4, //distance between peg centres
    peg_diameter = 4.0, //diameter of the peg pin
    hole_diameter = 6.0, //diameter of the pin part that hooks in the pegboard
    hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
    hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
    peg_offset_x = 12.7, //offset of the first peg pin
    peg_offset_z = 12.7 //offset of the first peg pin
) {
    width_pegs = max(1, panel_size[0]);
    panel_y = panel_size[1];
    height_pegs = max(1, panel_size[2]);

    // Panel dimensions in mm, with offsets so pegs are not on edges.
    panel_x = (width_pegs - 1) * peg_spacing + 2 * peg_offset_x;
    panel_z = (height_pegs - 1) * peg_spacing + 2 * peg_offset_z;

    peg_count_x = width_pegs;
    peg_count_z = height_pegs;

    union() {
        // Front face is y=0. Panel depth extends toward -y.
        translate([0, -panel_y, 0])
            cube([panel_x, panel_y, panel_z], center = false);

        // Pegs on the back face (y = -panel_y), extending toward -y.
        for (ix = [0:peg_count_x - 1]) {
            for (iz = [0:peg_count_z - 1]) {
                peg_x = peg_offset_x + ix * peg_spacing;
                peg_z = peg_offset_z + iz * peg_spacing;

                translate([peg_x, -panel_y, peg_z]) {
                    rotate([90, 0, 0]) {
                        // shaft: fits into the pegboard hole
                        cylinder(d = peg_diameter, h = hole_depth);
                        // lip: wider tip that catches behind the hole
                        translate([0, -(peg_diameter/4), hole_depth])
                            cylinder(d = hole_diameter, h = hole_lip);
                    }
                }
            }
        }
    }
}

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
        offset_y = 5 //offset of the pot holder from the peg panel, in mm
    ) {
/*
This creates a pegboard pot holder with a lip. it is offsett away from the peg panel and joined to it
*/
    difference() {
        union() {
            cube([outer_dia, (outer_dia / 2) + offset_y, height]);
            translate([outer_dia / 2, (outer_dia / 2) + offset_y, 0]) {
                difference() {
                    cylinder(d=outer_dia, h=height);
                    translate([0, 0, base_thickness]) {
                        cylinder(d=inner_dia, h=height - base_thickness);
                    }
                }
            }
        }
        translate([outer_dia / 2, (outer_dia / 2) + offset_y, base_thickness]) {
            cylinder(d=inner_dia, h=height - base_thickness);
        }
    }
    peg_panel(panel_size=panel_size);
}



pot_holder_assembly(panel_size=[3, 3, 2],inner_dia = 70, outer_dia = 74, height = 20, base_thickness = 5, offset_y = 5);

translate([74/2, (74/2) + 5, 5]) {
    pot();
}
