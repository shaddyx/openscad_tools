use <../math/vect.scad>
module linear_2d_auto_cluster(width, oWidth, spacing){
    fw = oWidth + spacing;
    cols = floor(width / fw - 1);
    lw = width - cols * fw;
    for ( i = [0 : cols] ) {
        translate([i * fw + lw / 2 - oWidth / 2, 0]) 
            children();
    }
}
module regular_cluster(size, oSize, rows = 2, cols = 2, centered=false, fit = true, margin = 0){
    margin = vectorize_2(margin);
    fullSize = [size.x - margin.x * 2, size.y - margin.y * 2];
    xCompensation = fit ? oSize.x : 0;
    yCompensation = fit ? oSize.y : 0;
    xSpacing = (fullSize[0] - xCompensation) / (cols - 1);
    ySpacing = (fullSize[1] - yCompensation) / (rows - 1);
    xOffset = centered ? oSize[0] / 2: 0;
    yOffset = centered ? oSize[1] / 2: 0;
    for (i = [0: cols - 1])
        for (j = [0: rows - 1]){
            translate([margin.x + i * xSpacing + xOffset, margin.y + j * ySpacing + yOffset, 0])
                children();
        }
}

module check_cluster(size, oSize, rows = 2, cols = 2, rowOffset = 15, centered=false){
    size = vect_scalar_sum(size, -rowOffset);
    xSpacing = (size[0] - oSize[0]) / (cols - 1);
    ySpacing = (size[1] - oSize[1]) / (rows - 1);
    xOffset = centered ? oSize[0] / 2: 0;
    yOffset = centered ? oSize[1] / 2: 0;
    for (i = [0: cols - 1])
        for (j = [0: rows - 1]){
            translate([i * xSpacing + xOffset + (j % 2 == 0 ? 0: rowOffset), j * ySpacing + yOffset, 0])
                children();
        }
}

module radial_line(size, r, cols){
    angle = 360 / cols;
    for (j = [0: cols - 1]){
        translate(vect_rotate2d([0, r], angle * j))
            rotate(angle * j)
                children();
    }
}

module radial_cluster(size, r, r1, rows=2, cols=2){
    r_step = (r1 - r) / rows;
    for (j = [0: rows - 1]){
        radial_line(size, r + r_step * j, cols)
            children();
    }
}

module radial_auto_cluster(size, r, r1, radial_min_spacing = 2, r_min_spacing = 2){
    function len(r) = 2 * PI * r;
    function cols(r) = floor(len(r) / (size.x + radial_min_spacing));
    function rows(r) = floor(r / (size.y + r_min_spacing) / 2);
    
    //function radial_spacing(r) = len(r) / cols(r) - size.x;
    function r_spacing(r) = r / rows(r) - size.y;
    rws = rows(r1 - r);
    r_spac =  r_spacing(r1 - r);
    for (i = [0: rws - 1]){
        rr = r + r_spac * i;
        if (rr > 0){
            radial_line(size, rr, cols(rr))
                children();
        }
    }
}

// linear_2d_auto_cluster(140, 10, 5)
//     cube([10, 10, 10]);

//translate([-7, -7])
// regular_cluster([100, 100], [14, 14], 3, 3, centered = false, fit = false){
//     cylinder(7, 7, 7);
// }


// check_cluster([100, 100], [14, 14], 3, 3, centered = true){
//     cylinder(7, 7, 7);
// }

// check_cluster([100, 100], [10, 10], 3, 3, centered = false){
//     cube(10);
// }
$fn = 100;
// radial_line([7, 7], 50, 20){
//     cylinder(7, 7, 7);
// }
// radial_cluster([7, 7], 50, 100, rows=3, cols=20)
//     cylinder(7, 7, 7);

// radial_auto_cluster([10, 10], 0, 100, radial_min_spacing = 1, r_min_spacing = 1){
//     cylinder(r=5, h=10);
//     //square([7, 7]);
// }
