use <../math/align.scad>
use <../primitives/pyramid.scad>

module simple_latch_mask(sizes) {
  cube(sizes);
}

module simple_latch_mother(sizes, hole_sizes, hole_offset = 2){
    difference(){
        cube(sizes);
        yc() xx(sizes.x / 2 - hole_sizes.x / 2) zz(sizes.z - hole_sizes.y - hole_offset) cube([hole_sizes.x, sizes.y + 1, hole_sizes.y]);
    }
}

module simple_latch_father(sizes, hole_sizes, hole_offset = 2, compensation = 0.2){
    zz(sizes.z - hole_sizes.y - hole_offset)
    xx(sizes.x / 2 - hole_sizes.x / 2 + compensation)
    mirror([0, 0, 1])
    rotate([0, 90, 0])
    linear_extrude(hole_sizes.x - compensation * 2) 
    polygon(points=[
        [0, 0], 
        [hole_sizes.y, sizes.y], 
        [hole_sizes.y, 0]
    ], 
    paths=[[0,1,2]]);
}


#simple_latch_mother([4, 1, 10], [2, 4]);
simple_latch_father([4, 1, 10], [2, 4]);