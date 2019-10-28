import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;
int bound = (int) pow(2, n-1); // Grid size helper variable

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 2.5. Options
boolean raster = true;
boolean shade = false;
float factor = 1; // Anti-aliasing factor, 1 equals no antialiasing; increase at your own risk
float fsq = factor*factor; // Anti-aliasing sample grid size

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 10;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
      public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);

  push();
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  pop();

  push();
  scene.applyTransformation(node);
  if (raster)
    triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
// node.location converts points from world to node
// here we convert v1 to illustrate the idea
void triangleRaster() {
  noStroke(); // Buggy if not called

  // TRIANGLE RASTER DEBUGGING
  if (debug) {
    push();
    noStroke();
    fill(255, 0, 0, 125);
    square(round(node.location(v1).x()), round(node.location(v1).y()), 1);
    fill(0, 255, 0, 102);
    // DEBUG ITERATOR
    for (int y = -bound; y < bound; y++) {
      for (int x = -bound; x < bound; x++) {
        for (int suby = 0; suby < factor; suby++) {
          for (int subx = 0; subx < factor; subx++) {
            circle(x+1/(factor*2)+subx/factor, y+1/(factor*2)+suby/factor, 1/factor);
          }
        }
      }
    }
    pop();
  }

  // World to node locations (clockwise)
  Vector nv1 = node.location(v1);
  Vector nv2 = node.location(v2);
  Vector nv3 = node.location(v3);

  // Iteration over pixel grid
  for (int y = -bound; y < bound; y++) {
    for (int x = -bound; x < bound; x++) {
      float[] cntrs = new float[4]; // Set sum variables for antialiasing

      // In each pixel generate sample grid (size: factor^2) factor = 1 -> No antialiasing
      for (int suby = 0; suby < factor; suby++) {
        for (int subx = 0; subx < factor; subx++) {

          // Get color from each sample
          float[] tempw = vertexWeights(nv1, nv2, nv3, new Vector(x+1/(factor*2)+subx/factor, y+1/(factor*2)+suby/factor));

          // Check if point is in triangle and record colors, outside -> no color
          if (tempw[0] >= 0 && tempw[1] >= 0 && tempw[2] >= 0) {
            for (int i = 0; i<3; i++)
              cntrs[i]+=tempw[i];
            cntrs[3]+=1;
          }
        }
      }
      // Draw pixel if color > 0
      if (cntrs[3]>0) {
        if (shade) fill(255*cntrs[0]/fsq, 255*cntrs[1]/fsq, 255*cntrs[2]/fsq);
        else fill(255*cntrs[3]/fsq);
        square(x+0.5, y+0.5, 1);
      }
    }
  }
  // END TRIANGLE RASTER
}

// Edge Function returns area of cross product of vectors (double the area of the triangle)
float edgeFunction(Vector a, Vector b, Vector c) {
  // Edge Function as described in scratchapixel
  // Vertices are described CLOCKWISE
  // A = c - a
  // B = b - a
  // return A x B
  return (c.x() - a.x()) * (b.y() - a.y()) - (c.y() - a.y()) * (b.x() - a.x());
}

// Vertex Weights returns the barycentric coordinates of the point
float[] vertexWeights(Vector a, Vector b, Vector c, Vector p) {
  // Vertex Weights as described in scratchapixel
  // Vertices are described CLOCKWISE
  float area = edgeFunction(a, b, c); // area of the triangle multiplied by 2 
  // barycentric coordinates are the areas of the sub-triangles divided by the area of the main triangle
  float wA = edgeFunction(b, c, p) / area; // signed area of the triangle bcp multiplied by 2 
  float wB = edgeFunction(c, a, p) / area; // signed area of the triangle cap multiplied by 2 
  float wC = edgeFunction(a, b, p) / area; // signed area of the triangle abp multiplied by 2 

  return new float[] {wA, wB, wC};
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  v1 = new Vector(random(low, high), random(low, high));
  v2 = new Vector(random(low, high), random(low, high));
  v3 = new Vector(random(low, high), random(low, high));
}

void drawTriangleHint() {
  push();

  if (shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }

  beginShape(TRIANGLES);
  if (shadeHint)
    fill(255, 0, 0);
  else
    stroke(255, 0, 0);
  vertex(v1.x(), v1.y());

  if (shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());

  if (shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'q')
    raster = !raster;
  if (key == 'w')
    shade = !shade;
  if (key == 'x') {
    factor = factor < 8 ? factor+1 : 1;
    fsq = factor*factor;
  }
  if (key == 'z') {
    factor = factor > 1 ? factor-1 : 8;
    fsq = factor*factor;
  }
  // DEFAULT KEY LISTENERS  
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
    bound = (int) pow(2, n-1);
  }
  if (key == '-') {
    n = n > 2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
    bound = (int) pow(2, n-1);
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
