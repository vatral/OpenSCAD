$fn=200;

bearing_height=7;
bearing_diameter=22;
bearing_bevel_diameter=24;
bearing_bevel_height=1;
bearing_inner_diameter=10;

reel_diameter=52;
reel_depth=10;

reel_flare=5;
reel_flare_depth=5;

difference() {
    union() {
        color("red")
        cylinder(h=reel_depth, r=reel_diameter/2, center=true);
        
        color("green")
        translate([0,0,reel_depth/2 + reel_flare_depth/2- 0.01])
        cylinder(h=reel_flare_depth, r=reel_diameter/2 + reel_flare, center=true);
    }
    


    cylinder(h=100, r=bearing_inner_diameter/2, center=true);

    color("blue")
    translate([0,0,reel_depth/2 + reel_flare_depth - bearing_height/2 + 0.01  ])
    cylinder(h=bearing_height, r=bearing_diameter/2, center=true);

    


    translate([0,0,reel_depth/2 + reel_flare_depth - bearing_bevel_height/2 ])
    cylinder(h=bearing_bevel_height, r=bearing_bevel_diameter/2, center=true);    
    
}






