
module cube_round(size, center = false, r=0){
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

module cube_hole(size, wallWidth, center = false){
    if (!center){
        translate([size[0] / 2, size[1] / 2, size[2] / 2]){
            _cube_hole_centered(size, wallWidth);
        }
    } else {
        _cube_hole_centered(size, wallWidth);
    }
}

module _cube_hole_centered(size, wallWidth){
    iSize = [size[0] - wallWidth * 2, size[1] - wallWidth * 2, size[2] + 1];
    difference(){
        cube(size, center = true);
        cube(iSize, center = true);
    }
}


cube_round([200,200,200], r=4);