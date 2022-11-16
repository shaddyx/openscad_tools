use <../primitives/arc.scad>
use <../screws/screw_holes.scad>
diameter_multiplier = 0.7;

module simple_cable_holder_holes_align(size, cableD){
    translate([(size.x - cableD) / 4, size.y / 2, -0.01]) 
        children();
    translate([size.x - (size.x - cableD) / 4, size.y / 2, -0.01]) 
        children();
}

module simple_cable_holder_bottom(size, cableD, screwD, dMultiplier = diameter_multiplier){
    module _arc_cable_hole(){
        translate([-cableD/2, 0])
        rotate([-90, 0, 0])
        color ("red") arc_3d(cableD, cableD / 2 * dMultiplier, size.y + 1);
    }
    module _m(){
        difference() {
            cube([size.x, size.y, size.z / 2]);
            //
            //cylinder(d=cableD, h=size.y + 1);
            translate([size.x / 2, -0.5, size.z / 2 + 0.01])
                _arc_cable_hole();
        }
    }
    difference() {
        _m();
        translate([(size.x - cableD) / 4, size.y / 2, -0.01]) 
            cylinder(d=screwD, h=size.z);
        translate([size.x - (size.x - cableD) / 4, size.y / 2, -0.01]) 
            cylinder(d=screwD, h=size.z);
    }
}

module simple_cable_holder_top(size, cableD, screwD, dMultiplier = diameter_multiplier){
    module _arc_cable_hole(){
        translate([-cableD/2, 0])
        rotate([-90, 0, 0])
        color ("red") arc_3d(cableD, cableD / 2 * dMultiplier, size.y + 1);
    }
    module _m(){
        difference() {
            cube([size.x, size.y, size.z / 2]);
            //
            //cylinder(d=cableD, h=size.y + 1);
            translate([size.x / 2, -0.5, size.z / 2 + 0.01])
                _arc_cable_hole();
        }
    }
     difference() {
        _m();
        translate([(size.x - cableD) / 4, size.y / 2, -0.01]) 
            screw_hole(d=screwD, h=size.z, mirrorZ = true);
        translate([size.x - (size.x - cableD) / 4, size.y / 2, -0.01]) 
            screw_hole(d=screwD, h=size.z, mirrorZ = true);
    }
}

simple_cable_holder_bottom(size = [30, 10, 15], cableD = 8, screwD = 3);
translate([50, 0, 0]) 
simple_cable_holder_top([30, 10, 15], cableD = 8, screwD = 3);
//simple_cable_holder_top([130, 10, 15], cableD = 8, screwD = 3);