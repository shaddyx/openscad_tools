use <vect.scad>
module align_center(sizes, center = true, centerZ = false){
    sizes = vSize(sizes);
    if (center){
        translate([-sizes[0] / 2, -sizes[1] / 2, (centerZ ? -sizes[2]/2 : 0)]){
            children();
        }
    } else {
        children();
    }   
}

module align_uncenter(sizes, uncenter = true, uncenterZ = false){
    sizes = vSize(sizes);
    if (uncenter){
        translate([sizes[0] / 2, sizes[1] / 2, (uncenterZ ? sizes[2]/2 : 0)]){
            children();
        }
    } else {
        children();
    }   
}

module align_center_source_vs_target(target_sizes, source_sizes, centerZ = false){
    align_uncenter(target_sizes, uncenterZ = centerZ)
    union(){
        align_center(target_sizes, center = true, centerZ = centerZ)
            children(0);
        align_center(source_sizes, center = true, centerZ = centerZ)
            children(1);
    }
}

module zz(z){
    translate([0, 0, z])
        children();
}

module xx(x){
    translate([x, 0, 0])
        children();
}

module yy(y){
    translate([0, y, 0])
        children();
}

// align_center_source_vs_target([100, 100, 1], [10, 10, 10], centerZ = false){
//     cube([100,100,1]);
//     cube([10,10,10]);
// }

// align_center(20){
//     align_uncenter(20){
//         cube(20);
//     }
// }
