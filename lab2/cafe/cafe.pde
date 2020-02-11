void setup(){
  size(1000, 608);
  strokeWeight(1);
  mousePressed();
}
void draw(){
  background(255);
  //fill(0);
  /*for(int i =0; i < 49; i++){
    square(i*75,0,75);
  }*/
  float posX = 0;
  //int posY = 0;
  fill(0);
  for(int i = 0;i<8; i++){
    if(i%2 != 0){
      posX = (0.25*mouseX);
    }
    else if(i == 2 || i == 6){
    posX = 0.5*mouseX;
    }
    else{posX = 0;}
    for(int j = 0; j < 70; j= j+2){
      square((j*75)+posX,i*76,75);
      square((-j*75)+posX,i*76,75);
    }
  }
  stroke(181);
  for(int k = 1; k < 9; k++){
    line(0,76*k,1000,76*k);
  }
}
