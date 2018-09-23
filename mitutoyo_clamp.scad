$fn=50;

// screws for the mounting plate
screw_diameter = 3.5;
screw_distance = 22;

// size of the mounting plate
mount_width=5;
mount_thickness=12 + 20 - 15; // 12+20 goes below the extruder
mount_depth=30;

// holder plate
plate_thickness = 8;
plate_width=60;
plate_depth=30;

// clamp
hole_diameter = 8.25;  // dial indicator hole
clamp_diameter=4.1;   // screw hole for tightening the clamp
clamp_border_width = 2.5;
clamp_width = 5;
hole_space=2.5;         // space between the jaws


// Base plate
difference() {
    cutout_width = plate_width - mount_width - hole_diameter - clamp_width;
    
    cube([plate_width, plate_depth, plate_thickness], center=true);
    
    
    translate([-plate_width/2+cutout_width/2 + mount_width, plate_depth/2+(hole_diameter/2 * 1.1), 0])
    
    cube([cutout_width, plate_depth, plate_thickness+1], center=true);
    
    // dial indicator clamp hole
    translate([plate_width/2 - hole_diameter/2 - clamp_border_width, 0, 0]) {
        // hole
        cylinder(h=20, r=hole_diameter/2, center=true);
        
        // cutout
        translate([0,plate_depth/2,0])
        cube([hole_space, plate_depth, plate_thickness+1], center=true);        
    }

    // screw hole
    translate([0,plate_depth/3,0])
    rotate([0,90,0])
    cylinder(h=plate_width+1, r=clamp_diameter/2, center=true);

}

// Carriage mount
translate([-plate_width/2 + mount_width/2 , 0,plate_thickness/2+mount_thickness/2-0.1])
difference() {
    
    // mounting plate
    cube([mount_width, mount_depth, mount_thickness], center=true);

    // screw 1
    translate([0, screw_distance/2,mount_thickness/2 - screw_diameter])
    rotate([0,90,0])
    cylinder(r=screw_diameter/2, h=mount_width+1, center=true);
    
    // screw 2
    translate([0, -screw_distance/2,mount_thickness/2 - screw_diameter])
    rotate([0,90,0])
    cylinder(r=screw_diameter/2, h=mount_width+1, center=true);
    
}