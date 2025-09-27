// PANEL GENERATOR
// Edit 2025/09/28 - cleaned up and commented, added a small gap to accommodate the PFC and help stop light bleed.


// SHOW ME THESE PARTS 
Case();
Panel();
Screen();
Bracket();
Hardware();


// VARIABLES
// might be changed if one were to use a different LCD or case.
// screen measurements (glass =76x121x6.5 to backboard)
screen_width=121.2; 
screen_height=76.5;
screen_thick=6.5;
screen_height_b=78;
screen_thick_b=1.5;
screen_width_b=122;
screen_mount_depth=4;
screen_hole_sep_w=111;
screen_hole_sep_h=68;
// panel
panel_width=219;
panel_height=90;
panel_thick=6.5;
corner=6;
screw_hole=4.5;
screw_cap=7.5;
screen_position=24;


module Case(){
    //case (4=est. front panel overlap)
    color("#111111") translate([4,panel_thick,0]) cube([211.5,220,90]); 
    //top panel (4=est. width of edge panel)
    color("#222222") translate([8,panel_thick,87.1]) cube([203.5,220,3]); 
    //feet
    color("#222222") {
        translate([4+28,panel_thick+25,-20]) cylinder(d=40,h=20, $fn=200);
        translate([4+211.5-28,panel_thick+25,-20]) cylinder(d=40,h=20, $fn=200);
        translate([4+28,panel_thick+220-25,-20]) cylinder(d=40,h=20, $fn=200);
        translate([4+211.5-28,panel_thick+220-25,-20]) cylinder(d=40,h=20, $fn=200);
    }
}


module Screw(){
    // Panel Screw Holes
    rotate([270,0,0]) cylinder(d=screw_hole,h=panel_thick+0.2, $fn=100); //hole
    rotate([270,0,0]) cylinder(d=screw_cap,h=4, $fn=100);//cap 
}

module Screen(){
    color("#555599") translate([screen_position,-0.1,(panel_height-screen_height)/2]) 
    translate([(screen_width-110)/2,-0.01,((screen_height-66)/2)+2]) cube([110, screen_thick+0.2, 66]);
    translate([screen_position,-0.01,(panel_height-screen_height)/2]) 
    difference(){  
        union () {
            color("#111111") cube([screen_width, screen_thick+0.01, screen_height]); // screen itself
            color("#115511") translate([0,screen_thick,-(screen_height_b-screen_height)/2]) cube([screen_width, screen_thick_b, screen_height_b]); // pcb
                        translate([10,1,-.4]) cube([screen_width-20, screen_thick, 0.8]); // fpc

            translate([5.1,screen_mount_depth+screen_thick+screen_thick_b,4]) { // 5.1,x,4 is the inset of the bottom left screw hole from bottom corner
                // rear mount standoffs
                                                                    rotate([90,0,0]) cylinder(d=7,h=screen_mount_depth, $fn=200);
                translate([screen_hole_sep_w,0,0])                  rotate([90,0,0]) cylinder(d=7,h=screen_mount_depth, $fn=200);
                translate([screen_hole_sep_w,0,screen_hole_sep_h])  rotate([90,0,0]) cylinder(d=7,h=screen_mount_depth, $fn=200);
                translate([0,0,screen_hole_sep_h])                  rotate([90,0,0]) cylinder(d=7,h=screen_mount_depth, $fn=200);
                // rear mount screw holes
                translate([0,screen_mount_depth,0])                                 rotate([90,0,0]) cylinder(d=3.2,h=screen_mount_depth, $fn=200);
                translate([screen_hole_sep_w,screen_mount_depth,0])                 rotate([90,0,0]) cylinder(d=3.2,h=screen_mount_depth, $fn=200);
                translate([screen_hole_sep_w,screen_mount_depth,screen_hole_sep_h]) rotate([90,0,0]) cylinder(d=3.2,h=screen_mount_depth, $fn=200);
                translate([0,screen_mount_depth,screen_hole_sep_h])                 rotate([90,0,0]) cylinder(d=3.2,h=screen_mount_depth, $fn=200);
            }
            // bracket holes
            translate([screen_width+5,panel_thick-4,(screen_height/2)+8]) rotate([270,0,0]) cylinder(d=3-.2,h=4+0.5, $fn=200);
            translate([screen_width+5,panel_thick-4,(screen_height/2)-8]) rotate([270,0,0]) cylinder(d=3-.2,h=4+0.5, $fn=200);
            translate([-5,panel_thick-4,(screen_height/2)+8]) rotate([270,0,0]) cylinder(d=3-.2,h=4+0.5, $fn=200);
            translate([-5,panel_thick-4,(screen_height/2)-8]) rotate([270,0,0]) cylinder(d=3-.2,h=4+0.5, $fn=200);
            
            translate([screen_width+5,panel_thick,(screen_height/2)+8]) rotate([270,0,0]) cylinder(d=3.5-.2,h=10+0.5, $fn=200);
            translate([screen_width+5,panel_thick,(screen_height/2)-8]) rotate([270,0,0]) cylinder(d=3.5-.2,h=10+0.5, $fn=200);
            translate([-5,panel_thick,(screen_height/2)+8]) rotate([270,0,0]) cylinder(d=3.5-.2,h=10+0.5, $fn=200);
            translate([-5,panel_thick,(screen_height/2)-8]) rotate([270,0,0]) cylinder(d=3.5-.2,h=10+0.5, $fn=200);
    }        

    // extra trim to block light
    translate([0,0,0.75-(screen_height_b-screen_height)/2]) cube([screen_width, 0.8, 0.4]);

}
}

module Bracket(){
    difference(){
        union() {    
            translate([screen_position-10,panel_thick,(panel_height/2)-25/2]) {
                cube([13,screen_thick+screen_thick_b-panel_thick+screen_mount_depth+2,25]);
            }
        }
        // deduct the screen from the bracket so as to avoid alignment issues with the holes
        Screen();
    }    
  
}

module Panel() {// front panel
    color("#555555") difference(){
        union() {
        translate([corner/2,panel_thick,corner/2]) hull(){
            rotate([90,0,0]) cylinder(d=corner,h=panel_thick,$fn=50);
            translate([panel_width-corner,0,0]) rotate([90,0,0]) cylinder(d=corner,h=panel_thick,$fn=50);
            translate([panel_width-corner,0,panel_height-corner]) rotate([90,0,0]) cylinder(d=corner,h=panel_thick,$fn=50);
            translate([0,0,panel_height-corner]) rotate([90,0,0]) cylinder(d=corner,h=panel_thick,$fn=50);
            
        }
        translate([panel_width-8-33.5,panel_thick,panel_height/2+12]) rotate([270,0,0]) cylinder(d=18,h=4.5,$fn=200);

    }
        union() {
            //screws
            translate([13, -0.01, 7.3]) Screw();
            translate([13, -0.01, panel_height-7.3]) Screw();
            translate([panel_width-13, -0.01, 7.3]) Screw();
            translate([panel_width-13, -0.01, panel_height-7.3]) Screw();
            //screen
            Screen();
            //buttons
            translate([panel_width-8-33.5+10,-.1,19]) rotate([270,0,0]) cylinder(d=12.5,h=panel_thick+.4,$fn=200);
            translate([panel_width-8-33.5-10,-.1,19]) rotate([270,0,0]) cylinder(d=12.5,h=panel_thick+.4,$fn=200);
            
            //volume
            difference(){
                translate([panel_width-8-33.5,-5.5,panel_height/2+12]) sphere(18,$fn=200);
                translate([panel_width-8-33.5-25,2.5,30]) cube([50,20,50]);
            }
            //screw hole
            translate([panel_width-8-33.5,0,panel_height/2+12]) rotate([270,0,0]) cylinder(d=12.2,h=panel_thick+0.5,$fn=200);
            translate([panel_width-8-33.5,panel_thick,panel_height/2+12]) rotate([270,0,0]) cylinder(d=7.3,h=19,$fn=200);
            //IR hole
            translate([8+8,panel_thick+0.1,17]) rotate([90,0,0]) cylinder(d1=10, d2=3, h=panel_thick+0.2,$fn=200);

            

        }
    }
 }

module Hardware() {
    // volume and buttons
    color("#111111") {
        translate([panel_width-8-33.5,2.5,panel_height/2+12]) rotate([90,0,0]) cylinder(d=32,h=13,$fn=200);
        translate([panel_width-8-33.5+10,-1,19]) rotate([270,0,0]) cylinder(d=14,h=panel_thick+.4,$fn=200);
        translate([panel_width-8-33.5-10,-1,19]) rotate([270,0,0]) cylinder(d=14,h=panel_thick+.4,$fn=200);
    }
    // visible screws
    color("#999999") {
            translate([13, -0.01, 7.3]) Screw();
            translate([13, -0.01, panel_height-7.3]) Screw();
            translate([panel_width-13, -0.01, 7.3]) Screw();
            translate([panel_width-13, -0.01, panel_height-7.3]) Screw();
            
    }

}



