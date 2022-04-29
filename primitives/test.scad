use <box.scad>;
use <pyramid.scad>;
use <../math/vect.scad>;
use <../math/align.scad>;
use <../coolers/cooler.scad>
size = [30, 10, 50];
dx = 0.01;
wallWidth = 2;


boxH = size[2] * 1 / 3;
nozzleFullH = (size[2] - boxH) * 2;
nozzleSize = [size[0], size[1], nozzleFullH];
nozzleHeight = nozzleFullH / 2;

module nozzle(nozzleSize){
    difference(){
        pyramid4(nozzleSize, center = false);
        nozzleSize1 = vect_scalar_sum(nozzleSize, -wallWidth);
        nozzleSizeM = [nozzleSize1[0] - wallWidth, nozzleSize1[1] - wallWidth, nozzleSize1[2] + dx];
        translate([wallWidth, wallWidth, - dx]){
            pyramid4(nozzleSizeM, center = false);
        }
    }
}

module truncated_nozzle(nozzleSize){
    difference(){
        nozzle(nozzleSize);
        translate([0, 0, nozzleHeight]){
            cube(nozzleSize);
        }
    }
}

center(size, centerZ = false){
    boxSize = [size[0], size[1], boxH];
    cube_hole(boxSize, wallWidth, center = false);
    translate([0, 0, boxH]){ 
        truncated_nozzle(nozzleSize);    
    }
}

standard_cooler_plate(40);

