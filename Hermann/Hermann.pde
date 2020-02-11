// Hermann Grid illussion
size(400, 400);

int size = 400/10;
background(255);
fill(0);
for (int i = 0; i<height/size; i++) {
  for (int j = 0; j<width/size; j++) {
    rect(i*size+size*0.1, j*size+size*0.1, size*0.8, size*0.8);
  }
}
