$fn=100;

width=20;
length=17;
height=10;

border_thickness=2;
holder_radius=3;
holder_length=2;


module holder() {
    
    difference() {
        rotate([90,90,0])  cylinder(r=holder_radius, h=holder_length, center=true);

       translate([0,-5,-4])
        rotate([15,0,0])
        cube([holder_radius*4, holder_radius*4, holder_radius*4], center=true);            
 
    }
    

}

difference() {
    cube([width, length, height], center=true);
    translate([0,0,border_thickness])
    cube([width+1, length-border_thickness*2, height], center=true);
}






translate([0,-(length/2 + holder_length/2),0]) holder();

mirror([0,1,0])
translate([0,-(length/2 + holder_length/2),0]) holder();