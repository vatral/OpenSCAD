// CSG.scad - Basic example of CSG usage


$fn=60;
thickness=10;
frame_thickness=17;
hook_length=30;
hook_height=12;
hook_thickness=8;
hook_hole_depth=10;
hook_hole_diameter=3;
hook_hole_body_diameter=4;
rod_diameter=8;
foot_size=10;
foot_hole_diameter=3;
cable_hole_diameter=10;



difference() {

    union() {
        // Main body
        cube([136, 60, thickness]);
        
        // Hook
        translate([136, 60-hook_height, 0]) {
            cube([frame_thickness, hook_height, thickness]);
            
            translate([frame_thickness, -(hook_length-hook_height), 0]) {
                cube([hook_thickness, hook_length, thickness]);
            }
        }
        
        // Foot
        translate([136-foot_size, -(20-foot_size), 0]) {
            difference() {
                cube([foot_size, foot_size, thickness]);
                
                // Screw hole
                translate([-foot_size/2, foot_size/2, thickness/2]) {
                    rotate([0, 90, 0]) { 
                        cylinder(h=foot_size*2, r=foot_hole_diameter/2);
                    }
                }
            }
        
        }
    }

    // Big hole
    translate([70, 60, thickness/2]) {
       cylinder(h=thickness*2, r=75/2, center=true);
    }


    // Rod hole
    translate([rod_diameter/2 + 5, 60-rod_diameter/2, thickness/2]) {
        translate([-rod_diameter/2, 0, -thickness]) {
            cube([rod_diameter, rod_diameter*2, thickness*2]);
        }
        cylinder(h=thickness*2, r=rod_diameter/2, center=true);
    }
    

    // Cable hole
    translate([40, 10, thickness/2]) {
        cylinder(h=thickness*2, r=cable_hole_diameter/2, center=true);
    }


    // Cutoff
    rotate([0, 0, 45]) {
        translate([0, 0, thickness/2]) {
        cube([50, 50, thickness*2], center=true);
        }
    }
    
    
    // Hook hole
    translate([137, 70 - hook_height - (hook_length/2), thickness/2]) {
        rotate([0,90,0]) {
            cylinder(h=500, r=hook_hole_diameter/2);
        }
    }    

    // Body hole
    translate([137 - hook_hole_depth, 70 - hook_height - (hook_length/2), thickness/2]) {
        rotate([0,90,0]) {
            cylinder(h=hook_hole_depth+1, r=hook_hole_body_diameter/2);
        }
    }        
}




echo(version=version());
// Written by Marius Kintel <marius@kintel.n6et>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
