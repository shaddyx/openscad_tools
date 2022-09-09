function vect_scalar_sum(v, incr) = [for (i = [0: len(v) - 1]) v[i] + incr];

function vSize(size) = (!is_list(size)) ? [size, size, size]: size; 


function vect_2d_to_3d(vect, z = 0) = [vect[0], vect[1], z];

function vect_rotate2d(vect, b) = [
    cos(b) * vect[0] - sin(b) * vect[1],
    sin(b) * vect[0] + cos(b) * vect[1]
];

function round_vect(v) = [for (i = [0: len(v) - 1]) round(v[i])];

function vect_swap_xy(v1) = [v1.y, v1.x, v1.z];

function vectorize_2(x) = is_list(x) ? [x.x, x.y] : [x, x];

function vectorize_3(x) = is_list(x) ? [x.x, x.y, x.z] : [x, x, x];

echo (vectorize_3(1));