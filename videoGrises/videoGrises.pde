import processing.video.*;
Movie myMovie;
PGraphics pg;

void setup() {
  size(770, 720);
  myMovie = new Movie(this, "colors.mp4");
  myMovie.play();
  pg = createGraphics(380,720);
  //myMovie.read();
  //grayScal(myMovie);
  //myMovie.play();
  //image(pg, 0,0);
  frameRate(60);
}

void movieEvent(Movie myMovie) {  
  myMovie.read();
  //this.pg = grayScal(myMovie);
}


//------------rgbAverage*******************************
/*void draw() {
  //myMovie.read();
  //loadPixels();
  myMovie.loadPixels();
  myMovie.updatePixels();
  myMovie.play();
  fill(0, 102, 153);
//  text(frameRate,10,10);
  image(myMovie, 0, 0);
  pg.beginDraw();
  for (int x = 0; x < myMovie.pixels.length; x++) {
    // Loop through every pixel row
    //for (int y = 0; y < myMovie.height; y++) {
      // Use the formula to find the 1D location
      int loc = (x);// + y * (myMovie.width);
      int totalProm = 0;
      
      float r = red(myMovie.pixels[loc]);
      float g = green(myMovie.pixels[loc]);
      float b = blue(myMovie.pixels[loc]);
      totalProm = int((0.30*r + 0.59*g + 0.11*b));
      totalProm = constrain(totalProm,0,255);
      pg.pixels[loc]=color(totalProm);
    //}
  }
  //pg.pixels= myMovie.pixels;
  pg.updatePixels();
  pg.fill(150,0,100);
  pg.text(frameRate,10,10);
  pg.endDraw();
  image(pg,390,0);
  text(myMovie.frameRate,10,10);
}*/
//-----------Luma********************************************
void draw() {
  //myMovie.read();
  //loadPixels();
  myMovie.loadPixels();
  myMovie.updatePixels();
  myMovie.play();
  fill(0, 102, 153);
//  text(frameRate,10,10);
  image(myMovie, 0, 0);
  pg.beginDraw();
  pg.loadPixels();
  for (int i = 0; i < myMovie.pixels.length; i++) {
    color c = myMovie.pixels[i];
    pg.pixels[i] = luma(601, c);
  }
  //pg.pixels= myMovie.pixels;
  pg.updatePixels();
  pg.fill(150,0,100);
  pg.text(frameRate,10,10);
  pg.endDraw();
  image(pg,390,0);
  text(myMovie.frameRate,10,10);
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
