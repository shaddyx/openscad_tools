use <../../math/align.scad>
use <fastening.scad>
module chassis_bottom(
inner_sizes_with_bottom_height,
fastener_depth = 4,
fastening_width=10,
fastening_height=10,
fastening_diameter=4,
fastening_offset=5
) {
fastening_sizes = [fastening_width, fastener_depth, fastening_height];


    cube(inner_sizes_with_bottom_height);
    zz(inner_sizes_with_bottom_height.z) xx(fastening_offset)
        chassis_fastening(fastening_sizes, fastening_diameter, fastener_depth);
    zz(inner_sizes_with_bottom_height.z) xx(inner_sizes_with_bottom_height.x - fastening_offset - fastening_width)
        chassis_fastening(fastening_sizes, fastening_diameter, fastener_depth);
    zz(inner_sizes_with_bottom_height.z) yy(inner_sizes_with_bottom_height.y - fastener_depth) xx(fastening_offset)
        chassis_fastening(fastening_sizes, fastening_diameter, fastener_depth);
    zz(inner_sizes_with_bottom_height.z) yy(inner_sizes_with_bottom_height.y - fastener_depth) xx(inner_sizes_with_bottom_height.x - fastening_offset - fastening_width)
        chassis_fastening(fastening_sizes, fastening_diameter, fastener_depth);
}