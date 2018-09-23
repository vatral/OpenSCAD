width=155;
depth=30;
height=10;
border_size=2;


difference() {
    cube([width, depth, height], center=true);
    translate([0,0,border_size])
    cube([width-(border_size*2), depth+1, height], center=true);
}