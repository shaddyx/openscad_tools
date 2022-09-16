module toroid(innerD, d){
    rotate_extrude(convexity = 10)
    translate([innerD / 2 + d / 2, 0, 0])
    circle(r = d / 2);
}

//toroid(20, 5);
