yyy = 10.25;
xxx = 17.7;
yyy2 = 5.57;
xxx2 = 21.4;
h = 21.16;

function xt_90_m_sizes()=[xxx2, yyy, h];

module xt_90_m(){
    
    hull(){
        cube([xxx,yyy, h]);
        translate([0, yyy/2 - yyy2/2])
            cube([xxx2,yyy2, h]);
    }
}
xt_90_m();