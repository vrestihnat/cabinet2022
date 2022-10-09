/* [cabinet] parameters */

oheight = 2050;

owidth = 2050;

odept = 470;

plate_thickness = 19;

fitting_door = 5;

operation_door = 10;

back_thickness = 5;

show_doors = true;

coat_difference = 560;

right_shelf_count = 6;

left_shelf_count = 6;

plinth_height = 5 * plate_thickness;

saddle_plint_height =  5 * plate_thickness;

handrail_height = 870;

handrail_offset = 2*plate_thickness;

drawer_height_count = 2;
drawer_rows = 4;
drawer_handrail_r = 120;

hole_x=270;
hole_y=270;


upper_part_thickness = 2*plate_thickness;
left_site_thickness = 2*plate_thickness;

cabinet_dept=odept-plate_thickness-fitting_door;

cabinet_height=oheight-upper_part_thickness;

cabinet_width=owidth-left_site_thickness;

hole_dz=210;
hole_dx=140-left_site_thickness;

liner = 5*plate_thickness;

use <handrail.scad>;
use <drawer.scad>;

//stalls
difference(){
cube([plate_thickness,cabinet_dept,cabinet_height]);
saddlePlinth();
}
translate([(cabinet_width/2)-plate_thickness-liner/2,0,0]){
    difference(){
    cube([plate_thickness,cabinet_dept,cabinet_height]);
        saddlePlinth();
    }
}

translate([(cabinet_width/2)-liner/2,0,0]){
    difference(){
    cube([plate_thickness,cabinet_dept,cabinet_height]);
        saddlePlinth();
    }
}
translate([cabinet_width-plate_thickness,0,0]){
    difference(){
    cube([plate_thickness,cabinet_dept,cabinet_height]);
        saddlePlinth();
    }
}
//right liner
translate([cabinet_width-liner,-plate_thickness,0]){
cube([liner,plate_thickness,cabinet_height]);
}

module saddlePlinth(){
    translate([-0.1,cabinet_dept-plate_thickness+0.1,-0.1]){
    cube([2*plate_thickness,plate_thickness,    saddle_plint_height]);
    }
}

//lofts
translate([plate_thickness,0,plinth_height]){
    cube([(cabinet_width-4*plate_thickness)/2-liner/2,cabinet_dept,plate_thickness]);
}

translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-liner/2,0,plinth_height]){
    cube([(cabinet_width-4*plate_thickness)/2+liner/2,cabinet_dept,plate_thickness]);
}



translate([plate_thickness,0,cabinet_height-plate_thickness]){
    cube([(cabinet_width-4*plate_thickness)/2-liner/2,cabinet_dept,plate_thickness]);
}


translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-liner/2,0,cabinet_height-plate_thickness]){
    cube([(cabinet_width-4*plate_thickness)/2+liner/2,cabinet_dept,plate_thickness]);
}





//top
translate([0,cabinet_dept-odept,cabinet_height]){
    cube([cabinet_width,odept,upper_part_thickness]);
}

//left side 
translate([-left_site_thickness,cabinet_dept-odept,0]){
    cube([left_site_thickness,odept,oheight]);
}


//back
module back(delta){

   
   cube([(cabinet_width/2)-2/3*plate_thickness+delta,back_thickness,cabinet_height-plinth_height-1/3*plate_thickness]);
    
}


translate([1/3*plate_thickness,cabinet_dept-back_thickness,plinth_height]){
    difference(){
    back(-liner/2);
    translate([hole_dx,-plate_thickness,hole_dz]){
        cube([hole_x,2*plate_thickness,hole_y]);
    }
    }
}
translate([1/3*plate_thickness+(cabinet_width/2)-liner/2,cabinet_dept-back_thickness,plinth_height]){
    back(liner/2);
}

//plinth
module plinth(delta){
cube([(cabinet_width/2)-2*plate_thickness+delta,plate_thickness,plinth_height]);
}

translate([plate_thickness,0,0]){
    plinth(-liner/2);
}

translate([(cabinet_width/2)+plate_thickness-liner/2,0,0]){
    plinth(liner/2);
}

//doors
module door(){
   cube([((cabinet_width-liner)/4)-operation_door,plate_thickness,cabinet_height-plinth_height-operation_door]); 
}
module doors(){
translate([operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
    door();
}

translate([((cabinet_width-liner)/4)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
    door();
}

translate([((cabinet_width-liner)/2)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
    door();
}

translate([(3*(cabinet_width-liner)/4)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
    door();
}

//handrails
translate([((cabinet_width-liner)/4)-operation_door/2-handrail_offset-2*plate_thickness,-2*plate_thickness-fitting_door,handrail_height-10*plate_thickness]){
handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
}

translate([((cabinet_width-liner)/4)-operation_door/2+handrail_offset,-2*plate_thickness-fitting_door,handrail_height-10*plate_thickness]){
handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
}



translate([((cabinet_width-liner)*3/4)-operation_door/2-handrail_offset-2*plate_thickness,-2*plate_thickness-fitting_door,handrail_height-10*plate_thickness]){
handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
}

translate([((cabinet_width-liner)*3/4)-operation_door/2+handrail_offset,-2*plate_thickness-fitting_door,handrail_height-10*plate_thickness]){
handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
}
}

if (show_doors) {
    doors();
}


function shelfsDiff(cabinetHeight,plateThickness,shelfCount, plinthHeight) = (cabinetHeight-plinthHeight-((shelfCount+1)*plateThickness))/shelfCount;

//right shelfs
module rightShelfs(){ 
//echo(cabinet_height,plate_thickness,right_shelf_count,plinth_height);
sdiff =  shelfsDiff(cabinet_height,plate_thickness,right_shelf_count, plinth_height);
    echo(sdiff);

translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-liner/2,0,cabinet_height-2*plate_thickness-sdiff]){
    cube([(cabinet_width-4*plate_thickness)/2+liner/2,cabinet_dept,plate_thickness]);
}
//shelf stall
translate([3*plate_thickness+(cabinet_width-4*plate_thickness-liner)/2+coat_difference,0,plinth_height+plate_thickness]){
    cube([plate_thickness,cabinet_dept,cabinet_height-sdiff-3*plate_thickness-plinth_height]);
}
for (z =[2:right_shelf_count-1]){
    
    translate([3*plate_thickness+(cabinet_width-4*plate_thickness-liner)/2+coat_difference+plate_thickness,0,cabinet_height-(z+1)*plate_thickness-z*sdiff]){
    cube([(cabinet_width-4*plate_thickness+liner)/2-coat_difference-plate_thickness,cabinet_dept,plate_thickness]);
    }
    
}

}
rightShelfs();

function getDrawerHeight(drawer_height_count,plate_thickness,cabinet_height,left_shelf_count,plinth_height) = (drawer_height_count-1)*plate_thickness+drawer_height_count*shelfsDiff(cabinet_height,plate_thickness,left_shelf_count, plinth_height);

//left shelfs
module leftShelfs(){ 
sdiff =  shelfsDiff(cabinet_height,plate_thickness,left_shelf_count, plinth_height);

//shelf stall drawers
translate([plate_thickness+(cabinet_width-6*plate_thickness-liner)/4,0,plinth_height+plate_thickness]){
    cube([plate_thickness,cabinet_dept,(drawer_height_count-1)*plate_thickness+drawer_height_count*sdiff]);
}
for (z =[1:(left_shelf_count-drawer_height_count)]){
    
    translate([plate_thickness,0,cabinet_height-(z+1)*plate_thickness-z*sdiff]){
    cube([(cabinet_width-4*plate_thickness)/2-liner/2,cabinet_dept,plate_thickness]);
    }
    
}

}
leftShelfs();

function drawersDiff(height,drawer_rows) = height/drawer_rows;

ddiff =  drawersDiff(getDrawerHeight(drawer_height_count,plate_thickness,cabinet_height,left_shelf_count,plinth_height),drawer_rows);

for (z =[1:drawer_rows]){
translate([plate_thickness,0,plinth_height+plate_thickness+(z-1)*ddiff]){
drawer(cabinet_dept-back_thickness,ddiff,((cabinet_width-4*plate_thickness)/2-plate_thickness-liner/2)/2,plate_thickness,drawer_handrail_r);
}
translate([2*plate_thickness+((cabinet_width-4*plate_thickness)/2-plate_thickness)/2-liner/4,0,plinth_height+plate_thickness+(z-1)*ddiff]){
drawer(cabinet_dept-back_thickness,ddiff,((cabinet_width-4*plate_thickness)/2-plate_thickness-liner/2)/2,plate_thickness,drawer_handrail_r);
}

}
