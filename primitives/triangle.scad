module isosceles_triangle(w, h, height = undef){
    module _tr(){
        polygon(points=[
                [0,0],
                [h, w/2],
                [h, -w/2],
                [0,0]
            ]);
    }

    if (height != undef){
        linear_extrude(height=height) 
            _tr();
    } else {
        _tr();
    }
}



isosceles_triangle(20, 10);
isosceles_triangle(20, 10, 5);