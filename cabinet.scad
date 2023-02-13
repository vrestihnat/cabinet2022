

//full
//cabinet(show_doors = true);

//cabinet(show_cab1 = false, show_cab2 = true, show_veneer = false, show_doors = false, show_drawers = true);


//floor plans
//cab2

projection(cut=true){
    rotate([-90,0,0]){
    translate([0,-200,0]){
        cabinet(show_cab1 = true, show_cab2 = true, show_veneer = true, show_doors = true, show_drawers = true);
    }
    }
}


/*projection(cut=true){
    translate([0,0,-800]){
    cabinet();
    }
}*/




use <handrail.scad>;
use <drawer.scad>;


module cabinet(show_cab1 = true, show_cab2 = true, show_veneer = true, show_doors = true, show_drawers = true) {
/* [cabinet] parameters */

/*show_cab1 = true;
show_cab2 = false;
show_veneer = true;
show_doors = false;
show_drawers = true;*/
    
oheight = 2050;

owidth = 2050;

odept = 470;

plate_thickness = 19;

fitting_door = 5;

operation_door = 10;

back_thickness = 5;



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

veneer = 5*plate_thickness;





//stalls
if (show_cab1) {
    difference(){
        difference(){
        cube([plate_thickness,cabinet_dept,cabinet_height]);
        saddlePlinth();
        }
        backCab1();
    }
    difference(){
        translate([(cabinet_width/2)-plate_thickness-veneer/2-0.0006,0,0]){
            difference(){
            cube([plate_thickness,cabinet_dept,cabinet_height]);
                saddlePlinth();
            }
        }
        backCab1();
    }
}
if (show_cab2) {
    difference(){
        translate([(cabinet_width/2)-veneer/2,0,0]){
            difference(){
            cube([plate_thickness,cabinet_dept,cabinet_height]);
                saddlePlinth();
            }
        }
        backCab2();
    }
    difference(){
        translate([cabinet_width-plate_thickness,0,0]){
            difference(){
            cube([plate_thickness,cabinet_dept,cabinet_height]);
                saddlePlinth();
            }
        }
        backCab2();
    }

    //right veneer
    translate([cabinet_width-veneer,-plate_thickness-0.0001,0]){
    cube([veneer,plate_thickness,cabinet_height]);
    }
}
module saddlePlinth(){
    translate([-0.1,cabinet_dept-plate_thickness+0.1,-0.1]){
    cube([2*plate_thickness,plate_thickness,    saddle_plint_height]);
    }
}

//lofts
if (show_cab1) {
    difference(){
        translate([plate_thickness+0.003,0,plinth_height]){
            cube([(cabinet_width-4*plate_thickness)/2-veneer/2-0.006,cabinet_dept,plate_thickness]);
        }
        backCab1();
    }
    difference(){
        translate([plate_thickness+0.003,0,cabinet_height-plate_thickness]){
        cube([(cabinet_width-4*plate_thickness)/2-veneer/2-0.006,cabinet_dept,plate_thickness]);
        }
        backCab1();
    }
    
    
}
if (show_cab2) {
    difference(){    
        translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-veneer/2+0.003,0,plinth_height]){
            cube([(cabinet_width-4*plate_thickness)/2+veneer/2-0.006,cabinet_dept,plate_thickness]);
        }
        backCab2();
    }
    difference(){
        translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-veneer/2+0.003,0,cabinet_height-plate_thickness]){
        cube([(cabinet_width-4*plate_thickness)/2+veneer/2-0.006,cabinet_dept,plate_thickness]);
        }
        backCab2();
    }
    

}



if (show_veneer) {

    //top
    translate([0,cabinet_dept-odept,cabinet_height+0.005]){
        cube([cabinet_width,odept,upper_part_thickness]);
    }
    
    //left side 
    translate([-left_site_thickness-0.0006,cabinet_dept-odept,0]){
        cube([left_site_thickness,odept,oheight]);
    }
}

//back
module back(delta){

   
   cube([(cabinet_width/2)-2/3*plate_thickness+delta,back_thickness,cabinet_height-plinth_height-1/3*plate_thickness]);
    
}


module backCab1(preal=false,pscale=1){
    x = 1/3*plate_thickness;
    y = cabinet_dept-back_thickness;
    z = plinth_height;

    dx = (x-x*pscale)/2;
    dy = (y-y*pscale)/2;
    dz = (z-z*pscale)/2;
    if (preal){  
        translate([x+dx,y+dy,z+dz]){
            scale([pscale,pscale,pscale]){
                difference(){
                    back(-veneer/2);
                    translate([hole_dx,-plate_thickness,hole_dz]){
                        cube([hole_x,2*plate_thickness,hole_y]);
                    }
                }
            }
        }
    } else {
        translate([x+dx,y+dy,z+dz]){
            scale([pscale,pscale,pscale]){
                back(-veneer/2);
            }
        }
    }
}




module backCab2(preal=false,pscale=1){
    x = 1/3*plate_thickness+(cabinet_width/2)-veneer/2;
    y = cabinet_dept-back_thickness;
    z = plinth_height;

    dx = (x-x*pscale)/2;
    dy = (y-y*pscale)/2;
    dz = (z-z*pscale)/2; 
    translate([x+dx,y+dy,z+dz]){
        scale([pscale,pscale,pscale]){
            back(veneer/2);
        }
    }  
}

if (show_cab1) {
    backCab1(preal=true, pscale=0.99998);
}

if (show_cab2) {
   backCab2(preal=true, pscale=0.99998);
}

//plinth
module plinth(delta){
cube([(cabinet_width/2)-2*plate_thickness+delta,plate_thickness,plinth_height]);
}

if (show_cab1) {
    translate([plate_thickness,0,0]){
        plinth(-veneer/2);
    }
}
if (show_cab2) {
    translate([(cabinet_width/2)+plate_thickness-veneer/2,0,0]){
        plinth(veneer/2);
    }
}

//doors
module door(){
   cube([((cabinet_width-veneer)/4)-operation_door,plate_thickness,cabinet_height-plinth_height-operation_door]); 
}
module doors(){
if (show_cab1) {    
    translate([operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
        door();
    }
    
    translate([((cabinet_width-veneer)/4)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
        door();
    }
}
if (show_cab2) { 
    translate([((cabinet_width-veneer)/2)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
        door();
    }
    
    translate([(3*(cabinet_width-veneer)/4)+operation_door/2,-plate_thickness-fitting_door,plinth_height+operation_door/2]){
        door();
    }
}

//handrails
if (show_cab1) { 
    translate([((cabinet_width-veneer)/4)-operation_door/2-handrail_offset-2*plate_thickness,-2*plate_thickness-fitting_door-0.0006,handrail_height-10*plate_thickness]){
    handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
    }
    //((cabinet_width-veneer)/4)+operation_door/2
    translate([((cabinet_width-veneer)/4)+operation_door/2+handrail_offset,-2*plate_thickness-fitting_door-0.0006,handrail_height-10*plate_thickness]){
    handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
    }
}

if (show_cab2) {
    translate([((cabinet_width-veneer)*3/4)-operation_door/2-handrail_offset-2*plate_thickness,-2*plate_thickness-fitting_door-0.0006,handrail_height-10*plate_thickness]){
    handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
    }
    
    translate([((cabinet_width-veneer)*3/4)+operation_door/2+handrail_offset,-2*plate_thickness-fitting_door-0.0006,handrail_height-10*plate_thickness]){
    handrail(2*plate_thickness,10*plate_thickness,2*plate_thickness);
    }
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
    difference(){
        translate([3*plate_thickness+(cabinet_width-4*plate_thickness)/2-veneer/2+0.003,0,cabinet_height-2*plate_thickness-sdiff]){
            cube([(cabinet_width-4*plate_thickness)/2+veneer/2-0.006,cabinet_dept,plate_thickness]);
        }
        backCab2();
    }
    //shelf stall
    difference(){
        translate([3*plate_thickness+(cabinet_width-4*plate_thickness-veneer)/2+coat_difference,0,plinth_height+plate_thickness+0.003]){
            cube([plate_thickness,cabinet_dept,cabinet_height-sdiff-3*plate_thickness-plinth_height-0.006]);
        }
        backCab2();
    }
    for (z =[2:right_shelf_count-1]){
    difference(){    
            translate([3*plate_thickness+(cabinet_width-4*plate_thickness-veneer)/2+coat_difference+plate_thickness+0.003,0,cabinet_height-(z+1)*plate_thickness-z*sdiff]){
            cube([(cabinet_width-4*plate_thickness+veneer)/2-coat_difference-plate_thickness-0.006,cabinet_dept,plate_thickness]);
            }
            
        }
        backCab2();
    }

}
if (show_cab2) {
    rightShelfs();
}
function getDrawerHeight(drawer_height_count,plate_thickness,cabinet_height,left_shelf_count,plinth_height) = (drawer_height_count-1)*plate_thickness+drawer_height_count*shelfsDiff(cabinet_height,plate_thickness,left_shelf_count, plinth_height);

//left shelfs
module leftShelfs(){ 
    sdiff =  shelfsDiff(cabinet_height,plate_thickness,left_shelf_count, plinth_height);
    
    //shelf stall drawers
    difference(){
        translate([plate_thickness+(cabinet_width-6*plate_thickness-veneer)/4,0,plinth_height+plate_thickness+0.003]){
            cube([plate_thickness,cabinet_dept,(drawer_height_count-1)*plate_thickness+drawer_height_count*sdiff-0.006]);
        }
        backCab1();
    }
    
    for (z =[1:(left_shelf_count-drawer_height_count)]){
        difference(){
            translate([plate_thickness+0.003,0,cabinet_height-(z+1)*plate_thickness-z*sdiff]){
            cube([(cabinet_width-4*plate_thickness)/2-veneer/2-0.006,cabinet_dept,plate_thickness]);
            }
         backCab1();   
    }
        
    }

}

function drawersDiff(height,drawer_rows) = height/drawer_rows;

module drawers(){
    ddiff =  drawersDiff(getDrawerHeight(drawer_height_count,plate_thickness,cabinet_height,left_shelf_count,plinth_height),drawer_rows);
    
    for (z =[1:drawer_rows]){
        translate([plate_thickness,0,plinth_height+plate_thickness+(z-1)*ddiff]){
        drawer(cabinet_dept-back_thickness,ddiff,((cabinet_width-4*plate_thickness)/2-plate_thickness-veneer/2)/2,plate_thickness,drawer_handrail_r);
        }
        translate([2*plate_thickness+((cabinet_width-4*plate_thickness)/2-plate_thickness)/2-veneer/4,0,plinth_height+plate_thickness+(z-1)*ddiff]){
        drawer(cabinet_dept-back_thickness,ddiff,((cabinet_width-4*plate_thickness)/2-plate_thickness-veneer/2)/2,plate_thickness,drawer_handrail_r);
        }

    }

}

if (show_cab1) {
    leftShelfs();
    if (show_drawers){
        drawers();
    }
}



} //\cabinet



