$fn=100;

holder_slot_width=4.7;
holder_length=70/2;
holder_width=8;
holder_height=15;

motor_diameter=4;
screw_hole_diameter=3;


difference() {
    cube([holder_length, holder_width, holder_height], center=true);
    translate([0,0,holder_height/2])
    cube([holder_length+1, holder_slot_width, holder_height], center=true);
    cylinder(r=motor_diameter/2, h=holder_height*2, center=true);
    
    translate([0,holder_width/2,-holder_height/4])
    rotate([90,0,0])
    cylinder(r=screw_hole_diameter/2, h=holder_width+1, center=true);
}