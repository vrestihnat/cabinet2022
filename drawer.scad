//drawer

//drawer(450,200,460,19,120);

module drawer(i_depth,i_height,i_width,thickness,r){
      depth_dilat = 10;
      height_dilat = 20;
      width_dilat = 2*12;
      depth = i_depth-depth_dilat;
      height = i_height-height_dilat;
      width = i_width-width_dilat;
      loft_diff = 10;
    //loft
      loft_thickness = 5;  
    translate([width_dilat/2,depth_dilat/5,height_dilat/5]){
      difference(){
          difference(){
            cube([width,thickness,height]);
            translate([width/2,0,height+4/5*r]){
              rotate([90,0,0]){  
                cylinder(h=3*thickness,r=r,center=true,$fn=64);
              }
            }  
          }
          translate([2/3*thickness,2/3*thickness,loft_diff]){
            cube([width-4/3*thickness,depth,loft_thickness]);
          }
      }
      difference(){
          translate([0,thickness,0]){
            cube([thickness,depth-thickness,height]);  
          }  
          translate([2/3*thickness,2/3*thickness,loft_diff]){
            cube([width-4/3*thickness,depth,loft_thickness]);
          }
      }
      difference(){
          translate([width-thickness,thickness,0]){
            cube([thickness,depth-thickness,height]);  
          } 
          translate([2/3*thickness,2/3*thickness,loft_diff]){
            cube([width-4/3*thickness,depth,loft_thickness]);
          }
      }
  
      translate([thickness,depth-thickness,loft_diff+loft_thickness]){
         cube([width-2*thickness,thickness,height-thickness]);
      }
      translate([2/3*thickness+0.003,2/3*thickness+0.003,loft_diff+0.003]){
        cube([width-4/3*thickness-0.006,depth-2/3*thickness-0.006,loft_thickness-0.006]);
      }
    }
}