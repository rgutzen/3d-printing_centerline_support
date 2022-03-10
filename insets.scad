module inset(){
translate([0,0,19.1])
rotate([-90,0,0])
import("/home/rgutzen/Sciebo/CSN-common/OpenBCI/Ultracortex/Mark_IV/MarkIV-FINAL/STL_Directory/M4_Hardware_insert_tight.STL");
}

translate([30,0,0])
inset();
translate([-30,0,0])
inset();
translate([0,0,0])
inset();
translate([30,30,0])
inset();
translate([-30,30,0])
inset();
translate([0,30,0])
inset();

