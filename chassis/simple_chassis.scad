use <../math/align.scad>
use <../math/vect.scad>
use <../math/split.scad>

module simple_chassis(
    size,
    lower_part_h,
    wallW,
    indent,
    indent_h,
    indent_size_correction,
    upperPart = true
){
    inner_indent_w = wallW - indent - indent_size_correction;
    outer_indent_w = indent + indent_size_correction;
    inner_size = vect_scalar_sum(size, -wallW * 2);

    module _main(){
        difference() {
            cube(size);
            translate([wallW, wallW, wallW]) 
                cube(inner_size);
        }
    }

    module _inner_indent(){
        indent_size = [size.x - inner_indent_w * 2, size.y - inner_indent_w * 2, indent_h + 0.01];
        xx(inner_indent_w) yy(inner_indent_w)
            cube(indent_size);
    }

    module _outer_indent(){
        xcc=0.01;
        indent_size = [size.x - outer_indent_w * 2, size.y - outer_indent_w * 2, indent_h];
        outer_indent_size = [size.x + xcc , size.y + xcc , indent_h + xcc ];
        difference() {
            xx(-xcc / 2) yy(-xcc / 2)
            cube(outer_indent_size);
            xx(outer_indent_w) yy(outer_indent_w) zz(-0.01 / 2) 
                cube(indent_size);
        }
        
    }

    
    module _t(){
        difference() {
            zz(size.z)
            mirror([0, 0, 1]) 
            top_part(size, size.z - lower_part_h)
                _main();
            zz(size.z - lower_part_h - indent_h)
            _inner_indent();
        }
        
    }
    module _b(){
        difference() {
            bottom_part(size, lower_part_h)
                            _main();
            zz(lower_part_h - indent_h)
                _outer_indent();
        }
            
    }

    
    if (upperPart){
        _t();
    } else {
        _b();
    }
}

simple_chassis(size = [20, 30, 20], lower_part_h = 10, wallW = 2, indent = 1, indent_h = 2, indent_size_correction = 0.3, upperPart = true);
xx(30)
simple_chassis(size = [20, 30, 20], lower_part_h = 10, wallW = 2, indent = 1, indent_h = 2, indent_size_correction = 0.3, upperPart = false);