
$fa=1;
thickness=2;
outer_diameter=100;

difference() {
	cylinder(h=10,d=outer_diameter+thickness);
	cylinder(h=8,d=outer_diameter);
}