// White's illusion
int lines = 20;
int lheight = 400/lines;

void setup() {
  size(400, 400);
  noStroke();
}

void draw() {
  background(0);
  // white lines
  fill(255);
  if (!mousePressed) {
    for (int i = 0; i<(lines/2); i++) {
      rect(0, 2*i*lheight, width, lheight);
    }
  }
  fill(127);
  for (int i = 0; i<(lines/2); i++) {
    rect(i%2 == 0? width/5: 3*width/5, height/4 + lheight*i, width/5, lheight);
  }
}
