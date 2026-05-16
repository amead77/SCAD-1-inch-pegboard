//the back panel with pegs for the pegboard.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/16r02";
**/



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