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

ALIGN_LEFT=[1, 0, 0];
ALIGN_RIGHT=[-1, 0, 0];
ALIGN_BOTTOM=[0, 0, -1];
ALIGN_TOP=[0, 0, 1];
ALIGN_BACK=[0, -1, 0];
ALIGN_FWD=[0, 1, 0];

function _aligner(target, source, align) = 
            align > 0 ? target * align:
            align < 0 ? source * align:
            (target - source) / 2;    

function aligner(target_sizes, source_sizes, vector) = [
    vector.x == undef ? 0 : _aligner(target_sizes.y, source_sizes.x, vector.x),
    vector.y == undef ? 0 : _aligner(target_sizes.y, source_sizes.y, vector.y),
    vector.z == undef ? 0 : _aligner(target_sizes.z, source_sizes.z, vector.z)
];

module align_relative(
    target_sizes, 
    source_sizes, 
    vector=[0,0,undef]
    ){
        
    // x = vector.x == undef ? 0 : _aligner(target_sizes.y, source_sizes.x, vector.x);
    // y = vector.y == undef ? 0 : _aligner(target_sizes.y, source_sizes.y, vector.y);
    // z = vector.z == undef ? 0 : _aligner(target_sizes.z, source_sizes.z, vector.z);
    translate(aligner(target_sizes, source_sizes, vector))
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

module zc(){
    translate([0, 0, -0.01])
        children();
}
module xc(){
    translate([-0.01, 0, 0])    
        children();
}
module yc(){
    translate([0, -0.01, 0])
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

// target_sizes = [20, 20, 20];
// source_sizes = [10, 10, 10];
// color("azure",0.25)
//     cube(size=target_sizes);
// align_relative(target_sizes=target_sizes, source_sizes=source_sizes, vector=[0, 0, undef]){
//     color("red",0.25)
//         zz(20)
//         cube(size=source_sizes);
// }