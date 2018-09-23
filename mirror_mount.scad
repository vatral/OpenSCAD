$fn=200;
height=30;
side=10;
axis_diameter=4;

rotate([0,270,0])
difference() {
    cylinder(height,side,side, $fn=3, center=true);

    cylinder(h=height*2, r=axis_diameter/2, center=true);
}