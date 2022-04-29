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
        translate([sizes[0] / 2, sizes[1] / 2, (centerZ ? sizes[2]/2 : 0)]){
            children();
        }
    } else {
        children();
    }   
}


// align_center(20){
//     align_uncenter(20){
//         cube(20);
//     }
// }
