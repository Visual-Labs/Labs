// Image attributes
int imgW = 1200;
int imgH = 1200;
int imgA = imgW * imgH;

// Histogram array
int[] histogram = new int[256];

void setup() {
  size(1200, 1300);
  // Histogram attributes
  int histoW = width;
  int histoH = 100;
  float barW = histoW/255;
  float barH = histoH;

  // BASE IMAGE
  PImage img;
  img = loadImage("bw_manhattan.jpg");
  printArray(img.pixels[0]);

  // RGB AVERAGE PGRAPHICS
  PGraphics pgavg;
  pgavg = createGraphics(imgW, imgH);
  pgavg.beginDraw();
  pgavg.loadPixels();
  for (int i = 0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    float colorvalue = (red(c)+ green(c)+ blue(c))/3; 
    pgavg.pixels[i] = color(colorvalue);
    histogram[(int) colorvalue] = histogram[(int) colorvalue]+1;
  }
  pgavg.updatePixels();
  pgavg.endDraw();
  image(pgavg, width/3, 0);

  // LUMA GRAY PGRAPHICS
  PGraphics pgluma;
  pgluma = createGraphics(imgW, imgH);
  pgluma.beginDraw();
  pgluma.loadPixels();
  for (int i = 0; i<img.pixels.length; i++) {
    color c = img.pixels[i];
    pgluma.pixels[i] = luma(601, c);
  }
  pgluma.updatePixels();
  pgluma.endDraw();
  image(pgluma, width*2/3, 0);

  // HISTOGRAM PGRAPHICS
  int themax = max(histogram);
  PGraphics pghisto;
  pghisto = createGraphics(histoW, histoH);
  pghisto.beginDraw();
  pghisto.background(0);
  for (int i = 0; i<histogram.length; i++) {
    if (i == 255)
      pghisto.fill(255, 0, 0);
    pghisto.rect(i*barW, 100, barW, -histogram[i]*barH/themax);
  }
  pghisto.endDraw();
  image(pghisto, 0, height-histoH);
}



void draw() {
}

color luma(int y, color c) {
  color l = color(0); 
  if (y == 709) {
    l = color(0.2126*red(c)+ 0.7152*green(c) + 0.0722*blue(c));
  } else if (y == 601) {
    l = color(0.2989*red(c)+ 0.5870*green(c) + 0.1140*blue(c));
  }
  return l;
}
