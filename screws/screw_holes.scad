use <../math/align.scad>

module screw_hole(d, h, chamferD = undef, chamferA = 30, mirrorZ = false){
    chamferD = chamferD == undef ? d * 1.75: chamferD;
    chamferH = chamferD * tan(chamferA);

    module _m(){
        cylinder(d = d, h = h);
        zz(h - chamferH)
        cylinder(r2 = chamferD / 2, r1 = 0,  h = chamferH);
    }

    if (mirrorZ){
        translate([0, 0, h]) mirror([0, 0, 1]) 
            _m();
    } else {
        _m();
    }
}


module four_screw_holes(size, d, chamferD = undef, chamferA = 30){
    module _h(){
        screw_hole(d = d, h = size.z, chamferD, chamferA);
    }
    xx(size.x)
        _h();
    yy(size.y)
        _h();
    yy(size.y)
    xx(size.x)
        _h();
    _h();
}

$fn=100;
screw_hole(3, 5);
//four_screw_holes([100, 100, 10], 10, 15);