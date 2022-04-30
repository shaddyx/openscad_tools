// bent_cube([10, 20], 90, 20);
// rotate_to_bent_face(90, 20){
//     cube([20, 20, 40]);
// }

module bent_cube(size, angle, r){
    translate([0, size[1], 0])
        rotate([90, 0, 0])
            translate([-r, 0])
                rotate_extrude(convexity = 10, angle = angle){
                    translate([r, 0]){
                        square([size[0], size[1]]);
                    }
                }
}

module rotate_to_bent_face(angle, r){
    translate([-r, 0])
        rotate([0, -angle, 0])
            translate([r, 0])
                children();
}


bent_cube([10, 20], 90, 20);
rotate_to_bent_face(90, 20){
    cube([20, 20, 40]);
}
