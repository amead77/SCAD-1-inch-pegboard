//the back panel with pegs for the pegboard.

/**
//next 2 lines used only by my 'on save' script. can be ignored otherwise.
//AUTO-V
version = "v0.1-2026/05/30r34";
**/


module bent_cylinder(d = 6, l1 = 4, l2 = 6, bend_radius = 10, angle = 70, fn = 64) {
/*
    Parametric Bent Cylinder Module
    Gemini created this module.
*/
    // The Fix: Shift everything internally so the first cylinder's base is at [0,0,0]
    translate([-bend_radius, l1, 0]) {
        
        // 1. First Straight Segment
        translate([bend_radius, -l1, 0])
            rotate([-90, 0, 0])
                cylinder(h = l1, d = d, $fn = fn);
        
        // 2. The Revolved Bend
        rotate_extrude(angle = angle, $fn = fn)
            translate([bend_radius, 0, 0])
                circle(d = d, $fn = fn);
        
        // 3. Second Straight Segment
        rotate([0, 0, angle])
            translate([bend_radius, 0, 0])
                rotate([-90, 0, 0])
                    cylinder(h = l2, d = d, $fn = fn);
    }
}

module peg_panel(
    panel_size = [
        4, // in PEG SPACE UNITS, not mm
        20,  // thickness of the panel, in mm
        2 // in PEG SPACE UNITS, not mm
    ], 
    peg_spacing = 25.4, //distance between peg centres
    peg_diameter = 4.0, //diameter of the peg pin
    hole_diameter = 6.0, //diameter of the hole in the pegboard
    peg_undersize = 0.2, //peg undersizing to fit in the hole, in mm. This is subtracted from the hole_diameter
    hole_depth = 3.5, //depth of the peg pin that fits in the pegboard
    hole_lip = 1.5, // depth of the lip that catches inside the pegboard holes
    peg_offset_x = 12.7, //offset of the first peg pin
    peg_offset_z = 12.7, //offset of the first peg pin
    panel_type = "standard", // ["standard", "bent_hook"] type of panel hook, standard or bent hook on top
    bent_peg_radius = 3, // radius of the bend for bent hook pegs, only used if panel_type is "bent_hook"
    bent_peg_angle = 70, // angle of the bend for bent hook pegs
    bent_peg_length_straight1 = 3.5, // length of the straight part of the bent hook peg before the bend
    bent_peg_length_straight2 = 4 // length of the straight part of the hook that curves up
) {
    width_pegs = max(1, panel_size[0]);
    panel_y = panel_size[1];
    height_pegs = max(1, panel_size[2]);

    // Panel dimensions in mm, with offsets so pegs are not on edges. Bent hooks need
    // a smaller top margin that matches the hook's vertical rise above its insertion point.
    panel_x = (width_pegs - 1) * peg_spacing + 2 * peg_offset_x;
    bent_hook_top_rise =peg_diameter /2;// bent_peg_radius * (1 - cos(bent_peg_angle))        + bent_peg_length_straight2 * sin(bent_peg_angle)        + (peg_diameter / 2) * cos(bent_peg_angle);
    top_margin_z = panel_type == "bent_hook"
        ? min(peg_offset_z, bent_hook_top_rise)
        : peg_offset_z;
    panel_z = (height_pegs - 1) * peg_spacing + peg_offset_z + top_margin_z;

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
                    if (panel_type == "bent_hook" && iz == peg_count_z - 1) {
                        // For the top row of pegs, use a bent hook design
                        rotate([180, 90, 0]) {
                            bent_cylinder(d = peg_diameter, l1 = hole_depth, l2 = bent_peg_length_straight2, bend_radius = bent_peg_radius, angle = bent_peg_angle);
                        }
                    } else {
                    rotate([90, 0, 0]) {
                        if (panel_type == "standard") {
                        
                            // shaft: fits into the pegboard hole
                            cylinder(d = peg_diameter, h = hole_depth);
                            //if peg panel type is standard, add a lip, otherwise just a straight peg with no lip
                            // lip: wider tip that catches behind the hole
                            translate([0, -((peg_diameter/4)-peg_undersize/2), hole_depth]) {
                                cylinder(d = hole_diameter - peg_undersize, h = hole_lip);
                            }
                        }
                        if (panel_type == "bent_hook") {
                            // shaft: fits into the pegboard hole
                            cylinder(d = hole_diameter - peg_undersize, h = hole_depth);
                            // lip: wider tip that catches behind the hole
                            translate([0, 0, hole_depth]) {
                                cylinder(d = hole_diameter - peg_undersize, h = hole_lip);
                            }
                        }


                    }
                    }
                }
            }
        }
    }
}



