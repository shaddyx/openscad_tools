use <chassis_bottom.scad>
use <chassis_top.scad>
use <chassis_side_lid.scad>
use <../../math/align.scad>

module main(){
    #chassis_bottom([100, 100, 2]);
    chassis_top([100, 100, 2], 100, dead_right=false, vent=true, top_vent=true, top_vent_hole_diameter=10);
    xx(-2) chassis_side_lid([100, 100, 2], 100);
}

main();
