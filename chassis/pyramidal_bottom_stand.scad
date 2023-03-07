use <../primitives/pyramid.scad>
use <../primitives/arc.scad>
use <../math/align.scad>
use <../math/vect.scad>

module pyramidal_bottom_stand(
    sizes, 
    top_sizes, 
    wallW = 5,
    legW = 10,
    bottomArcHMargin = 20
){
    assert(bottomArcHMargin <= sizes.z - wallW, "height is greater than bottomArcHMargin");
    module _main_pyramid(){
        inner_sizes = sizes - [wallW * 2, wallW * 2, wallW];
        inner_top_sizes = top_sizes - [wallW * 2, wallW * 2, 0];
        echo(inner_sizes);

        difference() {
            xx(sizes.x / 2) truncated_pyramid4(sizes, top_sizes, center = true);
            zz(-0.01) xx(inner_sizes.x / 2 + wallW) truncated_pyramid4(inner_sizes, inner_top_sizes, center = true);
        }
    }

    module _bottomArc(x, y, arcH){
        yy(arcH) rx(90)
            arc_3d(x = x, y = y, h = arcH);
    }
    
    bottomArcY = sizes.y + 10;
    bottomArcX = sizes.x + 10;
    bottomArcH = sizes.z - bottomArcHMargin;
    difference() {
        _main_pyramid();
        zz(-0.01){
            xx(legW) yy(-bottomArcY / 2) _bottomArc(sizes.x - legW * 2, bottomArcH, bottomArcY);
            // yy(legW) yy(-bottomArcY / 2) 
            xx(bottomArcX - 5) yy(-bottomArcX / 2 - legW) rz(90) _bottomArc(sizes.y - legW * 2, bottomArcH, bottomArcX);
        }
    }

}
$fn = 100;
pyramidal_bottom_stand([100, 150, 30], [50, 70], bottomArcHMargin = 20);