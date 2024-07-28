use <../../primitives/cluster.scad>
module cube_stand_profile(size){
    mirror([0, 1, 0]) rotate([0, 0, -90]){
        cube([size.x, size.y + 20, size.z]);
    }
}

module stand_profile(size, h){
    cylinder(d=size.x, h=h);
    rotate(a = [0, 0, 45]) {
        translate([0, - size.y / 2, 0]) {
            cube_stand_profile(size = size);
        }
    }
}

module stand(
    size,
    screwD = 3,
    screwDepth = 10
){
    difference() {
        stand_profile(size = size, h = size.z);
        translate(v = [0, 0, size.z - screwDepth]) cylinder(d=screwD, h = screwDepth + 0.5);
    }
}

module center_box(
    innerSize, 
    wallWidth
    ){
    outerSize = [innerSize.x + wallWidth * 2, innerSize.y + wallWidth * 2, innerSize.z + wallWidth];
    difference() {
        cube(outerSize);
        translate([wallWidth, wallWidth, wallWidth]) cube([innerSize.x, innerSize.y, innerSize.z + 0.01]);
    }
}

module main(
    innerSize = [100, 100, 50],
    standD = 10,
    wallWidth=2,
    screwD = 3.5,
    nutD = 4,
    type = "case"
){
    outerBoxSize = [innerSize.x + wallWidth * 2, innerSize.y + wallWidth * 2, innerSize.z + wallWidth];
    outerH = innerSize.z + wallWidth;
    standSize = [standD, standD, outerH];
    lidStandSize = [standSize.x, standSize.y, wallWidth];
    holeOffset = nutD / 2;
    //holeOffset = nutD / 2;
    

    lidFoundationSize = [outerBoxSize.x, outerBoxSize.y, wallWidth];
    holesPositions = [
        [- holeOffset, - holeOffset, 0],
        [outerBoxSize.x + holeOffset, - holeOffset, 0],
        [outerBoxSize.x + holeOffset, outerBoxSize.y + holeOffset, 0],
        [-holeOffset, outerBoxSize.y + holeOffset, 0]
    ];
    
    module r(a){
        rotate([0, 0, a]) children();
    }

    if (type == "case"){
        // stands
        difference() {
            color("green") {
                translate(v = holesPositions[0]) stand(size = standSize, screwD = nutD);
                translate(v = holesPositions[1]) r(90) stand(size = standSize, screwD = nutD);
                translate(v = holesPositions[2]) r(180) stand(size = standSize, screwD = nutD);
                translate(v = holesPositions[3]) r(-90) stand(size = standSize, screwD = nutD);
            }
            translate([wallWidth, wallWidth, wallWidth]) cube([innerSize.x, innerSize.y, innerSize.z + 1]);
        }
        

        // box
        center_box(innerSize = innerSize, wallWidth = wallWidth);
    } else {
        cube(lidFoundationSize);
        color("green") {
            translate(v = holesPositions[0]) stand(size = lidStandSize, screwD = screwD);
            translate(v = holesPositions[1]) r(90) stand(size = lidStandSize, screwD = screwD);
            translate(v = holesPositions[2]) r(180) stand(size = lidStandSize, screwD = screwD);
            translate(v = holesPositions[3]) r(-90) stand(size = lidStandSize, screwD = screwD);
        }
    }

}

$fn = 100;
size = [80, 80, 35];
main(size);
translate(v = [size.x + 20, 0, 0]) main(type="lid");

// cube_stand_profile(size = [10, 10, 5]);