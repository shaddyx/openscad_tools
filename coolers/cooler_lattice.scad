use <../primitives/lattice.scad>
use <..//math/align.scad>

module cooler_lattice(
    cooler_d = 38,                  // inner diameter of the cooler
    cooler_hole_x_distance = -1,     // distance between the holes in the x direction (-1 if diagonal used)
    cooler_hole_diagonal_distance = 45,
    lattice_cell_d = 10,
    height = 3,
    fan_screw_hole_d = 4,
    lattice_margin = 1
){
    module screws(){
        holes_distance = (cooler_hole_x_distance == -1) ? sqrt(cooler_hole_diagonal_distance*cooler_hole_diagonal_distance / 2) : cooler_hole_x_distance;
        echo("holes_distance: ", holes_distance);
        module screw_hole() {
            cylinder(d = fan_screw_hole_d, h = height + 1);
        }

        translate([-holes_distance / 2, -holes_distance / 2, 0]) screw_hole();
        translate([holes_distance / 2, -holes_distance / 2, 0]) screw_hole();
        translate([holes_distance / 2, holes_distance / 2, 0]) screw_hole();
        translate([-holes_distance / 2, holes_distance / 2, 0]) screw_hole();
    }

    screws();
    circle_lattice(d = cooler_d, h = height, cell_d = lattice_cell_d, m = lattice_margin);
}

// $fn=60;
// cooler_lattice();
