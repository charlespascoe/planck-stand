module rounded_cube(dim, r) {
    d = min(min(dim), 2*r);

    translate([d/2, d/2, d/2])
    minkowski() {
        cube([dim[0]-d, dim[1]-d, dim[2]-d]);

        sphere(d=d);
    }
}

module rounded_square(dim, r) {
    d = min(min(dim), 2*r);

    translate([d/2, d/2, d/2])
    minkowski() {
        square([dim[0]-d, dim[1]-d]);

        circle(d=d);
    }
}

module planck_stand(recess_width, recess_depth, angle, stand_thickness=4, planck_case_radius=3, planck_case_height=85) {
    external_height=planck_case_height+stand_thickness*2;
    external_radius=planck_case_radius+stand_thickness;

    difference() {
        translate([0, 0, external_height])
        rotate([0, 90, 0])
        linear_extrude(height=planck_case_height)
        rounded_square([external_height, external_height], r=external_radius);

        // The -1 and +2 are to avoid visual artifacts when in preview mode
        translate([-1, -1, recess_width+stand_thickness]) 
        cube(planck_case_height+stand_thickness*2+2);

        // Two cutouts to make the flat surface the keyboard will sit on

        translate([-planck_case_height+recess_depth, stand_thickness, stand_thickness])
        rounded_cube([planck_case_height, planck_case_height, planck_case_height], r=planck_case_radius);

        translate([recess_depth+stand_thickness, stand_thickness, stand_thickness])
        rounded_cube([planck_case_height, planck_case_height, planck_case_height], r=planck_case_radius);

        // The -1 is to avoid visual artifacts when in preview mode
        translate([recess_depth+stand_thickness/3, planck_case_height+stand_thickness*2, -1])
        rotate([0, 0, -90+angle])
        cube(2*(planck_case_height+stand_thickness*2));
    }
}

planck_stand(angle=12, recess_width=20, recess_depth=8, $fn=100);
