
_offset = 0.01;
module tube(d, d1, h){
    difference() {
        cylinder(r = d / 2, h = h);
        translate([0, 0, -_offset])
        cylinder(r = d1 / 2, h = h + _offset * 2);
    }
}

module conic_tube(d, d1, d2, d3, h){
    difference() {
        cylinder(d1 = d, d2 = d2, h = h);
        translate([0, 0, -_offset])
            cylinder(d1 = d1, d2 = d3, h = h + _offset * 2);
    }
}