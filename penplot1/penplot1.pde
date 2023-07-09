int maxd = 7;
int inframe=0;

void setup() {
  //size(1080, 1350);
  size(540, 675);
}


void draw() {
  drawBG();
  inframe++;
  for (int i=0; i <width; i+=6) {
    drawLine(i, height, 1.55*PI, width/2.28, 0);
   
    noFill();
  }

  //saveFrame("frames/out-####.png");
}

void drawLine(float x, float y, float a, float l, int depth) {
  if (depth == maxd) return;
  pushMatrix();
  translate(x, y);
  rotate(a);
  bezier(0, 0,l/4, l/4, .75*l, l/4, l, 0);
  
  drawLine(l, 0, pow(-1, depth)*PI/4, .75*l, depth+1);

  popMatrix();
}

void drawBG() {
  background(255);
}

void keyPressed() {
  if (keyCode==UP) {
  } else if (keyCode==DOWN) {
  } else if (key=='s') {
    save("out"+frameCount+".png");
  }
}
