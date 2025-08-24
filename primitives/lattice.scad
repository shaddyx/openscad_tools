module ortogonal_lattice_cell(
  d = 10,
  h = 10
) {
  $fn = 6;
  a = 360 / 6;
  rh = (d / 2) * sqrt(3);
  scaleH = h / rh;
  rotate([0, 0, 0])
    scale([1, 1.155, 1])
      cylinder(h=h, d=d, center=false);
}

module ortogonal_lattice(
  size = [100, 100, 10],
  m = 1,
  cell_d = 10,
) {
    cell_w = cell_d / 1.34;
    cell_h = cell_d;
    addonSize = (cell_h + m) / 4;
    module raw(){
        //* sqrt(3)    
        // number of elements can be fit in the lattice by x and y axis
        elementsCountX = floor((size.x - m) / (cell_w + m));
        elementsCountY = floor((size.y - m) / (cell_h + m)) + 1;
        echo("elementsCountX", elementsCountX);
        echo("elementsCountY", elementsCountY);

        // the space between the start and the first element
        additionalSpaceX = size.x - m - elementsCountX * (cell_w + m);
        additionalSpaceY = size.y - m - elementsCountY * (cell_h + m);
        echo("additionalSpaceX", additionalSpaceX);
        echo("additionalSpaceY", additionalSpaceY);

        start = m;
        end = size[0] - m;

        for (x = [0:1:elementsCountX]) {
            addon = (x % 2 == 0) ? addonSize : -addonSize;
            for (y = [0:1:elementsCountY]) {
            translate([
                    start + x * (cell_w + m),
                    addon + start + y * (cell_h + m),
                    0,
                ])
                ortogonal_lattice_cell(
                    cell_d,
                    size.z
                );
                // cylinder(h=size.z, d=cell_d, center=false);
            }
        }
    }
    module boundary_mask(){
        difference() {
            translate([-cell_d*2, -cell_d*2, 0]) 
                cube([size.x + cell_d*4, size.y + cell_d*4, size.z + 1]);    
            translate([0, 0, -0.5]) cube([size.x, size.y, size.z + 2]);
        }
    }
    difference() {
        translate([addonSize, 0, 0]) raw();
        translate([0, 0, -0.5]) boundary_mask();
    }
}

module circle_lattice(
    d = 100,
    cell_d = 10,
    h = 10
) {
    module mask(){
        difference() {
            cylinder(h = h + 1, r = d + cell_d);
            cylinder(h = h + 1, r = d/2);
        }
    }
    difference() {
        translate([-d/2, -d/2, 0]) ortogonal_lattice(cell_d=cell_d, size=[d, d, h]);
        translate([0, 0, -0.5]) mask();
    }
}


circle_lattice();


// ortogonal_lattice(cell_d=10);
// ortogonal_lattice_cell(d=60);
