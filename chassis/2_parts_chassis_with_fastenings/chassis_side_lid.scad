use <../../math/align.scad>
use <../../screws/screw_holes.scad>

module chassis_side_lid(
inner_sizes_with_bottom_height,
inner_height,
wall_width = 2,
fastening_width = 10,
fastening_height = 10,
fastening_hole_diameter = 3.5,
fastening_z_offset = 15
){
    difference() {
        cube([wall_width, inner_sizes_with_bottom_height.y, inner_sizes_with_bottom_height.z + inner_height]);
        zz(inner_sizes_with_bottom_height.z + fastening_z_offset + fastening_height / 2) xx(wall_width - 0.01) {
            yy(fastening_width / 2) rotate([0, -90, 0]) screw_hole(fastening_hole_diameter, wall_width + 0.1);
            yy(inner_sizes_with_bottom_height.y - fastening_width / 2) rotate([0, -90, 0]) screw_hole(fastening_hole_diameter, wall_width + 0.1);
        }
        zz(inner_sizes_with_bottom_height.z + inner_height - fastening_z_offset - fastening_height / 2) xx(wall_width - 0.01) {
            yy(fastening_width / 2) rotate([0, -90, 0]) screw_hole(fastening_hole_diameter, wall_width + 0.1);
            yy(inner_sizes_with_bottom_height.y - fastening_width / 2) rotate([0, -90, 0]) screw_hole(fastening_hole_diameter, wall_width + 0.1);
        }
    }
}