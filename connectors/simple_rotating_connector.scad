use <../primitives/bent.scad>
use <../math/align.scad>
module simple_rotating_connector(size, wall_size, angle, r, center = false){
    x = size[0];
    y = size[1];

    align_center([x, y, 0], center)
        bent_tube([x, y], [x - wall_size * 2, y - wall_size * 2], angle, r);
            rotate_to_bent_face(x, angle, r)
                children();
}