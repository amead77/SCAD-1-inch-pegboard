/*
just very basic models of stuff, for showing in the pegboard assembly. Not for printing.
*/
$fn = 64;

module spirit_level(width = 150, depth = 22, height = 35) {
    color("Yellow") {
        cube([width, depth, height], center = false);
    }
    translate([(width/2)-10, -1, height-10]) {
        color("green") {
            cube([20, depth+2, 11]);
        }
    }
}

module screwdriver(handlelen = 100, handle_dia = 20, shaft_len = 50, shaft_dia = 5) {
    union() {
        translate([0, 0, shaft_len]) {
            color("orange") {
                cylinder(d=handle_dia, h=handlelen);
            }
        }
        color("gray") {
            cylinder(d=shaft_dia, h=shaft_len);
        }
    }

}

module pot(height = 50, dia = 50) {
    color("white", 0.5) {
        cylinder(d=dia, h=height-10);
    }
    translate([0, 0, height-10]) {
        color("orange") {
            cylinder(d=dia, h=10);
        }
    }
}

module screwdriver_bits(bit_len = 20, bit_dia = 7.5) {
    color("lightgrey") {
        cylinder(d=bit_dia, h=bit_len, $fn=6);
    }
}

module bit_holder(length = 92, width = 9, height = 10, bitlen = 20) {
    color("black") {
        cube([length, width, height], center = false);
    }
    for (i = [0:9]) {
        translate([5 + i*8.8, 4.5, 0]) {
            screwdriver_bits(bit_len = bitlen);
        }
    }
}

module spanner_ends(handle_len = 50, handle_width = 20, head_width = 30, thickness = 5) {
    ring_outer_dia = head_width;
    ring_inner_dia = head_width * 0.55;
    open_outer_dia = head_width * 0.9;
    open_inner_dia = open_outer_dia * 0.55;
    jaw_gap = open_outer_dia * 0.35;
    ring_centre_x = ring_outer_dia / 2;
    open_centre_x = ring_outer_dia + handle_len + (open_outer_dia / 2);
    centre_y = head_width / 2;

    color("lightgrey") {
        linear_extrude(height = thickness) {
            difference() {
                union() {
                    hull() {
                        translate([ring_centre_x, centre_y]) {
                            circle(d = ring_outer_dia);
                        }
                        translate([ring_outer_dia + (handle_len * 0.2), centre_y]) {
                            circle(d = handle_width);
                        }
                    }
                    hull() {
                        translate([ring_outer_dia + (handle_len * 0.8), centre_y]) {
                            circle(d = handle_width);
                        }
                        translate([open_centre_x, centre_y]) {
                            circle(d = open_outer_dia);
                        }
                    }
        
                }

                translate([ring_centre_x, centre_y]) {
                    circle(d = ring_inner_dia);
                }

                translate([open_centre_x, centre_y]) {
                    circle(d = open_inner_dia);
                }

                translate([open_centre_x + (open_outer_dia * 0.35), centre_y]) {
                    square([open_outer_dia, jaw_gap], center = true);
                }
            }
        }
    }
}

module spanner(handle_len = 60, handle_width = 20, head_width = 30, thickness = 5) {
    union() {
        spanner_ends(handle_len, handle_width, head_width, thickness);
        translate([head_width + (handle_len / 2), (handle_width / 2) + 5, thickness/2]) {
            color("lightgrey") {
                cube([handle_len, handle_width, thickness], center = true);
            }
        }
    }
}