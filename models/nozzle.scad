use <../primitives/box.scad>;
use <../primitives/pyramid.scad>;
use <../math/vect.scad>;
use <../math/align.scad>;
use <../coolers/cooler.scad>;
use <../connectors/simple_rotating_connector.scad>;


size = [30, 10, 30];
wallWidth = 3;
nozzle_angle = 50;
nozzle_r = 20;
pyramid_h = 30;
nozzle_h_multiplier = 0.66;

module bent_nozzle(size, wallWidth){
    dx = 0.01;

    boxH = size[2] * 1 / 3;
    nozzleFullH = (size[2] - boxH) * 2;
    nozzleSize = [size[0], size[1], nozzleFullH];
    nozzleHeight = nozzleFullH * nozzle_h_multiplier;

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
    module nozzle_head(){
        align_center(size, centerZ = false){
            boxSize = [size[0], size[1], boxH];
            cube_hole(boxSize, wallWidth, center = false);
            translate([0, 0, boxH]){ 
                truncated_nozzle(nozzleSize);    
            }
        }
    }

    align_center([size[1], size[0]])
        simple_rotating_connector([size[1], size[0]], wallWidth, nozzle_angle, nozzle_r, false)
            translate([size[1], 0])
            rotate([0, 0, 90])
                align_uncenter([size[0], size[1]])
                    nozzle_head();
        

}
standard_cooler_plate(40);
translate([0,0, 3]){
    difference(){
        truncated_pyramid4([40, 40, pyramid_h], [size[1], size[0]], center = true);
        translate([0, 0, -0.001])
            truncated_pyramid4([40 - wallWidth, 40 - wallWidth, pyramid_h + 0.003], [size[1] - wallWidth, size[0] - wallWidth], center = true);
    }
    translate([0,0, pyramid_h])
        bent_nozzle(size, wallWidth);
}

//truncated_pyramid4([40, 40, 30], [size[1], size[0]], center = true);
//truncated_pyramid4([40 - wallWidth, 40 - wallWidth, 30], [size[1] - wallWidth, size[0] - wallWidth], center = true);