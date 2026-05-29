/*

a pegboard with holes for mounting stuff. based on peg panel sizing.

This was within AI's capabilities to generate, so i gave it all the parameters and 
initial code I'd written. After that I told it to modify the code to fix and add screw holes.

*/

module pegboard(
    //default is 1" spaced holes
    panel_size = [
        4, // in PEG SPACE UNITS, not mm
        3.2,  // thickness of the panel, in mm
        2 // in PEG SPACE UNITS, not mm
    ],     
    peg_spacing = 25.4, //distance between peg centres
    hole_diameter = 6.0, //diameter of hole for the peg pin, including the lip, so the peg can fit in.
    screw_holes = true, //whether to include holes for screws to mount the pegboard to the wall
    screw_hole_diameter = 3.7, //diameter of the screw holes. //3.7 for 3.5mm screws
    screw_hole_offset =  peg_spacing / 4, //distance of the screw holes from the edge of the pegboard, in mm
    screw_hole_mount_depth = 3, //depth of the screw holes, in mm, this is the standoff distance from the wall, ZERO means no standoff, just hole.
    screw_hole_mount_wall_thickness = 2.5, //thickness of the wall part of the screw hole, in mm.
    screw_hole_countersink_diameter = 10, //diameter of the countersink for the screw head, in mm, 0 means none.
    screw_hole_countersink_depth = 1.2, //depth of the countersink for the screw head, in mm, 0 means none.
    peg_offset_x = 12.7, //offset of the first peg pin
    peg_offset_z = 12.7, //offset of the first peg pin
    panel_reinforcement = true, //add a grid of lines on the back of the panel, half way between the peg holes
    panel_reinforcement_thickness = 2, //thickness (Z & X axis) of the reinforcement lines, in mm
    panel_reinforcement_depth = 1, //depth of the reinforcement lines, in mm (Y axis)
    panel_undersizing = 0.05 //how much to undersize the panel outer dimensions by, in mm. the same amount is applied to all 4 sides. this is for allowing 2 panels to be placed together without interference.
) {
    width_pegs = max(1, panel_size[0]);
    panel_y = panel_size[1];
    height_pegs = max(1, panel_size[2]);

    // Panel dimensions in mm, with offsets so pegs are not on edges.
    panel_x = (width_pegs - 1) * peg_spacing + 2 * peg_offset_x;
    panel_z = (height_pegs - 1) * peg_spacing + 2 * peg_offset_z;

    peg_count_x = width_pegs;
    peg_count_z = height_pegs;
    screw_positions = [
        [screw_hole_offset, screw_hole_offset],
        [panel_x - screw_hole_offset, screw_hole_offset],
        [screw_hole_offset, panel_z - screw_hole_offset],
        [panel_x - screw_hole_offset, panel_z - screw_hole_offset]
    ];

    difference() {
        union() {
            // Front face is y=0. Panel depth extends toward -y.
            translate([0, -panel_y, 0])
                cube([panel_x, panel_y, panel_z], center = false);

            if (panel_reinforcement && panel_reinforcement_thickness > 0 && panel_reinforcement_depth > 0) {
                // Reinforcement ribs sit halfway between peg holes on the back face.
                for (ix = [0:peg_count_x - 2]) {
                    rib_x = peg_offset_x + (ix + 0.5) * peg_spacing - panel_reinforcement_thickness / 2;

                    translate([rib_x, -panel_y - panel_reinforcement_depth, 0])
                        cube([panel_reinforcement_thickness, panel_reinforcement_depth, panel_z], center = false);
                }

                for (iz = [0:peg_count_z - 2]) {
                    rib_z = peg_offset_z + (iz + 0.5) * peg_spacing - panel_reinforcement_thickness / 2;

                    translate([0, -panel_y - panel_reinforcement_depth, rib_z])
                        cube([panel_x, panel_reinforcement_depth, panel_reinforcement_thickness], center = false);
                }
            }

            if (screw_holes && screw_hole_mount_depth > 0) {
                for (position = screw_positions) {
                    translate([position[0], -panel_y, position[1]])
                        rotate([90, 0, 0])
                            cylinder(
                                d = screw_hole_diameter + 2 * screw_hole_mount_wall_thickness,
                                h = screw_hole_mount_depth
                            );
                }
            }
        }

        // Pegboard holes pass all the way through the panel.
        for (ix = [0:peg_count_x - 1]) {
            for (iz = [0:peg_count_z - 1]) {
                hole_x = peg_offset_x + ix * peg_spacing;
                hole_z = peg_offset_z + iz * peg_spacing;

                translate([hole_x, 1, hole_z])
                    rotate([90, 0, 0])
                        cylinder(d = hole_diameter, h = panel_y + 2);
            }
        }

        if (screw_holes) {
            for (position = screw_positions) {
                translate([position[0], 1, position[1]])
                    rotate([90, 0, 0])
                        cylinder(d = screw_hole_diameter, h = panel_y + screw_hole_mount_depth + 2);

                if (screw_hole_countersink_diameter > screw_hole_diameter && screw_hole_countersink_depth > 0) {
                    translate([position[0], 1, position[1]])
                        rotate([90, 0, 0])
                            cylinder(
                                d1 = screw_hole_countersink_diameter,
                                d2 = screw_hole_diameter,
                                h = screw_hole_countersink_depth + 1
                            );
                }
            }
        }
    }

}