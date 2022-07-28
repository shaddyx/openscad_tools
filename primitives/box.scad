use <../math/align.scad>
module box_round(size, center = false, r=0){
    sx = size[0] - 2 * r;
    sy = size[1] - 2 * r;
    sz = size[2] - 2 * r;
    translate([r, r, r]) hull() {
        for (offset=[[0, 0, 0],
                     [0, 0, sz],
                     [0, sy, sz],
                     [0, sy, 0],
                     [sx, sy, 0],
                     [sx, sy, sz],
                     [sx, 0, sz],
                     [sx, 0, 0]])
        {
            translate(offset) sphere(r);
        }
    }
}

module box_hole(size, wallWidth, center = false, bottom = false){
    align_uncenter(size, uncenter = !center, uncenterZ = !center){
        _box_hole_centered(size, wallWidth);
        if (bottom){
            bottomSize = [size[0], size[1], wallWidth];
            translate([- size[0] / 2, -size[1] / 2, - size[2] / 2]) 
            cube(bottomSize);
        }
    }
}

module _box_hole_centered(size, wallWidth){
    iSize = [size[0] - wallWidth * 2, size[1] - wallWidth * 2, size[2] + 1];
    difference(){
        cube(size, center = true);
        cube(iSize, center = true);
    }
}


//box_round([200,200,200], r=4);
box_hole([200,200,200], 2, bottom=true);