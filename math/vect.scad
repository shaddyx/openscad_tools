function vect_scalar_sum(v, incr) = [for (i = [0: len(v) - 1]) v[i] + incr];

function vSize(size) = (!is_list(size)) ? [size, size, size]: size; 

function vect_rotate2d(vect, b) = [
    cos(b) * vect[0] - sin(b) * vect[1],
    sin(b) * vect[0] + cos(b) * vect[1]
];