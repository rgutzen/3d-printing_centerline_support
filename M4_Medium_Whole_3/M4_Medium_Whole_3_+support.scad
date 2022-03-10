module support(){
    linear_extrude(130, convexity=10)
    //offset(1)
    scale([0.305,0.305,0.305]) 
    translate([-2,-1985,0])
    import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_3/centerline_stroke.dxf");
    }
    
module cortex_shape(){ 
translate([0,0,40]) 
scale([0.95,1.15,1]) 
sphere(r=110.0, $fn=32);}

module adjusted_cortex_shape(){   translate([-1,-27,-7])rotate([-75,55,0])cortex_shape();}

difference(){
intersection(){support();
translate([0,0,-73])adjusted_cortex_shape();}

translate([0,0,-73])
rotate([0,10,0])
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_3/M4_Medium_Whole_3_-75_45_0.stl");
}

translate([0,0,-73])
translate([0,0,0.3])
rotate([0,10,0])
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_3/M4_Medium_Whole_3_-75_45_0.stl");

//support();
//adjusted_cortex_shape();
//rotate([0,10,0])
//import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_3/M4_Medium_Whole_3_-75_45_0.stl");