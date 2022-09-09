h = 50;
poly_n = 20;
use <../math/align.scad>;

module cooler_screw_holes(sizes, hole_d, height = h){
    r = hole_d / 2;
    align_center(sizes){
        translate([r, r, 0]){
            cylinder(sizes[2], r1 = r, r2 = r, center = false, $fn=poly_n);
        }
        translate([sizes[0] - r, r, 0]){
            cylinder(sizes[2], r1 = r, r2 = r, center = false, $fn=poly_n);
        }
        translate([r, sizes[1] - r, 0]){
            cylinder(sizes[2], r1 = r, r2 = r, center = false, $fn=poly_n);
        }
        translate([sizes[0] - r, sizes[1] - r, 0]){
            cylinder(sizes[2], r1 = r, r2 = r, center = false, $fn=poly_n);
        }
    }
}


function _map_sizes(size) =
    (size == 40) ? [38, 38, 4]:
    (size == 50) ? [48, 48, 4]: 
    (size == 70) ? [60.7, 60.7, 4]: -1;

module cooler_main_hole(r){
    cylinder(h, r / 2, r / 2, $fn=poly_n * 3);
}

module standard_cooler_screw_holes(size){
    size = _map_sizes(size);
    group(){
        cooler_screw_holes([size[0], size[0], h], size[2]);
        cooler_main_hole(size[1]);
    }
}

module standard_cooler_plate(size, h=3){
    difference(){
        align_center(size){
            cube([size, size, h]);
        }
        translate([0,0, -1]){
            standard_cooler_screw_holes(size);
        }
    }
}

standard_cooler_plate(40);