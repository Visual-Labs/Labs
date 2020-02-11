//global
float x;
float dir;

void setup(){
  size(800,300);
  x = 0;
  dir = 1;
}
void draw(){
  background(255);
  if (mousePressed) {
    strokeWeight(0);
  } else {
    strokeWeight(15);
  }
  //strokeWeight(15);
  for(int k = 0; k < 35; k++){
    line(k*30,0,k*30,height);
  }
  strokeWeight(0);
  //movement
  x = x + 1.1*dir;
  //reverse
  if (x > width-60) { 
    dir = -1; 
  }
  //forward
  if (x < 0) { 
    dir = 1; 
  }
  fill(0,0,128);
  rect(x,60,60,30);
  
  fill(255,255,0);
  rect(x,180,60,30);
  
}
