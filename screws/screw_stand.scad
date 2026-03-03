use <screw_holes.scad>
use <../math/align.scad>

module screw_stand(d, screwD, screwH, h,  chamferD = undef, chamferA = 0, mirrorZ = false){
    screwH = is_undef(screwH) ? h : screwH;

    assert(screwH != undef);

    difference() {
        cylinder(h = h, d = d);
        translate([0, 0, 0.01]) screw_hole(d = screwD, chamferA = chamferA, chamferD = chamferD, h = screwH);
    }
}


module screw_stands(size, d, screwD, screwH = 3, positions=[1,1,1,1], chamferD = undef, chamferA = 0, center = false){
    assert (size != undef);
    assert (size.x != undef);
    assert (size.y != undef);
    assert (size.z != undef);
    assert (d != undef);
    assert (screwD != undef);
    assert (positions != undef);


    module main(){
        module _h(){
            screw_stand(d = d, screwD = screwD, screwH= screwH, h = size.z, chamferD, chamferA);
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
    if (center)
        xx(- size.x / 2) yy(- size.y / 2) main();
    else
        main();
}


screw_stands([50, 30, 10], d = 6, screwD = 3, screwH = 20);