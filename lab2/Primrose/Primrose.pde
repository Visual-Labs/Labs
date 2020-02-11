// Primrose field
// https://blogs.brown.edu/sarahabdellahneuroscience/2016/08/24/primroses-field-optical-illusion/
size(408, 408);
noStroke();
int squarew = width/17;
int flowerw = 2;
float offset = 3;
boolean[] pattern = {true, false, false, true, false, true, true, false};

// squares
for (int i = 0; i<width/squarew; i++) {
  for (int j = 0; j<width/squarew; j++) {
    if ((i+j)%2 == 1) {
      fill(79, 187, 128);
    } else {
      fill(160, 215, 61);
    }
    rect(j*squarew, i*squarew, squarew, squarew);
  }
}

// flowers
for (int i = 1; i<width/squarew; i++) {
  for (int j = 1; j<width/squarew; j++) {
    if (pattern[(j-i)%8 < 0? (j-i)%8 + 8 : (j-i)%8]) {
      fill(255);
    } else {
      fill(204, 0, 153);
    }
    ellipse(j*squarew - offset, i*squarew, flowerw*1.5, flowerw);
    ellipse(j*squarew + offset, i*squarew, flowerw*1.5, flowerw);
    ellipse(j*squarew, i*squarew - offset, flowerw, flowerw*1.5);
    ellipse(j*squarew, i*squarew + offset, flowerw, flowerw*1.5);
  }
}
