$fn=200;

diameter=18 + 0.5;
height=25;
bevel_height=2;
bevel_thickness=1;
wall_thickness=5;
hole_thickness=2;


radius=diameter/2;



difference() {
    cylinder(r=radius+wall_thickness, h=height, center=true);
    cylinder(r=radius, h=height*2, center=true);

    translate([radius, 0,0])
    cube([diameter, hole_thickness, height*2], center=true);    
    
    translate([0,0,height/2 - bevel_height/2 + 0.01])
    cylinder(r1=radius, r2=radius+bevel_thickness, h=bevel_height, center=true);

    
}

