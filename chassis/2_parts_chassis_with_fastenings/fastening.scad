use <../../math/align.scad>
module chassis_fastening(fastening_sizes, fastening_diameter, fastener_depth) {
    difference() {
        cube(fastening_sizes);
        xx(fastening_sizes.x / 2) zz(fastening_sizes.z / 2) yc() rotate([- 90, 0, 0]) cylinder(d = fastening_diameter, h
        = fastener_depth + 1);
    }
}