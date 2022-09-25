use <../math/align.scad>

module screw_hole(d, h, chamferD = undef, chamferA = 30){
    chamferD = chamferD == undef ? d * 1.75: chamferD;
    chamferH = chamferD * tan(chamferA);

    cylinder(d = d, h = h);
    zz(h - chamferH)
    cylinder(r2 = chamferD / 2, r1 = 0,  h = chamferH);
}

$fn=100;
screw_hole(3, 20);