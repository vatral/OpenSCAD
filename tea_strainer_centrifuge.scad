$fn=100;

diameter=60;
height=72;
wall_thickness=2 ;
bottom_thickness=2;

ring_height=5;
ring_add_diameter=5;
flare_add_diameter=15;

hole_diameter=6;
holder_bottom_thickness=5;

body_wall_thickness = 1;

magnet_width=20 + 0.5;
magnet_height=10 + 0.5;
magnet_depth=2 + 1;
magnet_width_border=2;
magnet_height_border=2;


empty_add_diameter = 2.5;
empty_add_height = 10;

spout_width = 20;
spout_height = 10;
spout_length = 20;


magnet_plate_height=3;
magnet_plate_motor_diameter=10;
magnet_plate_motor_height=1;
magnet_plate_indent_length=3;
magnet_plate_indent_width=2;
magnet_plate_indent_height=2;


floor_angle=3.5;

_holder_total_height   = height+bottom_thickness;
_holder_total_diameter = diameter+ring_add_diameter + wall_thickness * 2;

_body_total_height     = _holder_total_height   + empty_add_height;
_body_total_diameter   = _holder_total_diameter + empty_add_diameter+body_wall_thickness*2;

module body(wthickness, diam_off) {
    color("red")
    difference() {
        //cylinder(h=_body_total_height, r=(diameter+wthickness*4 + ring_add_diameter + empty_add_diameter)/2, center=true);
        cylinder(h=_body_total_height, r=( _holder_total_diameter + wthickness*2 + empty_add_diameter)/2, center=true);

        translate([0,0,bottom_thickness])
        cylinder(h=height+bottom_thickness+empty_add_height, r=(diameter + wall_thickness*2 + diam_off + ring_add_diameter + empty_add_diameter)/2, center=true);


        // Spout hole
        translate([50/2, 0, -(_body_total_height/2 - spout_height/2 - bottom_thickness) ])
        cube([50, spout_width, spout_height], center=true);


    }


}

module body_spout() {
    color("blue")
    difference() {
        cube([spout_length, spout_width + wall_thickness, spout_height + bottom_thickness ], center=true);
        translate([0,0,bottom_thickness + 0.01])
        cube([spout_length + 0.01, spout_width, spout_height + bottom_thickness], center=true);
    }
}

module holder_body() {
    half_height=(height+holder_bottom_thickness)/2;
    
    difference() {
        union() {
            // Body
            cylinder(h=height+holder_bottom_thickness, r = diameter/2 + wall_thickness, center=true);
            
            // Flare
            translate([0,0,half_height-ring_height/2])
            cylinder(h=ring_height, r1=diameter/2 + wall_thickness + ring_add_diameter/2,  r2=diameter/2 + wall_thickness + flare_add_diameter/2, center=true);
            
            // Upper ring
            translate([0,0,half_height-ring_height/2 - ring_height])
            cylinder(h=ring_height, r=diameter/2 + wall_thickness + ring_add_diameter/2, center=true);

            // Upper ring bevel
            translate([0,0,half_height-ring_height/2 - ring_height*2])
            cylinder(h=ring_height, r2=diameter/2 + wall_thickness + ring_add_diameter/2, 
            r1 = diameter/2,center=true);
            
        }
        
        // Hollow out
        translate([0,0,holder_bottom_thickness/2+0.01])
        cylinder(h=height, r=diameter/2 , center=true);    
    
    
        // Side holes 
        for(angle=[0:20:180]) {
            echo(angle);
            for(height=[-half_height+hole_diameter+holder_bottom_thickness:10:half_height-ring_height*2]) {
        
        
                translate([0,0,height])
                rotate([angle, 90, 0])
                cylinder(h=diameter*2, r=hole_diameter/2, center=true);
            }
        }
        
        
        // Floor holes
        distance=diameter/2 - hole_diameter;
        for(angle=[0:30:360]) {
    //        for(distance=[0:hole_diameter*2:diameter/2]) {
                rotate([0,0,angle])
                translate([0,distance, -half_height + ring_height/2])            
                cylinder(h=100, r=hole_diameter/2, center=true);
    //        }
        }
        

   
    }
}


module holder_lower_ring() {
    half_height=(height+holder_bottom_thickness)/2;
    
    /* Lower ring */
    difference() {
        translate([0,0,-half_height + ring_height/2 ])
        cylinder(h=ring_height, r=diameter/2 + wall_thickness + ring_add_diameter/2, center=true);
        
        for(angle=[0:30:180]) {
      
            translate([0,0,-half_height + ring_height/2])
            rotate([angle,90,0])
            cube([ring_height+1,diameter*2,ring_height], center=true);
        }
    }    
}




module holder() {
    half_height=(height+holder_bottom_thickness)/2;
    
    difference() {
        union() {
            difference() {
                union() {
                    holder_body();
                    holder_lower_ring();
                }
               
               
                // Floor holes
                distance=diameter/2 - hole_diameter;
                for(angle=[0:30:360]) {
                    rotate([0,0,angle])
                    translate([0,distance, -half_height + ring_height/2])            
                    cylinder(h=100, r=hole_diameter/2, center=true);
                } 
            }
            
            /* Magnet holder fillers */
            translate([diameter/2 -  (magnet_width+magnet_width_border)/2 , 0, -half_height + holder_bottom_thickness/2 ])
            cube([magnet_width+magnet_width_border, magnet_height+magnet_height_border, holder_bottom_thickness], center=true);

            /* Magnet holder fillers */
            translate([-(diameter/2 -  (magnet_width+magnet_width_border)/2) , 0, -half_height + holder_bottom_thickness/2 ])
            cube([magnet_width+magnet_width_border, magnet_height+magnet_height_border, holder_bottom_thickness], center=true);
        }
      
        // Magnet holders 
        color("red")
        translate([diameter/2 -  magnet_width/2 , 0, -half_height + magnet_depth/2 - 0.01])
        cube([magnet_width, magnet_height, magnet_depth], center=true);

        color("green")
        translate([-(diameter/2 -  magnet_width/2 ), 0, -half_height + magnet_depth/2 - 0.01])
        cube([magnet_width, magnet_height, magnet_depth], center=true); 
    
    }

}


module floor() {
    difference() {

        color("green")
        rotate([0,floor_angle,0])
        cube([diameter*2, diameter*2, wall_thickness], center=true);
        
        body(60, 0.1);
       
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


module magnet_holder() {
    half_height=magnet_plate_height/2;
    l_off = magnet_plate_motor_diameter/2 - magnet_plate_indent_length/2;
    z_off = -(half_height - magnet_plate_motor_height/2 - magnet_plate_indent_height/2);

    
    difference() {
        cylinder(r=_holder_total_diameter/2, h=magnet_plate_height, center=true);
    
        
        // Magnet holders 
        color("red")
        translate([diameter/2 -  magnet_width/2 , 0, half_height - magnet_depth/2 + 0.01])
        cube([magnet_width, magnet_height, magnet_depth], center=true);

        color("green")
        translate([-(diameter/2 -  magnet_width/2 ), 0, half_height - magnet_depth/2 + 0.01])
        cube([magnet_width, magnet_height, magnet_depth], center=true); 
        
        translate([0,0,-half_height + magnet_plate_motor_height/2 - 0.01])
        cylinder(r=magnet_plate_motor_diameter/2, h=magnet_plate_motor_height, center=true);

        color("blue")
        translate([l_off ,0, z_off])
        cube([magnet_plate_indent_length, magnet_plate_indent_width, magnet_plate_indent_height], center=true);
        
        color("blue")
        translate([-l_off ,0, z_off])
        cube([magnet_plate_indent_length, magnet_plate_indent_width, magnet_plate_indent_height], center=true);

        color("blue")
        translate([0, l_off, z_off])
        cube([magnet_plate_indent_width, magnet_plate_indent_length, magnet_plate_indent_height], center=true);

        color("blue")
        translate([0, -l_off, z_off])
        cube([magnet_plate_indent_width, magnet_plate_indent_length, magnet_plate_indent_height], center=true);
        
    }


    
}




/*


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
*/



//translate([0,0,10])
holder();

//translate([0,0,-(height/2 + 10) ])
//magnet_holder();


/*
body(body_wall_thickness, 0);

translate([0,0,-(_body_total_height/2 - bottom_thickness/2 - 2.2)]) floor();

difference() {
    
    translate([_body_total_diameter/2,0,-(_body_total_height/2 - (spout_height+bottom_thickness)/2 - 0.01)])
    body_spout();
    
    cylinder(h=height*2, r=_body_total_diameter/2 - 0.1, center=true);
}



translate([0,0, -(_body_total_height/2 - 2/2 - 0.01) ])

difference() {
    cube([10,(_body_total_diameter+6),2], center=true);
    cylinder(h=height*2, r=_body_total_diameter/2 - 0.01, center=true);
    
    difference() {
        cylinder(h=height*2, r=_body_total_diameter , center=true);
        cylinder(h=height*2, r=_body_total_diameter/2 +2, center=true);
    }
}

*/