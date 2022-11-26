///////////////////////////////////////////
/*         THE CRIMSON WAVE PROJECT       */
/*                  2022                  */
/*                Presents                */
/*                  THE                   */
/*Parametric_Menstrual_cup_Mould_Generator*/
///////////////////////////////////////////
// featuring
//
// Nose Cone OpenSCAD Library, 1.0
// by ggoss
// https://www.thingiverse.com/thing:2004511
// Paraboloid OpenSCAD Script by Ablapo
// https://www.thingiverse.com/thing:84564/files
// design by Prospect3dlab https://www.thingiverse.com/thing:347
//  https://en.m.wikibooks.org/wiki/OpenSCAD_User_Manual/Customizer

///////////////////////////////////////////
/*                Renders                */
///////////////////////////////////////////
translate([ 10, -15, 0 ])
{
    difference(){
    Top_part(); 
    drainage_canals();
    }
    difference(){
    Lip_base();
    drainage_canals();
        }
   
}


rotate([90])
{
    translate([ 35, 22.5, -30 ])
    {
        scale([ Cup_width / 1.18, Cup_depth, Cup_height ]) 
        Cup();
    }
}
difference()
{
Mould_R();
    translate([ Right_shift / 2.5, 0, 0 ]) 
    Stem();
    translate([ Right_shift / 2.7, -5, 0 ])
    Lip_base();
    translate([ Right_shift / 2.4, 5, 0 ]) 
    Lip();
    translate([ Right_shift / 2.5, 0, 0 ]) 
    Stem_Mod();
    rotate([90])
    {
        translate([ Right_shift, 25, -41 ])
        {
            scale([ Cup_width, Cup_depth, Cup_height ]) Cup();
        }
    }
}
difference()
{
Mould_L();
    Stem();
    translate([ 0, -5, 0 ])
    {
    Lip_base();
    }
     translate([ 0, 5, 0 ]){
    Lip();}
    Stem_Mod();
    rotate([90])
    {
        translate([ 25, 25, -41 ])
        {
            scale([ Cup_width, Cup_depth, Cup_height ]) Cup();
        }
    }
}

//////////////////////////////////////
/*         Parameters               */
//////////////////////////////////////
Top_part_width = 50;
Top_part_height = 8;
Top_part_depth = 50;
Mould_width = 25;
Mould_depth = 83;
Mould_height = 50;
Cup_width = .85;
Cup_depth = .8;
Cup_height = 2.9;
Right_shift = 40;
nof = 60; // number of fragments

// Paraboloid OpenSCAD Script (parameters)
/////////////////////////////////////////
y = 18.5; // y = height of paraboloid
f = 5;    // f = focus distance
rfa = 4.8;
// rfa=radius of the focus area : 0=point focus
fc = 1;
// fc : 1 = center paraboloid in focus point(x=0, y=f);
detail = 100; // detail = $fn of cone
// 0 = center paraboloid on top (x=0, y=0)
hi = (y + 2 * f) / sqrt(2);
// height and rad of the cone-> alpha = 45°-> sin(45°)=1/sqrt(2)
x = 2 * f * sqrt(y / f); // x  = half size of parabola

//////////////////////////////////////
/*             Modules              */
//////////////////////////////////////
module
Top_part()
{
    $fn = nof;
    cube([ Top_part_width, Top_part_height, Top_part_depth ]);
    rotate([90])
    {
        translate([ 6, 5.5, -15.5 ]) cylinder(10, 3, 3);
    }
    rotate([90])
    {
        translate([ 6, 45, -15.5 ]) cylinder(10, 3, 3);
    }
    rotate([90])
    {
        translate([ 45, 5.5, -15.5 ]) cylinder(10, 3, 3);
    }
    rotate([90])
    {
        translate([ 45, 45, -15.5 ]) cylinder(10, 3, 3);
    }
    
}
module
 drainage_canals()
{
    $fn = nof;
    rotate([90]){
        translate([6.5,23,-15.8]){
    cylinder(20,1.3,1.3);
     
    
        }
    }
     rotate([90]){
        translate([43,23,-15.8]){
    cylinder(20,1.3,1.3);
     
    
        }
    }
}
module
Cup()hull()
{

    translate([ 0, 0, -f * fc ])                     // center on focus
        rotate_extrude(convexity = 10, $fn = detail) // extrude paraboild
        translate([ rfa, 0, 0 ])                     // translate for fokus area
        difference()
    {
        union()
        {                          // adding square for focal area
            projection(cut = true) // reduce from 3D cone to 2D parabola
                translate([ 0, 0, f * 2 ]) rotate(
                    [ 45, 0, 0 ]) // rotate cone 45° and translate for cutting
                translate([ 0, 0, -hi / 2 ])
                    cylinder(h = hi,
                             r1 = hi,
                             r2 = 0,
                             center = true,
                             $fn = detail); // center cone on tip
            translate([ -(rfa + x), 0 ])
                square([ rfa + x, y ]); // focal area square
        }
        translate([ -(2 * rfa + x), -1 / 2 ])
            square([ rfa + x, y + 1 ]); // cut of half at rotation center
    }
}

/////////////////////////////////////////
// Paraboloid OpenSCAD Script end
//////////////////////////////////////
module
Mould_L()
{

    difference()
    {
        //  scale([.001,.001,.001]){
        union()
        {

            //////////////////////////////////////
            //////////Add things here ////////////
            //////////////////////////////////////
            translate([ 0, 3, 0 ])
                cube([ Mould_width, Mould_depth, Mould_height ]);
        }

        union()
        {
            //////////////////////////////////////
            ////////Subtract things here//////////
            //////////////////////////////////////
            {
                $fn = nof;
                rotate([90])
                {
                    translate([ 5.5, 5.5, -12.5 ]) cylinder(10, 3, 3);
                }
                rotate([90])
                {
                    translate([ 5.5, 45, -12.5 ]) cylinder(10, 3, 3);
                }

                rotate([ 90, 0, 90 ])
                {
                    translate([ 70, 10, 16 ]) cylinder(10, 3, 3);
                }
                rotate([ 90, 0, 90 ])
                {
                    translate([ 70, 40, 16 ]) cylinder(10, 3, 3);
                }
                rotate([ 90, 0, 90 ])
                {
                    translate([ 79, 25, -1 ])
                        ///////injection hole
                        cylinder(25, 5, 1);
                }
            }
        }
    }
}

module
Mould_R()
{

    difference()
    {
        //  scale([.001,.001,.001]){
        union()
        {

            //////////////////////////////////////
            /*+ + + Subtract things here + + + +*/
            //////////////////////////////////////
            $fn = nof;
            translate([ Right_shift, 3, 0 ])
                cube([ Mould_width, Mould_depth, Mould_height ]);
            rotate([ 90, 0, 90 ])
            {
                translate([ 70, 10, 33 ]) cylinder(10, 3, 3);
            }

            rotate([ 90, 0, 90 ])
            {
                translate([ 70, 40, 33 ]) cylinder(10, 3, 3);
            }
        }

        union()
        {
            //////////////////////////////////////
            /*- - - Subtract things here - - - -*/
            //////////////////////////////////////
            {
                $fn = nof;
                rotate([90])
                {
                    translate([ 20 + Right_shift, 5.5, -12.5 ])
                        cylinder(10, 3, 3);
                }
                rotate([90])
                {
                    translate([ 20 + Right_shift, 45, -12.5 ])
                        cylinder(10, 3, 3);
                }
            }
        }
    }
}

module
Stem_Mod()
{
    $fn = nof;

    rotate([90])
    {
        translate([ 24, 25, -59 ]) rotate_extrude() translate([ 2.2, 0, 0 ])
        {
            circle(d = 2.5);
        }
    }

    rotate([90])
    {
        translate([ 24, 25, -65 ]) rotate_extrude() translate([ 2.2, 0, 0 ])
        {
            circle(d = 2.5);
        }
    }

    rotate([90])
    {
        translate([ 24, 25, -71 ]) rotate_extrude() translate([ 2.2, 0, 0 ])
        {
            circle(d = 2.5);
        }
    }
}

module
Lip()
{
    $fn = nof;
    //base attachment lip
    
    //donut
    scale([ 1.7, 1.7, 1.7 ])
    {
        rotate([90])
        {
            translate([ 14.5, 14.5, -2 ]) rotate_extrude()
                translate([ 11.5, 0, 0 ])
            {
                circle(d = 2.5);
            }
        }
    }
}

module
Lip_base()
{
    $fn = nof;
    difference(){
    //base attachment lip
    rotate([90,0,0]){
        translate([25,23.2,-12.5]){
   cylinder(5, 22.8,22.8);
    }
}
    
}
}
//////////////////////////////////////////////
module
Stem()
{
    $fn = nof;
    translate([ 25, 80, 25 ]) rotate([90])
    {
       cylinder(38, 2, 2);
    }
}
//////////////////////////////////////////////
