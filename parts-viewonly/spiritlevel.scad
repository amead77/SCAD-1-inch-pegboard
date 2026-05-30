/*
just a very basic model of a spirit level, for showing in the pegboard assembly. Not for printing.
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