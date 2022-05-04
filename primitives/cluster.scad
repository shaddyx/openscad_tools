use <../math/vect.scad>
module regular_cluster(size, oSize, rows = 2, cols = 2, centered=false){
    xSpacing = (size[0] - oSize[0]) / (cols - 1);
    ySpacing = (size[1] - oSize[1]) / (rows - 1);
    xOffset = centered ? oSize[0] / 2: 0;
    yOffset = centered ? oSize[1] / 2: 0;
    for (i = [0: cols - 1])
        for (j = [0: rows - 1]){
            translate([i * xSpacing + xOffset, j * ySpacing + yOffset, 0])
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

check_cluster([100, 100], [10, 10], 3, 3, centered = true){
    cylinder(5, 5, 5);
}
