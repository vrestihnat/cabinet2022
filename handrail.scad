
//handrail

//thickness = 38;
//lenght = 190;
//width = 38;
//handrail(38,190,38);

module handrail(thickness,lenght,width){
diff = 0.2;
difference(){
difference(){
difference(){
union(){
cube([thickness,width*1/2,lenght]);
translate([thickness/2,0,0]){
cylinder(d=thickness,h=lenght, $fn=24);
}    
}
translate([-2/5*thickness,thickness/5,-diff]){
    cylinder(d=thickness,h=lenght+2*diff, $fn=24);
}
}
translate([+7/5*thickness,thickness/5,-diff]){
    cylinder(d=thickness,h=lenght+2*diff, $fn=24);
}
}

translate([0,-thickness/5,-pow(pow(thickness+diff,2)+pow(thickness+diff,2),1/2)/2]){
    rotate([45,0,0]){
cube([thickness+diff,thickness+diff,lenght]);
    }
}

}

}