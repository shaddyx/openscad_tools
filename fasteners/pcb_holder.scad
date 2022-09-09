use <../math/align.scad>


module _bar(barSize, barLedgeWidth, bottom=false){
    cube(barSize);
    ledgeSize = [barSize.x, barSize.y, barSize.y+ barLedgeWidth];
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

module pcb_holder(pcbSize, barSize, barLedgeWidth, barMargin){

    right = pcbSize.x - barSize.x - barMargin.x;
    left = barMargin.x;
    top = pcbSize.y;
    bottom = -barSize.y;

    translate([right, top])
        _bar(barSize, barLedgeWidth);
    translate([left, top])
        _bar(barSize, barLedgeWidth);

    translate([left, bottom])
        _bar(barSize, barLedgeWidth, true);
    translate([right, bottom])
        _bar(barSize, barLedgeWidth, true);
}


pcbSize = [100, 120, 2];
barSize = [10, 5, 5];
barMargin = [5, 0.5];
barLedgeWidth=5;
color("green")
    cube(pcbSize);
pcb_holder(pcbSize=pcbSize, barSize=barSize, barLedgeWidth=barLedgeWidth,  barMargin=barMargin);