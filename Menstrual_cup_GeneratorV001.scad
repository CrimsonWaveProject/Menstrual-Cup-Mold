///////////////////////////////////////////
/*         THE CRIMSON WAVE PROJECT       */
/*                  2022                  */
/*                Presents                */
/*                  THE                   */
/*Parametric_Menstrual_cup_Mould_Generator*/
///////////////////////////////////////////
//              featuring:                //
//   Nose Cone OpenSCAD Library, 1.0      //
//              by ggoss                  //
//  www.thingiverse.com/thing:2004511     //
//Paraboloid OpenSCAD Script by Ablapo    //
// www.thingiverse.com/thing:84564/files  //
//
//design by Prospect3dlab                 //
// www.thingiverse.com/thing:3478622      //
///////////////////////////////////////////

//////////////////////////////////////
           /*Parameters*/
//////////////////////////////////////

Top_part_width=50;
Top_part_height=8;
Top_part_depth=50;
Mould_width=25;
Mould_depth=83;
Mould_height=50;
//Cup_width=.85; // [0.5:0.05:1.0]
//Cup_depth=.8;
//Cup_height=2.9;
Right_shift=40;
nof=50; //number of fragments
Mould_width=25;
Mould_depth=83;
Mould_height=50;
Right_shift=40;
//level of detail
nof=50; // [10, 100]

/*Renders*/
translate([10,-15,0]){
    Top_part();
}

translate([13,-8.5,0]){
    scale([1, .8,.9])
        Lip();
}
rotate([90]) {
    translate([35,22.5,-30]) {
        #scale([Cup_width/1.18,Cup_depth,Cup_height])
            Cup();
    }
}
difference(){
    Mould_R();

    translate([Right_shift/2.5,0,0])
        Stem();
    translate([Right_shift/1.9,0,0])
        Lip();
    translate([Right_shift/2.5,0,0])
        Stem_Mod();
    rotate([90]){
        translate([Right_shift,25,-41]){
            scale([Cup_width,Cup_depth,Cup_height])
                Cup();
        }
    }
}
difference(){
    Mould_L();

    Stem();
    Lip();
    Stem_Mod();
    rotate([90]){
        translate([25,25,-41]){
            scale([Cup_width,Cup_depth,Cup_height]){
                Cup();
            }
        }
    }
}
//////////////////////////////////////
           /*Modules*/
//////////////////////////////////////
module Top_part(){
    $fn=nof;
    cube([Top_part_width,Top_part_height,Top_part_depth]);
    rotate([90]){
        translate([6,5.5,-15.5])
            cylinder(10,3,3);
        translate([6,45,-15.5])
            cylinder(10,3,3);
        translate([45,5.5,-15.5])
            cylinder(10,3,3);
        translate([45,45,-15.5])
            cylinder(10,3,3);
    }
}
//  NOSE CONE LIBRARY, version 1.0
translate([-10, 20]) cone_haack(C = 0, R = 5, L = 10, s = 500);
translate([10, 20]) cone_power_series(n = 0.5, R = 5, L = 10, s = 500);
translate([30, 20]) cone_elliptical(n = 0.5, R = 5, L = 10, s = 500);
translate([50, 20]) cone_ogive_sec(rho = 8, R = 5, L = 10, s = 500);
translate([0, 40]) cone_ogive_tan(R = 5, L = 10, s = 500);
translate([20, 40]) cone_ogive_tan_blunted(R_nose = 2, R = 5, L = 10, s = 500);




module cone_haack(C = 0, R = 5, L = 10, s = 500){

// SEARS-HAACK BODY NOSE CONE:
//
// Parameters:
// C = 1/3: LV-Haack (minimizes supersonic drag for a given L & V)
// C = 0: LD-Haack (minimizes supersonic drag for a given L & D), also referred to as Von Kármán
//
// Formulae (radians):
// theta = acos(1 - (2 * x / L));
// y = (R / sqrt(PI)) * sqrt(theta - (sin(2 * theta) / 2) + C * pow(sin(theta),3));

echo(str("SEARS-HAACK BODY NOSE CONE"));
echo(str("C = ", C));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

TORAD = PI/180;
TODEG = 180/PI;

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){
    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    theta_last = TORAD * acos((1 - (2 * x_last/L)));
    y_last = (R/sqrt(PI)) * sqrt(theta_last - (sin(TODEG * (2*theta_last))/2) + C * pow(sin(TODEG * theta_last), 3));

    theta = TORAD * acos(1 - (2 * x/L));
    y = (R/sqrt(PI)) * sqrt(theta - (sin(TODEG * (2 * theta)) / 2) + C * pow(sin(TODEG * theta), 3));

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}


module cone_power_series(n = 0.5, R = 5, L = 10, s = 500){
// POWER SERIES NOSE CONE:
//
// Formula: y = R * pow((x / L), n) for 0 <= n <= 1
//
// Parameters:
// n = 1 for a cone
// n = 0.75 for a 3/4 power
// n = 0.5 for a 1/2 power (parabola)
// n = 0 for a cylinder

echo(str("POWER SERIES NOSE CONE"));
echo(str("n = ", n));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = R * pow((x_last/L), n);
    y = R * pow((x/L), n);

    rotate([0, 0, 90]) polygon(points = [[0,y_last],[0,y],[L-x,y],[L-x_last,y_last]], convexity = 10);
}
}

module cone_elliptical(n = 0.5, R = 5, L = 10, s = 500){
// ELLIPTICAL NOSE CONE:
//
// Formula: y = R * sqrt(1 - pow((x / L), 2));

echo(str("ELLIPTICAL NOSE CONE"));
echo(str("n = ", n));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = R * sqrt(1 - pow((x_last/L), 2));
    y = R * sqrt(1 - pow((x/L), 2));

    rotate([0,0,90]) polygon(points = [[0, y_last], [0, y], [x, y], [x_last, y_last]], convexity = 10);
}
}
module cone_ogive_sec(rho = 8, R = 5, L = 10, s = 500){
// SECANT OGIVE NOSE CONE:
//
// For a bulging cone (e.g. Honest John): L/2 < rho < (R^2 + L^2)/(2R)
// Otherwise: rho > (R^2 + L^2)/(2R)
//
// Formulae:
// alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2 * rho));
// y = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x),2)) + (rho * sin(TODEG * alpha));

echo(str("SECANT OGIVE NOSE CONE"));
echo(str("rho = ", rho));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

TORAD = PI/180;
TODEG = 180/PI;

inc = 1/s;

alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2*rho));

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){

    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x_last), 2)) + (rho * sin(TODEG*alpha));

    y = sqrt(pow(rho,2) - pow((rho * cos(TODEG*alpha) - x), 2)) + (rho * sin(TODEG*alpha));

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}


module cone_ogive_tan(R = 5, L = 10, s = 500){
// TANGENT OGIVE
//
//

echo(str("TANGENT OGIVE"));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

rho = (pow(R,2) + pow(L,2)) / (2 * R);

inc = 1/s;

rotate_extrude(convexity = 10, $fn = s)
for (i = [1 : s]){
    x_last = L * (i - 1) * inc;
    x = L * i * inc;

    y_last = sqrt(pow(rho,2) - pow((L - x_last), 2)) + R - rho;

    y = sqrt(pow(rho,2) - pow((L - x), 2)) + R - rho;

    rotate([0, 0, -90]) polygon(points = [[x_last - L, 0], [x - L, 0], [x - L, y], [x_last - L, y_last]], convexity = 10);
}
}

module cone_ogive_tan_blunted(R_nose = 2, R = 5, L = 10, s = 500){
// SPHERICALLY BLUNTED TANGENT OGIVE
//
//

echo(str("SPHERICALLY BLUNTED TANGENT OGIVE"));
echo(str("R_nose = ", R_nose));
echo(str("R = ", R));
echo(str("L = ", L));
echo(str("s = ", s));

rho = (pow(R,2) + pow(L,2)) / (2*R);

x_o = L - sqrt(pow((rho - R_nose), 2) - pow((rho - R), 2));
x_a = x_o - R_nose;
y_t = (R_nose * (rho - R)) / (rho - R_nose);
x_t = x_o - sqrt(pow(R_nose, 2)- pow(y_t, 2));

TORAD = PI/180;
TODEG = 180/PI;

inc = 1/s;

s_x_t = round((s * x_t) / L);

alpha = TORAD * atan(R/L) - TORAD * acos(sqrt(pow(L,2) + pow(R,2)) / (2*rho));

rotate_extrude(convexity = 10, $fn = s) union(){
    for (i=[s_x_t:s]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x_last),2)) + (rho * sin(TODEG * alpha));

        y = sqrt(pow(rho,2) - pow((rho * cos(TODEG * alpha) - x),2)) + (rho * sin(TODEG * alpha));

        rotate([0,0,-90])polygon(points = [[x_last-L,0],[x-L,0],[x-L,y],[x_last-L,y_last]], convexity = 10);
    }

    translate([0, L - x_o, 0]) difference(){
        circle(R_nose, $fn = s);
        translate([-R_nose, 0, 0]) square((2 * R_nose), center = true);
    }
}
}

module cone_biconic(R = 5, R_nose = 3, L1 = 6, L2 = 4, s = 500){

echo(str("BICONIC NOSE CONE"));
echo(str("R = ", R));
echo(str("R_nose = ", R_nose));
echo(str("L1 = ", L1));
echo(str("L2 = ", L2));
echo(str("s = ", s));

L = L1 + L2;
s_intermediate = s * (L2/L);
inc = 1/s;

rotate_extrude(convexity = 10, $fn = s) translate([0, L, 0]) rotate([0, 0, -90])
union(){
    for (i = [1 : s_intermediate]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = x_last * (R_nose/L2);
        y = x * (R_nose/L2);

        polygon(points = [[x_last, 0], [x_last, y_last], [x, y], [x, 0]], convexity = 10);
    }

    for (i=[s_intermediate:s]){

        x_last = L * (i - 1) * inc;
        x = L * i * inc;

        y_last = R_nose + ((x_last - L2) * (R - R_nose)) / L1;
        y = R_nose + ((x - L2) * (R - R_nose)) / L1;

        polygon(points = [[x_last, 0], [x_last, y_last], [x, y], [x, 0]], convexity = 10);
    }
}
}

module Mould_L() {

    difference(){
      //  scale([.001,.001,.001]){
        union(){

//////////////////////////////////////
//////////Add things here ////////////
//////////////////////////////////////
            translate([0,3,0])
                cube([Mould_width,Mould_depth,Mould_height]);
	    }

//////////////////////////////////////
////////Subtract things here//////////
//////////////////////////////////////
        $fn=nof;
        rotate([90]){
            translate([5.5,5.5,-12.5])
                cylinder(10,3,3);
            translate([5.5,45,-12.5])
                cylinder(10,3,3);
        }
        rotate([90,0,90]){
            translate([70,10,16])
                cylinder(10,3,3);
            translate([70,40,16])
                cylinder(10,3,3);
            translate([79,25,-1])
                ///////injection hole
                cylinder(25,5,1);
        }
    }
}

module Mould_R() {
    difference(){
      //  scale([.001,.001,.001]){
        union(){
            //////////////////////////////////////
            /*+ + + Add things here + + + +*/
            //////////////////////////////////////
            $fn=nof;
            translate([Right_shift,3,0])
                cube([Mould_width,Mould_depth,Mould_height]);
            rotate([90,0,90]){
                translate([70,10,33])
                    cylinder(10,3,3);
                translate([70,40,33])
                    cylinder(10,3,3);
            }
        }

        //////////////////////////////////////
        /*- - - Subtract things here - - - -*/
        //////////////////////////////////////
        $fn=nof;
        rotate([90]){
            translate([20+Right_shift,5.5,-12.5])
                cylinder(10,3,3);
            translate([20+Right_shift,45,-12.5])
                cylinder(10,3,3);
        }
    }
}




module Stem_Mod(){
    $fn=nof;
    rotate([90]){
        translate([24,25,-59])
            rotate_extrude()
                translate([2.2,0,0]){
                    circle(d=2.5);
                }
        translate([24,25,-65])
        rotate_extrude()
                translate([2.2,0,0]){
                    circle(d=2.5);
                }
        translate([24,25,-71])
            rotate_extrude()
                translate([2.2,0,0]){
                    circle(d=2.5);
                }
    }
 }


module Lip(){
    $fn=nof;
    scale([1.5,1.5,1.7]){
        rotate([90]){
            translate([14.5,14.5,-2])
                rotate_extrude()
                    translate([11.5,0,0]){
                        circle(d=2.5);
                    }
        }
    }
}
//////////////////////////////////////////////
module Stem(){
    $fn=nof;
    translate([25,80,25])
        rotate([90]){
            cylinder (38,2,2);
        }
}
  //////////////////////////////////////////////
