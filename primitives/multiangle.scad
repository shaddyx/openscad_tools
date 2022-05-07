use <../math/align.scad>
use <../math/vect.scad>

module multiangle(angles, r, h){
    cylinder(h = h, r1=r, r2=r, $fn=angles);
}

multiangle(5, 10, 5);