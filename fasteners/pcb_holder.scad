use <../math/align.scad>
use <../math/vect.scad>


module _bar(barSize, barLedgeWidth, bottom=false){
    cube(barSize);
    ledgeSize = [barSize.x, barSize.y, barSize.y + barLedgeWidth];
    zz(barSize.z){
        if (bottom){
            yy(barSize.y + barLedgeWidth)
            rotate([90,0,0])
                cube(ledgeSize);
        } else {
            yy(barSize.y)
            rotate([90,0,0])
                cube(ledgeSize);
        }
    }
    
}

module pcb_holder(pcbSize, barSize, barLedgeWidth, barMargin = [7, 7], padding=[0.5, 0.5], sides = [1, 1, 1, 1]){

    right = pcbSize.x - barSize.x - barMargin.x;
    left = barMargin.x;
    top = pcbSize.y + padding.y;
    bottom = - barSize.y - padding.y;
    vertLeft = - barSize.y - padding.x;
    vertTop = pcbSize.y - barMargin.y;
    vertBottom = barMargin.y + barSize.x;
    vertRight = pcbSize.x + padding.x;

    if (sides[0]){
        translate([right, top])
            _bar(barSize, barLedgeWidth);
    }
    
    if (sides[0]){
        translate([left, top])
            _bar(barSize, barLedgeWidth);
    }

    if (sides[2]){
        translate([left, bottom])
            _bar(barSize, barLedgeWidth, true);
    }

    if (sides[2]){
        translate([right, bottom])
            _bar(barSize, barLedgeWidth, true);
    }

    if (sides[3]){
        translate([vertLeft, vertBottom])
            rotate([0, 0, -90]) 
            _bar(barSize, barLedgeWidth, true);
    }

    if (sides[3]){
        translate([vertLeft, vertTop])
            rotate([0, 0, -90]) 
            _bar(barSize, barLedgeWidth, true);
    }

    if (sides[1]){
        translate([vertRight, vertBottom])
            rotate([0, 0, -90]) 
            _bar(barSize, barLedgeWidth, false);
    }

    if (sides[1]){
        translate([vertRight, vertTop])
            rotate([0, 0, -90]) 
            _bar(barSize, barLedgeWidth, false);
    }
}
// module pcb_vert_holder(pcbSize, barSize, barLedgeWidth, barMargin = [5, 0.5]) {
//     xx(pcbSize.x)
//     rotate([0, 0, 90])
//     pcb_holder(vect_swap_xy(pcbSize), barSize, barLedgeWidth, barMargin);
// }


pcbSize = [100, 120, 2];
barSize = [10, 5, 5];
barLedgeWidth=5;
color("green")
    cube(pcbSize);
pcb_holder(pcbSize=pcbSize, barSize=barSize, barLedgeWidth=barLedgeWidth, padding=[2, 2], sides=[1, 1, 1, 1]);