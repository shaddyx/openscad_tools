use <chassis_main.scad>
use <../../math/align.scad>
use <../../screws/screw_stand.scad>
use <../../coolers/cooler_lattice.scad>


innerSize = [100, 70, 30];
wallWidth = 3;
screwStandD = 6;
screwD = 3;

standsSizes = [70, 30, 5];

module chassis_with_screws(
    innerSize, 
    wallWidth = 3, 
    type = "case",
    screwStandD = 6, 
    screwD = 3, 
    standsSizes = [70, 30, 5],
    screws = false,
    vents = false,
    ventD = 10,
    ventFn = 5,
    ventsOffset = 10,
    screwPositions = [1, 1, 1, 1],
    fan = false,
    fan_cooler_d = 30,
    fan_cooler_hole_x_distance = 40,
    fan_lattice_cell_d = 10,
    fan_screw_hole_d = screwD,
    fan_screw_stands_h = 0,
    fan_screw_stands_d = 5,
    fan_lattice_margin = 1,
    
){
    assert(innerSize != undef, "innerSize must be defined");
    assert(wallWidth != undef, "wallWidth must be defined");
    assert(type != undef, "type must be defined");
    assert(screwStandD != undef, "screwStandD must be defined");
    assert(screwD != undef, "screwD must be defined");
    assert(standsSizes != undef, "standsSizes must be defined");
    assert(fan_cooler_d != undef, "fan_cooler_d must be defined");
    assert(fan_cooler_hole_x_distance != undef, "fan_cooler_hole_x_distance must be defined");
    assert(fan_lattice_cell_d != undef, "fan_lattice_cell_d must be defined");
    assert(fan_screw_hole_d != undef, "fan_screw_hole_d must be defined");
    assert(fan_lattice_margin != undef, "fan_lattice_margin must be defined");

    assert (fan_screw_hole_d < fan_screw_stands_d, str("fan_screw_hole_d=", fan_screw_hole_d, " must be smaller than fan_screw_stands_d=", fan_screw_stands_d, " to avoid holes overlapping with stands"));

    module _center(){
        xx(wallWidth + innerSize.x / 2) yy(wallWidth + innerSize.y / 2) children();
    }

    module _c(){
        chassis_main(innerSize, wallWidth=wallWidth, type=type, vents=vents, ventD=ventD, ventFn=ventFn, ventsOffset=ventsOffset);
        if (screws)
            zz(wallWidth) _center()
                screw_stands(standsSizes, d = screwStandD, screwD = screwD, screwH = standsSizes.z, positions=screwPositions, chamferD = 10, chamferA = 0, center = true);
    }

    module _c_with_fan(){     
        difference(){
            _c();
            _center()
            zz (-0.01) 
            cooler_lattice(cooler_d = fan_cooler_d, 
                cooler_hole_x_distance = fan_cooler_hole_x_distance, 
                lattice_cell_d = fan_lattice_cell_d, 
                height = wallWidth * 2 + 10, 
                fan_screw_hole_d = fan_screw_hole_d, 
                lattice_margin = fan_lattice_margin);
        }
        _center() 
        difference() {
            fan_screw_holes(holes_distance = fan_cooler_hole_x_distance, height = fan_screw_stands_h, fan_screw_hole_d = fan_screw_stands_d);
            fan_screw_holes(holes_distance = fan_cooler_hole_x_distance, height = fan_screw_stands_h + 0.1, fan_screw_hole_d = fan_screw_hole_d);
        }
        
    }
    if (fan){
        _c_with_fan();
    } else {
        _c();
    }
}

$fn = 100;

chassis_with_screws(innerSize, 
    wallWidth, 
    type = "case", 
    screwStandD, 
    screwD, 
    standsSizes, 
    screws=true, 
    vents=true, 
    ventD=8, 
    ventFn=5, 
    ventsOffset=2);


xx(200) chassis_with_screws(innerSize, 
    wallWidth, 
    type = "lid", 
    screwStandD, 
    screwD, 
    standsSizes, 
    // screws=true, 
    vents=true, 
    ventD=8, 
    ventFn=5, 
    ventsOffset=2,
    fan=true,
    fan_screw_stands_h = 5,
    );