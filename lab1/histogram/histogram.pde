PGraphics pghisto;
PImage img;
PImage select;

// Image attributes
int imgW = 1200;
int imgH = 1200;
int imgA = imgW * imgH;
// Histogram attributes
int histoW;
int histoH = 100;
float barW;
float barH = histoH;

// Histogram array
int[] histogram = new int[256];
int themax;

// Mouse control
int pressed;
int released;
float start;
float end;
boolean mouseFlag;

void setup() {
  size(600, 700);
  int histoW = width;
  barW = histoW/255.0;

  // BASE IMAGE
  img = loadImage("bw_manhattan.jpg");
  // EDITED IMAGE
  select = loadImage("bw_manhattan.jpg");

  // Fill Histogram
  for (int i = 0; i < img.pixels.length; i++) {
    int val = (int)  lumavalue(0, img.pixels[i]);
    histogram[val] = histogram[val] + 1;
  }

  // HISTOGRAM PGRAPHICS
  themax = max(histogram);
  pghisto = createGraphics(histoW, histoH);

  // DRAW INITIAL IMAGE
  image(select, 0, 0, 600, 600);
  drawHisto();
}

void draw() {}

float lumavalue(int y, color c) {
  float l; 
  if (y == 709) {
    l = (0.2126*red(c)+ 0.7152*green(c) + 0.0722*blue(c));
  } else if (y == 601) {
    l = (0.2989*red(c)+ 0.5870*green(c) + 0.1140*blue(c));
  } else {
    l = ((red(c) + green(c) + blue(c))/3);
  }
  return l;
}

void mousePressed() {
  if (mouseY > 600) {
    pressed = mouseX;
    mouseFlag = true;
    drawHisto();
  }
}

void mouseDragged() {
  if (mouseFlag) {
    released = mouseX;
    drawHisto();
  }
}


void mouseReleased() {
  if (mouseFlag) {
    released = mouseX;
    mouseFlag = false;
    
    start = map(min(pressed, released), 0, 600, 0, 255);
    end = map(max(pressed, released), 0, 600, 0, 255);
    
    for (int i = 0; i < img.pixels.length; i++) {
      float chck = lumavalue(0, img.pixels[i]);
      if (chck < start || chck > end) {
        select.pixels[i] = color(127);
      } else {
        select.pixels[i] = img.pixels[i];
      }
    }
    select.updatePixels();
    image(select, 0, 0, 600, 600);
    drawHisto();
  }
}

void drawHisto(){
  pghisto.beginDraw();
  pghisto.background(127);
  for (int i = 0; i<histogram.length; i++) {
    pghisto.rect(i*barW, 100, barW, -histogram[i]*barH/themax);
  }
  pghisto.stroke(255, 0, 0);
  pghisto.line(pressed, 0, pressed, 100);
  pghisto.line(released, 0, released, 100);
  pghisto.stroke(0);
  
  pghisto.endDraw();
  image(pghisto, 0, height-histoH);
}
