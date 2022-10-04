use <../math/align.scad>

function _R(l, h) = (pow(l, 2) + pow(h, 2)) / (2 * h);

module arc_2d(w, h){
    r = _R( w/2, h);    
    difference() {
        translate([0, - r + h]) 
            circle(r=r);
        mirror([0, 1, 0]) 
        translate([-r - 5, 0, 0]) 
            square([r*2 + 10, r * 2 + 10]);
    }
}

module arc_3d(x, y, h){
    translate(v = [x / 2, 0]) 
    linear_extrude(height=h) 
        arc_2d(x, y);
}

module arc_cube(size, arcSizes, 
    compensateArcs = true,
    center = false
    ){
    arcSizes = is_list(arcSizes) ? arcSizes : [arcSizes, arcSizes, arcSizes, arcSizes];
    module _main_arc(){
        cube(size);
        mirror([0, 1, 0]) 
            arc_3d(size.x, arcSizes.x, size.z); 
        translate([0, size.y, 0])
            arc_3d(size.x, arcSizes.x, size.z); 
        rotate([0, 0, 90])
            arc_3d(size.x, arcSizes.y, size.z); 
        
        translate([size.x, 0, 0]) mirror([0, 1, 0]) rotate([0, 0, -90])
            arc_3d(size.x, arcSizes.y, size.z); 
    }


    if (!center){
        translate(compensateArcs ? [arcSizes[2], arcSizes[3]] : [0, 0]) _main_arc();
    } else {
        align_center(sizes = size)
        _main_arc();
    }
}

$fn=200;
arc_cube(size = [50, 50, 50], arcSizes = 3, center = true);
// // linear_extrude(height=10) 
// //     arc_2d(20, 3);

// // h = 3;
// // w = 20;
// // r = _R( w/2, h);
// $fn=100;
// arc_3d(40, 10, 20);

