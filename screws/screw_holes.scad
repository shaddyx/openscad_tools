use <../math/align.scad>

module screw_hole(d, h, chamferD=undef, chamferA = 30, mirrorZ = false){
    assert (!is_undef(d), "Diameter should be defined for screw_hole");
    assert (!is_undef(h), "Height should be defined for screw_hole");
    eChamferD = is_undef(chamferD) ? d * 1.75: chamferD;
    chamferH = eChamferD * tan(chamferA);

    module _m(){
        cylinder(d = d, h = h);
        zz(h - chamferH)
        cylinder(r2 = eChamferD / 2, r1 = 0,  h = chamferH);
    }

    if (mirrorZ){
        translate([0, 0, h]) mirror([0, 0, 1]) 
            _m();
    } else {
        _m();
    }
}


module screw_holes(size, d, positions=[1,1,1,1], chamferD = undef, chamferA = 30){
    module _h(){
        screw_hole(d = d, h = size.z, chamferD, chamferA);
    }
    if (positions[0])
        xx(size.x)
            _h();
    if (positions[1])
        yy(size.y)
            _h();
    if (positions[2])
        yy(size.y)
        xx(size.x)
            _h();
    if (positions[3])
        _h();
}

module four_screw_holes(size, d, chamferD = undef, chamferA = 30){
    assert(!is_undef(size), "Size should be defined for four_screw_holes");
    assert(!is_undef(d), "Diameter should be defined for four_screw_holes");
    assert(!is_undef(chamferA), "Chamfer angle should be defined for four_screw_holes");
    assert(!is_undef(size.z), "Height in sizes should be defined for four_screw_holes");
    effectiveChamferD = is_undef(chamferD) ? d * 1.75: chamferD;
    module _h(){
        echo (str("Creating screw hole with d=", d, " h=", size.z, " chamferD=", effectiveChamferD, " chamferA=", chamferA));
        screw_hole(d = d, h = size.z, effectiveChamferD, chamferA);
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