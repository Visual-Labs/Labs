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



//-----------Conv********************************************
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
  //----borders*******
  //float[][] matrix = new float[][]{{1,0,-1},{0,0,0},{-1,0,1}};
  //-----border2******
  //float[][] matrix = new float[][]{{-1,-1,-1},{-1,8,-1},{-1,-1,-1}};
  //----desenfoque gaussiano******
  float[][] matrix = new float[][]{{1/256f,4/256f,6/256f,4/256f,1/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {6/256f,24/256f,36/256f,24/256f,6/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {1/256f,4/256f,6/256f,4/256f,1/256f}};
  //Hallar centro de la matriz de convolución
  int matrixCoreX = int(matrix[0].length/2);
  int matrixCoreY = int(matrix.length/2);
  //Recorrer pixeles
  for(int i=0;i<myMovie.width*myMovie.height;i++){
    //Inicializar valores r,g,b
    int r = 0;
    int g = 0;
    int b = 0;
    //Recorrer matriz
    for(int j=0;j<matrix[0].length;j++){
      int x = i%myMovie.width+(j-matrixCoreX);
      for(int j2=0;j2<matrix.length;j2++){
        int y = int(i/myMovie.width)+(j2-matrixCoreY); 
        //Comprobar que el pixel esté en el arreglo
        if(x>=0 && y>=0 && x<myMovie.width && y<myMovie.height){
          //Sumar valores de r,g,b
          r += red(myMovie.pixels[y*myMovie.width+x])*matrix[j2][j];
          g += green(myMovie.pixels[y*myMovie.width+x])*matrix[j2][j];
          b += blue(myMovie.pixels[y*myMovie.width+x])*matrix[j2][j];
        }
      }
    }
    //Asignar color a nueva imágen
    pg.pixels[i] = color(r,g,b);
  }
  //pg.pixels= myMovie.pixels;
  pg.updatePixels();
  pg.fill(150,0,100);
  pg.text(frameRate,10,10);
  pg.endDraw();
  image(pg,390,0);
  text(myMovie.frameRate,10,10);
}
