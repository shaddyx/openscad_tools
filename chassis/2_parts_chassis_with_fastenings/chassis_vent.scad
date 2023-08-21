use <../../math/align.scad>

module chassis_vent(w, h, wall_width, hole_width = 5){
    margin = hole_width;
    dist = (hole_width * 2);
    num = (w - margin * 2 - hole_width) / dist;
    for ( i = [0 : num] ){
        xx(hole_width / 2 + margin + i * dist) cube([hole_width , h, wall_width]);
    }
}

chassis_vent(100, 30, 3);