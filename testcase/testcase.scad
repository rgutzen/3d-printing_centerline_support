module thing() {
    translate([0,0,30]) rotate([10,20,30]) {
        difference() {
            cylinder(r=10, h=10);
            translate([0,0,-1]) cylinder(r=9, h=12);
        }
        translate([9,0,5]) rotate([0,90,0]) cylinder(r=3, h=30, $fn=20);
    }
}

linear_extrude(1)
projection()
thing();
