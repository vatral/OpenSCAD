width=111;
depth=45;
height=10;
border_size=2;


difference() {
    cube([width+(border_size*2), depth, height], center=true);
    translate([0,0,border_size])
    cube([width, depth+1, height], center=true);
}