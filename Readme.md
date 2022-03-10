## OpenSCAD
* open .stl file, `import(filename.stl)`
* rotate shape for ideal projection, `rotate([x,y,z])`
* save rotated shape as *filename_rotate_x_y_z.stl*
* project on xy plane, `projection()`
* save as *projection.svg*

## Python
* Run `create_centerline.py` (or snakemake) on *projection.svg*
* adjust parameters so that the polygon looks right
* save centerline as *centerline.svg*

## Inkscape
* import *centerline.svg*
* stroke path with `width=0.6mm, round join, round cap`
* Path > Stroke to Path
* `make selected segments lines`
* save as *centerline_stroke.dxf*

## OpenSCAD
```
module support()
{
    linear_extrude(120, convexity=10)
    scale([0.33,0.33,0.33])
    translate([0,-1800,0])
    import("/../centerline_stroke.dxf");
}

module cortex_shape()
{
    translate([0,0,40])
    scale([0.95,1.15,1])
    sphere(r=110.0, $fn=30);
}

module adjusted_cortex_shape()
{   
    translate([-14,10,-10])
    rotate([60,70,0])
    cortex_shape();
}

difference()
{
    intersection(){support();adjusted_cortex_shape();}
    import("/../filename_rotate_60_70_0.stl");
}

translate([0,0,0.2])
import("/../filename_rotate_60_70_0.stl");
```
