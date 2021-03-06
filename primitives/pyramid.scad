use <../math/align.scad>
use <../math/vect.scad>

module pyramid4(sizes, center){
    align_uncenter(sizes, !center){
        size = [sizes[0] / 2 , sizes[1] / 2, sizes[2]];
        polyhedron(
        points=[ 
            [size[0],size[1],0],
            [size[0],-size[1],0],
            [-size[0],-size[1],0],
            [-size[0],size[1],0], // the four points at base
            [0,0,size[2]]  
        ],                                
        faces=[ 
            [0,1,4],
            [1,2,4],
            [2,3,4],
            [3,0,4],              // each triangle side
            [1,0,3],
            [2,1,3] 
        ]                         // two triangles for square base
        );
    }
}

//
// 
// truncated_pyramid4([20, 20, 30], [5, 5], center = false);
//
module truncated_pyramid4(sizes, top_sizes, center = true){
    align_uncenter(sizes, !center){
        size = [sizes[0] / 2 , sizes[1] / 2, sizes[2]];
        top_size = [top_sizes[0] / 2 , top_sizes[1] / 2];
        h = size[2];
        polyhedron(
        points=[ 
            [size[0], size[1], 0],
            [size[0], -size[1], 0],
            [-size[0], -size[1], 0],
            [-size[0], size[1], 0], // the four points at base

            [top_size[0], top_size[1], h],
            [top_size[0], -top_size[1], h],
            [-top_size[0], -top_size[1], h],
            [-top_size[0], top_size[1], h],
        ],                                 // the apex point 
        faces=[ 
            [3, 2, 1, 0],
            [0, 1, 5, 4],
            [1, 2, 6, 5],
            [2, 3, 7, 6],
            [3, 0, 4, 7],
            [4, 5, 6, 7]
        ]);
    }
}

// truncated_pyramid4([20, 20, 30], [15, 5], center = true);


module pyramid(angles, r, r1, h, center = true){
    function _2d_dot(vect, angle) = vect_rotate2d(vect, angle);
    function _dot(vect, angle, z) = vect_2d_to_3d(_2d_dot(vect, angle), z);
    function _adapt_index(i, num) = 
        i < 0 ? _adapt_index(num + i, num) :
        i < num ? i : _adapt_index(i - num, num);
    function _du(i, num) = _adapt_index(i, num) + num;
    function _db(i, num) = _adapt_index(i, num);

    vect = [r, 0];
    vectU = [r1, 0];
    angle = 360 / angles;
    points = concat(
        [for (i = [0: angles - 1]) _dot(vect, i * angle, 0)],
        [for (i = [0: angles - 1]) _dot(vectU, i * angle, h)]
    );

    faces = concat(
        [[for (i = [0: angles - 1]) _db(i, angles)]],
        [[for (i = [0: angles - 1]) _du(angles - i, angles)]],
        [for (i = [0: angles]) [
            _db(i, angles),
            _du(i, angles), 
            _du(i + 1, angles), 
            _db(i + 1, angles) 
            ]
        ]
    );
    polyhedron(points=points, faces=faces);
}

pyramid(4, 20, 10, 50);