color[] colors;
int maxd = 0;
int inframe=0;

void setup() {
  size(1080, 1350);
  colors = new color[1000];
  for (int i=0; i<1000; i++) colors[i] = color(0, 255, 255, 100);
}

void drawFractal(float x, float y, float l, float a, int depth) {
  if (depth==maxd) return;
  noStroke();
  pushMatrix();
  translate(x, y);
  rotate(a);
  if (depth==maxd-1) {

    fill(0, 255, 255, inframe);
  } else {
    fill(0, 255, 255, 125);
  }
  rect(0, 0, -l/3, -l/2);
  rect(0, 0, l/2, l/2.5);
  drawFractal(l/4, -l/4, l/2+depth*(l/9), a-PI/2.5, depth+1);
  drawFractal(-l/4, l/4, l/2+depth*(l/9), a-PI/3, depth+1);

  popMatrix();
}

void draw() {
  drawBG();
  inframe++;
  drawFractal(width/2, height/2+height/16, .8*width, 0, 0 );
  if (maxd > 6) {
    fill(0, 0, 100, inframe);
    rect(0, 0, width, height);
    return;
  }
  if (inframe > 40 && maxd==0) {
    inframe=0;
    maxd++;
  } else if (inframe >= 125) {
    inframe=0;
    maxd++;
  }
  saveFrame("frames/bluerecursion-####.png");
}

void drawBG() {
  background(0, 0, 200);
  strokeWeight(4);
  for (int i = -100; i < width+100; i+=15) {
    stroke(0, 0, map(i, 0, width, 100, 255));
    line(i+100, 0, i, height);
  }
}

void keyPressed() {
  if (keyCode==UP) {
    inframe=0;
    maxd+=1;
  } else if (keyCode==DOWN) {
    maxd-=1;
  }
}
