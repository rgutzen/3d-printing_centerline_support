module support(){
    linear_extrude(120, convexity=10)
    //offset(1)
    scale([0.33,0.33,0.33]) 
    translate([0,-1800,0])
    import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_9/centerline_stroke.dxf");
    }
    
module cortex_shape(){ 
translate([0,0,40]) 
scale([0.95,1.15,1]) 
sphere(r=110.0, $fn=30);}

module adjusted_cortex_shape(){   translate([-14,10,-10])rotate([60,70,0])cortex_shape();}

difference(){
intersection(){support();translate([0,0,-62])adjusted_cortex_shape();}
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_9/M4_Medium_Whole_9_rotate_60_70_0.stl");
}

translate([0,0,-62])
translate([0,0,0.3])
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_9/M4_Medium_Whole_9_rotate_60_70_0.stl");