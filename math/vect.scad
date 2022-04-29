function vect_scalar_sum(v, incr) = [for (i = [0: len(v) - 1]) v[i] + incr];

function vSize(size) = (!is_list(size)) ? [size, size, size]: size; 

