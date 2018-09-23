$fn=70;


difference() {
    cylinder(h=3.5, r=4, center=true);
    cylinder(h=5, r=2, center=true);
}


difference() {
    cylinder(h=3.5, r=17/2, center=true); 
    cylinder(h=5, r=12/2, center=true);
}

rotate_extrude(convexity=10)
translate([20/2 - 3.5/2,0,0])
circle(r=3.5/2);