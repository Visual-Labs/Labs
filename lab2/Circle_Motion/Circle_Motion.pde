// Circle motion
int cw = 200;
int balls = 8;
int balld = 20;
int linel = (cw - balld)/2;
float speed = 0.02;

void setup() {
  size(400, 400);
}
void draw() {
  background(0);
  noStroke();

  // red circle
  fill(255, 0, 0);
  ellipse(width/2, height/2, cw, cw);
  
  // dots
  fill(255);
  for (int i = 0; i<balls; i++) {
      push();
      translate(width/2, height/2);
      rotate(i*PI/balls);
      ellipse(0, map(sin(frameCount*speed+i*PI/balls), -1, 1, -linel, linel), balld, balld);
      pop();
  }

  // show lines
  if (mousePressed) {
    stroke(0);
    for (int i = 0; i<balls; i++) {
      push();
      translate(width/2, height/2);
      rotate(i*PI/balls);
      line(0, -linel, 0, linel);
      pop();
    }
  }
}
