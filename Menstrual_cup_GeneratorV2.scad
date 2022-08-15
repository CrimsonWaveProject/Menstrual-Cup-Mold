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
// Paraboloid OpenSCAD Script by Ablapo    //
// www.thingiverse.com/thing:84564/files  //
//
// design by Prospect3dlab                 //
// www.thingiverse.com/thing:3478622      //
///////////////////////////////////////////
/*             Parameter                  */
Top_part_width = 50;
Top_part_height = 8;
Top_part_depth = 50;
Mould_width = 25;
Mould_depth = 83;
Mould_height = 50;
Cup_width = .85; // [0.5:0.05:1.0]
Cup_depth = .8;
Cup_height = 2.9;
Right_shift = 40;
// level of detail
nof = 50; // [10, 100]

///////////////////////////////////////////
/*                Renders                */
///////////////////////////////////////////

translate([ 10, -15, 0 ])
{
    Top_part();
}

translate([ 13, -8.5, 0 ])
{
    scale([ 1, .8, .9 ]) Lip();
}
rotate([90])
{
    translate([ 35, 22.5, -30 ])
    {
#scale([ Cup_width / 1.18, Cup_depth, Cup_height ])
        Cup();
    }
}
difference()
{
    Mould_R();

    translate([ Right_shift / 2.5, 0, 0 ]) Stem();
    translate([ Right_shift / 1.9, 0, 0 ]) Lip();
    translate([ Right_shift / 2.5, 0, 0 ]) Stem_Mod();
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
    Lip();
    Stem_Mod();
    rotate([90])
    {
        translate([ 25, 25, -41 ])
        {
            scale([ Cup_width, Cup_depth, Cup_height ])
            {
                Cup();
            }
        }
    }
}

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
        translate([ 6, 45, -15.5 ]) cylinder(10, 3, 3);
        translate([ 45, 5.5, -15.5 ]) cylinder(10, 3, 3);
        translate([ 45, 45, -15.5 ]) cylinder(10, 3, 3);
    }
}

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
hi = (y + 2 * f) /
     sqrt(2); // height and rad of the cone-> alpha = 45°-> sin(45°)=1/sqrt(2)
x = 2 * f * sqrt(y / f); // x  = half size of parabola
module
Cup() hull()
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

        //////////////////////////////////////
        ////////Subtract things here//////////
        //////////////////////////////////////
        $fn = nof;
        rotate([90])
        {
            translate([ 5.5, 5.5, -12.5 ]) cylinder(10, 3, 3);
            translate([ 5.5, 45, -12.5 ]) cylinder(10, 3, 3);
        }
        rotate([ 90, 0, 90 ])
        {
            translate([ 70, 10, 16 ]) cylinder(10, 3, 3);
            translate([ 70, 40, 16 ]) cylinder(10, 3, 3);
            translate([ 79, 25, -1 ])
                ///////injection hole
                cylinder(25, 5, 1);
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
            /*+ + + Add things here + + + +*/
            //////////////////////////////////////
            $fn = nof;
            translate([ Right_shift, 3, 0 ])
                cube([ Mould_width, Mould_depth, Mould_height ]);
            rotate([ 90, 0, 90 ])
            {
                translate([ 70, 10, 33 ]) cylinder(10, 3, 3);
                translate([ 70, 40, 33 ]) cylinder(10, 3, 3);
            }
        }

        //////////////////////////////////////
        /*- - - Subtract things here - - - -*/
        //////////////////////////////////////
        $fn = nof;
        rotate([90])
        {
            translate([ 20 + Right_shift, 5.5, -12.5 ]) cylinder(10, 3, 3);
            translate([ 20 + Right_shift, 45, -12.5 ]) cylinder(10, 3, 3);
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
        translate([ 24, 25, -65 ]) rotate_extrude() translate([ 2.2, 0, 0 ])
        {
            circle(d = 2.5);
        }
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
    scale([ 1.5, 1.5, 1.7 ])
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
