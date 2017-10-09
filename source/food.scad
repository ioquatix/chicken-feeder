
$fa=1;

thickness=3;
outer_diameter=110;
inner_diameter=outer_diameter-(thickness*2);
height=100;
overlap=10;

module inner(offset=10) {
	translate([0, 0, thickness]) union() {
		#cylinder(h=height,d1=0,d2=inner_diameter);
		translate([-inner_diameter/8, 0, 0]) cylinder(h=height,d=inner_diameter/2);
	}
}

module funnel() {
	render() difference() {
		cylinder(h=height,d=inner_diameter);
		union() {
			height = (height-thickness);
			
			inner();
		}
	}
	
	difference() {
		cylinder(h=height-overlap,d=outer_diameter);
		cylinder(h=height,d=inner_diameter);
	}
}

module chute(offset=10) {
	intersection() {
		translate([0,0,thickness]) cylinder(h=height,d=outer_diameter);
		rotate(-40, [0, 1, 0]) translate([-height/2+offset, 0, height]) cube([height, height*2, height*3], true);
	}
}

module cover(outset=20, offset=10) {
	difference() {
		intersection() {
			cylinder(h=height,d=outer_diameter+outset);
			rotate(-40, [0, 1, 0]) translate([offset+thickness/2, 0, height]) cube([thickness, height*2, height*3], true);
		}
		
		inner();
	}
}

module dish(height=8) {
	render() difference() {
		cylinder(h=height,d=outer_diameter);
		cylinder(h=height,d=inner_diameter);
	}
}

module feeder() {
	difference() {
		funnel();
		chute();
	}
	
	dish();
}

module grooves() {
	for (y = [-110:20:110]) {
		translate([0, y, 0]) cube([outer_diameter, 1, 1], true);
	}
}

difference() {
	feeder();
	grooves();
}

cover();
