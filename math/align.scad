use <vect.scad>
module center(sizes, center = true, centerZ = false){
    sizes = vSize(sizes);
    if (center){
        translate([-sizes[0] / 2, -sizes[1] / 2, (centerZ ? -sizes[2]/2 : 0)]){
            children();
        }
    } else {
        children();
    }   
}

module uncenter(sizes, center = true, centerZ = false){
    sizes = vSize(sizes);
    if (center){
        translate([sizes[0] / 2, sizes[1] / 2, (centerZ ? sizes[2]/2 : 0)]){
            children();
        }
    } else {
        children();
    }   
}


// center(20){
//     uncenter(20){
//         cube(20);
//     }
// }
