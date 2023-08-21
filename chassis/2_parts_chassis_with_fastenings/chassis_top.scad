use <../../math/align.scad>
use <fastening.scad>

module chassis_top(
inner_sizes_with_bottom_height,
inner_height,
wall_width = 2,
fastening_width = 10,
fastening_height = 10,
fastening_depth = 4,
fastening_hole_diameter = 3.5,
fastening_z_offset = 15,
dead_left=false,
dead_right=false
) {
    module chassis_fastenings() {
        fastening_sizes = [fastening_width, fastening_depth, fastening_height];
        module left_front_fastening() {
            xx(fastening_depth) rotate([0, 0, 90]) {
                chassis_fastening(
                fastening_sizes,
                fastening_hole_diameter,
                fastening_depth
                );
            }
        }
        module left_fastenings(){
            zz(inner_sizes_with_bottom_height.z + fastening_z_offset){
                left_front_fastening();
                yy(inner_sizes_with_bottom_height.y) mirror([0, 1, 0]) left_front_fastening();
            }

            zz(inner_sizes_with_bottom_height.z + inner_height - fastening_z_offset) mirror([0, 0, 1]){
                left_front_fastening();
                yy(inner_sizes_with_bottom_height.y) mirror([0, 1, 0]) left_front_fastening();
            }
        }
        module right_fastenings(){
            xx(inner_sizes_with_bottom_height.x) mirror([1, 0, 0]) left_fastenings();
        }
        if (!dead_left){
            left_fastenings();
        }
        if (!dead_right){
            right_fastenings();
        }
    }
    outer_size = [inner_sizes_with_bottom_height.x + wall_width * 2, inner_sizes_with_bottom_height.y + wall_width * 2,
                inner_sizes_with_bottom_height.z + inner_height + wall_width];
    xx(- wall_width) yy(- wall_width) {
        cube([outer_size.x, wall_width, outer_size.z]);
        yy(outer_size.y - wall_width) cube([outer_size.x, wall_width, outer_size.z]);
        zz(inner_sizes_with_bottom_height.z + inner_height) cube([outer_size.x, outer_size.y, wall_width]);
    }
    chassis_fastenings();
    if (dead_left){
        xx(- wall_width) cube([wall_width, inner_sizes_with_bottom_height.y, outer_size.z]);
    }
    if (dead_right){
        xx(inner_sizes_with_bottom_height.x) cube([wall_width, inner_sizes_with_bottom_height.y, outer_size.z]);
    }
}