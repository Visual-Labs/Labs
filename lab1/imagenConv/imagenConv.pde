PImage img;  // Declare a variable of type PImage
int imgW = 320;
int imgH = 240;
int imgA = imgW * imgH;
//----sharpen************
float[][] matrixS = new float[][]{{0,-1,0},{-1,5,-1},{0,-1,0}};
//------border1***********
float[][] matrixB1 = new float[][]{{1,0,-1},{0,0,0},{-1,0,1}};
  //-----border2******
float[][] matrixB2 = new float[][]{{-1,-1,-1},{-1,8,-1},{-1,-1,-1}};
  //----desenfoque gaussiano******
float[][] matrixG = new float[][]{{1/256f,4/256f,6/256f,4/256f,1/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {6/256f,24/256f,36/256f,24/256f,6/256f},
                                             {4/256f,16/256f,24/256f,16/256f,4/256f},
                                             {1/256f,4/256f,6/256f,4/256f,1/256f}};

void setup(){
  PImage myImage = loadImage("pie.jpg");
  size(990, 240);
  image(myImage, 0, 0);
  //convolutionMatrix[1][1] = 1;
  //PGraphics pg = applyConvolutionalMatrix(myImage,convolutionMatrix);
  PGraphics pg = convoMatrix(myImage,matrixS);
  image(pg, imgW+10, 0);
  PGraphics pgLuma = convoMatrix(myImage,matrixG);
  image(pgLuma, (imgW*2)+20, 0);
}


PGraphics convoMatrix(PImage myImage,float[][] matrix){
  PGraphics pg = createGraphics(myImage.width,myImage.height);
  pg.beginDraw();
  myImage.loadPixels();
  pg.loadPixels();
  //Hallar centro de la matriz de convolución
  int matrixCoreX = int(matrix[0].length/2);
  int matrixCoreY = int(matrix.length/2);
  //Recorrer pixeles
  for(int i=0;i<myImage.width*myImage.height;i++){
    //Inicializar valores r,g,b
    int r = 0;
    int g = 0;
    int b = 0;
    //Recorrer matriz
    for(int j=0;j<matrix[0].length;j++){
      int x = i%myImage.width+(j-matrixCoreX);
      for(int j2=0;j2<matrix.length;j2++){
        int y = int(i/myImage.width)+(j2-matrixCoreY); 
        //Comprobar que el pixel esté en el arreglo
        if(x>=0 && y>=0 && x<myImage.width && y<myImage.height){
          //Sumar valores de r,g,b
          r += red(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
          g += green(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
          b += blue(myImage.pixels[y*myImage.width+x])*matrix[j2][j];
        }
      }
    }
    //Asignar color a nueva imágen
    pg.pixels[i] = color(r,g,b);
  }
  pg.updatePixels();
  pg.endDraw();
  return pg;
}
