$fn=100;

diameter=60;
height=80;
wall_thickness=3;
bottom_thickness=3;

module body(wthickness, diam_off) {
    
    difference() {
        cylinder(h=height+bottom_thickness, r=diameter/2+wthickness*2, center=true);

        translate([0,0,bottom_thickness])
        cylinder(h=height+bottom_thickness*2, r=diameter/2 + diam_off, center=true);
    }
    
}


module floor() {
    difference() {

        color("red")
        rotate([0,25,0])
        cube([diameter*2, diameter*2, wall_thickness], center=true);
        
        body(30, 0.1);
       
    }
}


module half_pipe(length, diameter) {
    difference() {
        cylinder(h=length, r=diameter/2 + wall_thickness, center=true);
        cylinder(h=length+2, r=diameter/2, center=true);
        
        translate([diameter, 0, 0])
        cube([diameter*2, diameter*2, length+2], center=true);
    }
}


/*
difference() {
    body(wall_thickness);


    
}

*/
difference() {
    body(wall_thickness,0);

    translate([diameter/2, 0, -(height/2 - diameter/4)])
    rotate([0,90,0])
    cylinder(h=20, r=10, center=true); 
}

translate([0,0,-21])
floor();

translate([39,0,-25])
rotate([0,270,0]) 
half_pipe(20,20);
