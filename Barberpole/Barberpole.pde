// Barberpole illusion
int linew = 20;
int lineoffset = 10;
int space = linew+lineoffset;

void setup() {
  size(400, 400);
  strokeCap(PROJECT);
}

void draw() {
  background(255);

  // lines
  strokeWeight(linew/2);
  stroke(0);
  for (int i = 0; i<2*width/space; i++) {
    line(-width/2 + i*space+frameCount%space, 3*height/4, i*space+frameCount%space, height/4);
  }
  
  // hiding blocks
  if(!mousePressed){
    noStroke();
    rect(0, 0, width, height/4);
    rect(0, 3*height/4, width, height/4);
    rect(0, 0, 2*width/5, height);
    rect(3*width/5, 0, 2*width/5, height);
  }
}
