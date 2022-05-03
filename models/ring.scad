use <../math/vect.scad>
use <../primitives/pyramid.scad>

num = 7;    //[::non-negative integer]
upper_z = 10.0; //[::float]
middle_z = 5.0; //[::float]
bottom_z = 0.0; //[::float]
wallWidth = 2.0; //[::float]
upper_dot_x = 20.0; //[::float]
middle_dot_x = 22.2; //[::float]
boddom_dot_x = 18.0; //[::float]

dx = 0.1;
allow_bottom = true;

angle = 360 / num;
upper_dot = [upper_dot_x, 0];
middle_dot = [middle_dot_x, 0];
bottom_dot = [boddom_dot_x, 0];
inner_dot = [upper_dot[0] - wallWidth, 0];
inner_u = upper_dot_x - wallWidth;
inner_b = boddom_dot_x - wallWidth;

angle_offset = angle / 2;

function 2d_dot(vect, angle) = vect_rotate2d(vect, angle);
function dot(vect, angle, z) = vect_2d_to_3d(2d_dot(vect, angle), z);
function upperDot(angle) = dot(upper_dot, angle, upper_z);
function bottomDot(angle) = dot(bottom_dot, angle, bottom_z);
function middleDot(angle) = dot(middle_dot, angle - angle_offset, middle_z);
function a(index) = angle * index;

function adapt_index(i) = 
    i < 0 ? adapt_index(num + i) :
    i < num ? i : adapt_index(i - num);
function u(i) = adapt_index(i);
function l(i) = (adapt_index(i) + num + 1);
function r(i) = (adapt_index(i) + num + 2);
function b(i) = (adapt_index(i) + num * 2 + 2);

module test(v){
    translate(v)
        cylinder(r = 2, h = 2, center = true);
}
module draw_solid(test = false){
    points_u = [for (i = [0: num]) upperDot(a(i))];
    points_m = [for (i = [0: num]) middleDot(a(i))];
    points_b = [for (i = [0: num]) bottomDot(a(i))];

    points = concat(points_u, points_m, points_b);

    //[for (i = [0: num]) [i, (i + num * 2 + 2), (i + num + 1)]],
    faces = concat(
        [for (i = [0: num]) [u(i), b(i), l(i)]],    // center
        [for (i = [0: num]) [u(i), r(i), b(i)]],    //center
        [for (i = [0: num]) [u(i), u(i + 1), r(i)]],    // top
        [for (i = [0: num]) [b(i), r(i), b(i + 1)]],    // bottom
        [[for (i = [0: num]) adapt_index(num - i)]],
        [[for (i = [0: num]) adapt_index(i) + num * 2 + 2]]
    );


    echo("points:", points, "len:", len(points));
    echo("faces:", faces);
    polyhedron(
        points=points,                                 // the apex point 
        faces=faces);
    if (test){
        for (i = [0: len(points) - 1]){
            test(points[i]);
        }
    }
}

module draw_inner(){
    h = allow_bottom ? upper_z - bottom_z - wallWidth + dx: upper_z - bottom_z + dx * 2;
    translate([0, 0, allow_bottom ? wallWidth : - dx])
        pyramid(num, inner_b, inner_u, h, center = true);
    // points = [for (i = [0: num]) 2d_dot(inner_dot, a(i))];
    // echo("points:", points, "len:", len(points));
    // translate([0, 0, allow_bottom ? wallWidth: -1])
    //     linear_extrude(height = upper_z -bottom_z + 2)
    //         polygon(points = points);

}
difference(){
    draw_solid();
    draw_inner();    
}
// module regular_polygon(order = 4, r=1){
//      angles=[ for (i = [0:order-1]) i*(360/order) ];
//      coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
//      polygon(coords);
//  }
//  regular_polygon(r = 12, order = 8);