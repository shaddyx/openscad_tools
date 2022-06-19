
_offset = 0.01;
module tube(d, d1, h){
    difference() {
        cylinder(r = d / 2, h = h);
        translate([0, 0, -_offset])
        cylinder(r = d1 / 2, h = h + _offset * 2);
    }
}
