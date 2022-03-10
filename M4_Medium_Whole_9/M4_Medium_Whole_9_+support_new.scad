module support(){
    linear_extrude(120)
    offset(1)
    scale([3.6,3.6,3.6]) 
    translate([0,-169.2,0])
    import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_9/centerline_0.6contour.dxf");
    }
    
module cortex_shape(){
translate([7,8,10])
rotate([60,70,0])     
translate([0,0,30]) 
scale([0.95,1.05,1]) 
sphere(r=95.0);
}

intersection(){support();cortex_shape();}
   
import("/home/rgutzen/Projects/centerline/M4_Medium_Whole_9/M4_Medium_Whole_9_rotate_60_70_0.stl");
support();