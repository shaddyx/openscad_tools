use <../math/vect.scad>

// bent_cube([10, 20], 90, 20);
// rotate_to_bent_face(90, 20){
//     cube([20, 20, 40]);
// }


module bent_2d(angle, r){
    mirror([0, 1 ,0])
    mirror([1, 0, 0])
        rotate([90, 0, 0])
            //translate([-r, 0])
                rotate_extrude(convexity = 10, angle = angle){
                    translate([r, 0])
                        children();
                }
}


module bent_cube(size, angle, r){
    translate([size[0] + r, 0, 0])
        bent_2d(angle, r)
            square([size[0], size[1]]);
}

// bent_tube([10, 50], [8, 48], 90, 20);

module bent_tube(size, size1, angle, r){
    translate([size[0] + r, 0, 0])
        bent_2d(angle, r){
            difference(){
                square([size[0], size[1]]);
                    translate([(size[0] - size1[0])/2, (size[1] - size1[1])/2])
                        square([size1[0], size1[1]]);
            }
        }
}

module rotate_to_bent_face(x, angle, r){
    //translate([result[1] * 2, 0, 0])
        //rotate([0, angle, 0])
            translate([ -r - x, 0])
                children();
}
 
bent_tube([10, 30], [8, 28], 90, 40);
rotate_to_bent_face(20, 90, 40){
    cube([20, 20, 40]);
}

// rotate_extrude(convexity = 10, angle = 90)
// square([10, 20]);

// mirror([1, 0, 0])
// angle = 45;
// rotate([-90, 0, 0])
// rotate_extrude(convexity = 10, angle = angle)
// translate ([-30, 0])
// polygon([[15,10], [30,10], [15, 15]]);