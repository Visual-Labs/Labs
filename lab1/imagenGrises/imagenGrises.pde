PImage img;  // Declare a variable of type PImage
int imgW = 320;
int imgH = 240;
int imgA = imgW * imgH;

void setup(){
  PImage myImage = loadImage("pie.jpg");
  size(990, 240);
  image(myImage, 0, 0);
  PGraphics pg = rgbAverage(myImage);
  image(pg, imgW+10, 0);
  PGraphics pgLuma = lumaGray(myImage);
  image(pgLuma, (imgW*2)+20, 0);
}

PGraphics rgbAverage(PImage myImage){
  PGraphics pGray = createGraphics(imgW,imgH);
  pGray.beginDraw();
  //myImage.loadPixels();
  pGray.loadPixels();
  
  //gray rgbAverage**********
for (int x = 0; x < myImage.pixels.length; x++) {    
    int totalProm = 0;
    float r = red(myImage.pixels[x]);
    float g = green(myImage.pixels[x]);
    float b = blue(myImage.pixels[x]);
    totalProm = int((0.30*r + 0.59*g + 0.11*b));
    totalProm = constrain(totalProm,0,255);
    pGray.pixels[x]=color(totalProm);
}
  
  pGray.updatePixels();
  pGray.endDraw();
  return pGray;
}
PGraphics lumaGray(PImage myImage){//,int[][] matrix){
  PGraphics pLuma = createGraphics(imgW,imgH);
  
  pLuma.beginDraw();
  //myImage.loadPixels();
  pLuma.loadPixels();
  
  //gray Luma**************
for (int i = 0; i < myImage.pixels.length; i++) {
    color c = myImage.pixels[i];
    pLuma.pixels[i] = luma(601, c);
  }
  pLuma.updatePixels();
  pLuma.endDraw();
  return pLuma;
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
