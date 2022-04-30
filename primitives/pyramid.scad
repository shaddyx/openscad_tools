use <../math/align.scad>
module pyramid3(size, heiht, center = false, r=0){
    // center = [size[0] / 2, size[1] / 2, size[2] / 2]
    // points = [[ 0, 0, 0], [size[0], 0, 0], [ 0, size[1], 0],
    //       [ 0, 0, 0], [size[0], 0, 0], [ 0, size[1], 0],
    //       [ 0, size[1], 0], [size[0], 0, 0], [ 0, 0, size[2]],
    //       [ 0, 0, 0], [ 0, 0, size[2]], [size[0], 0, 0],
    //       [ 0, 0, 0], [ 0, size[1], 0], [ 0, 0, size[2]]];
    // faces = [[0,1,2], [3,4,5], [6,7,8], [9,10,11], [12,13,14]];
    // polyhedron(points, faces);
}

//
//
//

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
        ],                                 // the apex point 
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
            [0, 1, 2, 3],
            [0, 1, 5, 4],
            [1, 2, 6, 5],
            [2, 3, 7, 6],
            [3, 0, 4, 7],
            [4, 5, 6, 7]
        ]);
    }
}

truncated_pyramid4([20, 20, 30], [5, 5], center = true);