module toroid(innerD, r){
    rotate_extrude(convexity = 10)
    translate([innerD / 2, 0, 0])
    circle(r = r / 2);
}

//toroid(20, 5);
