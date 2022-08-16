use <vect.scad>
module align_center(sizes, center = true, centerZ = false, vector=[1, 1, 0]){
    xxx=vector.x;
    yyy=vector.y;
    zzz=centerZ || vector.z;
    sizes = vSize(sizes);
    if (center){
        translate([xxx ? -sizes[0] / 2 : 0, yyy ? -sizes[1] / 2: 0, zzz ? -sizes[2]/2 : 0]){
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

module align_relative(
    target_sizes, 
    source_sizes, 
    vector=[0,0,undef]
    ){
    function _aligner(t, s, v) = 
        v > 0 ? t * v:
        v < 0 ? s * v:
        (t - s) / 2;
    
    x = vector.x == undef ? 0 : _aligner(target_sizes.y, source_sizes.x, vector.x);
    y = vector.y == undef ? 0 : _aligner(target_sizes.y, source_sizes.y, vector.y);
    z = vector.z == undef ? 0 : _aligner(target_sizes.z, source_sizes.z, vector.z);
    translate([x, y, z])
        children();
}

module align_center_source_vs_target(target_sizes, source_sizes, centerZ = false){
    align_relative(target_sizes=target_sizes, source_sizes=source_sizes, vector=[0, 0, centerZ ? 1 : 0]);
    // align_uncenter(target_sizes, uncenterZ = centerZ)
    // union(){
    //     align_center(target_sizes, center = true, centerZ = centerZ)
    //         children(0);
    //     align_center(source_sizes, center = true, centerZ = centerZ)
    //         children(1);
    // }
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

target_sizes = [20, 20, 20];
source_sizes = [10, 10, 10];
color("azure",0.25)
    cube(size=target_sizes);
align_relative(target_sizes=target_sizes, source_sizes=source_sizes, vector=[0, 0, undef]){
    color("red",0.25)
        zz(20)
        cube(size=source_sizes);
}