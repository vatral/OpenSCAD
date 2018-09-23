$fn=100;

thickness=1;
wall_thickness=1;
wall_height=7.5;
diameter=72 - 0.1;

snowflake= "\u2744";
heart    = "\u2764";
tree     = "\U01F384";
star     = "\u2736";
cstar    = "\u2742";

pattern=snowflake;
tfont="DejaVu Sans";
//tfont="Android Emoji:style=Regular";
font_size=20;


radius=diameter/2;

difference() {
    cylinder(r=radius, h=thickness, center=true);

    linear_extrude(height=thickness*2, center=true)
    text(text=pattern, size=font_size, halign="center", valign="center", font=tfont);
}

translate([0,0,-(thickness/2 - wall_height/2 - 0.01)])
color("red")
difference() {
    cylinder(r=radius+wall_thickness, h=wall_height, center=true);
    cylinder(r=radius, h=wall_height*2, center=true);
}