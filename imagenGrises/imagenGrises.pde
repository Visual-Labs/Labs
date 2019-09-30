PImage img;  // Declare a variable of type PImage
int imgW = 320;
int imgH = 240;
int imgA = imgW * imgH;

void setup(){
  PImage myImage = loadImage("pie.jpg");
  size(990, 240);
  image(myImage, 0, 0);
  //convolutionMatrix[1][1] = 1;
  //PGraphics pg = applyConvolutionalMatrix(myImage,convolutionMatrix);
  PGraphics pg = rgbAverage(myImage);
  image(pg, imgW+10, 0);
  PGraphics pgLuma = lumaGray(myImage);
  image(pgLuma, (imgW*2)+20, 0);
}

PGraphics rgbAverage(PImage myImage){//,int[][] matrix){
  PGraphics pGray = createGraphics(imgW,imgH);
  pGray.beginDraw();
  //myImage.loadPixels();
  pGray.loadPixels();
  //println("something");
  //gray
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
  //image(myImage, 0, 0);
  pLuma.beginDraw();
  //myImage.loadPixels();
  pLuma.loadPixels();
  //println("something");
  //gray
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




/*

void setup() {
  size(320,240);
  // Make a new instance of a PImage by loading an image file
  img = loadImage("pie.jpg");
}

/*void draw() {
  //background(0);
  // Draw the image to the screen at coordinate (0,0)
  image(img,0,0);
  loadPixels();  
// Loop through every pixel column
for (int x = 0; x < width; x++) {
  // Loop through every pixel row
  for (int y = 0; y < height; y++) {
    // Use the formula to find the 1D location
    int loc = x + y * width;
    int totalProm = 0;
    
    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    totalProm = int((0.30*r + 0.59*g + 0.11*b));
    totalProm = constrain(totalProm,0,255);
    pixels[loc]=color(totalProm);
    //loop neighboor
    /*for (int xn = -1; xn < 3; xn++){
      for(int yn = -1; yn < 3; yn++){
        if((x+xn >= 0) && (y+yn >=0)&&(x+xn <= width*height)&&(y+yn <= width*height)){
          int locN = (x+xn) + (y+yn) * width;
          totalProm += totalProm+1;  
        } 
      }
      
    }*/
    
    //ejemplo
    /*if (x % 2 == 0) { // If we are an even column
      pixels[loc] = color(0);
    } else {          // If we are an odd column
     // pixels[loc] = color(0);
    }*/
/*  }
}
updatePixels(); 
  
}*/
