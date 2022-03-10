module support(){
    linear_extrude(160, convexity=10)
    //offset(1)
    scale([0.355,0.355,0.355]) 
    translate([0,-452,0])
    import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_2/centerline_stroke.dxf");
    }
    
module cortex_shape(){ 
translate([0,0,40]) 
scale([0.95,1.15,1]) 
sphere(r=110.0, $fn=30);}

module adjusted_cortex_shape(){translate([0,-23,-17])rotate([-60,0,0])cortex_shape();}

difference(){
intersection(){support();translate([0,0,-91.9])adjusted_cortex_shape();}
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_2/M4_Medium_Whole_2_rotate_-60_0_0.stl");
}

translate([0,0,-91.9])
translate([0,0,0.3])
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_2/M4_Medium_Whole_2_rotate_-60_0_0.stl");
