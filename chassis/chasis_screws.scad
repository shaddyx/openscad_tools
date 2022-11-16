module screw_stand(d, screwD, h, percentage=80){
    hole_h = h / 100 * percentage;
    difference() {
        cylinder(d = d, h = h);
        translate([0,0, h - hole_h]) 
        cylinder(d = screwD, h = hole_h + 0.01);
    }
}

module align_screws(size, d, margin, only_two = true, percentage=80){
    indent = d / 2 + margin;
    translate(v = [indent, indent , 0])
        children();
    translate(v = [size.x - indent, size.y - indent , 0])
        children();
    if (!only_two){
        translate(v = [indent, size.y - indent , 0])
            children();
        translate(v = [size.x - indent, indent , 0])
            children();
    }
}

module screw_stands(size, d, screwD, h, margin, only_two = true, percentage=80){
    align_screws(size, d, margin, only_two, percentage){
        screw_stand(d = d, screwD = screwD, h = h);
    }
}

$fn=200;
screw_stands(size = [100, 100], d = 10, screwD = 3, h = 40, margin = 3, only_two=false);
translate(v = [20, 0, 0]) 
align_screws(size = [100, 100], d = 10, margin = 3, only_two=false){
    cylinder(d=3, h=30);
}