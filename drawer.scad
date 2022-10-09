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
        cube([width,thickness,height]);
        translate([width/2,0,height+4/5*r]){
          rotate([90,0,0]){  
            cylinder(h=3*thickness,r=r,center=true,$fn=64);
          }
        }  
      }
      translate([0,thickness,0]){
        cube([thickness,depth-thickness,height]);  
      }  
      translate([width-thickness,thickness,0]){
        cube([thickness,depth-thickness,height]);  
      } 
      translate([thickness,depth-thickness,0]){
        cube([width-2*thickness,thickness,height-thickness]);
      }
      translate([1/3*thickness,1/3*thickness,loft_diff]){
        cube([width-4/3*thickness,depth,loft_thickness]);
      }
    }
}