module top_part(full_size, height, dx = 0.01){
    size_to_differ = [full_size.x + dx * 2, full_size.y + dx*2, full_size.z - height + dx];
    difference() {
        children();
        translate([-dx, -dx, -dx]) 
        cube(size_to_differ);
    }
}

module bottom_part(full_size, height, dx = 0.01){
    size_to_differ = [full_size.x + dx * 2, full_size.y + dx*2, full_size.z - height + dx];
    difference() {
        children();
        translate([-dx, -dx, height]) 
        cube(size_to_differ);
    }
}

top_part(full_size = [100, 100, 100], height = 10)
    cube([100, 100, 100]);

bottom_part(full_size = [100, 100, 100], height = 10)
    cube([100, 100, 100]);