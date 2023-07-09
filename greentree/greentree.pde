color[] colors;
int maxd = 1;
int inframe=0;

void setup() {
  size(1080, 1350);
  //size(540, 675);
  colors = new color[1000];
  for (int i=0; i<1000; i++)
    colors[i] = color(0, 255, 255, 100);
}

void drawLine(float x, float y, float a, float l, int depth) {
  if (depth == maxd) return;
  pushMatrix();
  translate(x, y);
  rotate((depth+2)*PI/24);
  noFill();
  strokeWeight(12-depth);
  if(depth==maxd-1)
  stroke(255, min(inframe,map(depth, 0, maxd, 255, 100)));
  else stroke(255, map(depth, 0, maxd, 255, 100));

  bezier(0, 0, l/4, l/8, 3*l/4, l/8, l, 0);
  drawLine(l, 0, a, .7*l, depth+1);

  rotate(-(depth+3)*PI/12);
  strokeWeight(12-depth);
if(depth==maxd-1)
  stroke(255, min(inframe,map(depth, 0, maxd, 255, 100)));
  else stroke(255, map(depth, 0, maxd, 255, 100));
  bezier(0, 0, l/4, -l/8, 3*l/4, -l/8, l, 0);
  drawLine(l, 0, a, .65*l, depth+1);

  popMatrix();
}

void draw() {
  drawBG();
  inframe++;
  stroke(255, 255);
  strokeWeight(10);
  translate(width/2, .9*height);
  rotate(1.5*PI);
  line(0, 0, .2*height, 0);
  drawLine(.2*height, 0, 1.5*PI, .2*width, 0);
  if(inframe > 200){
    inframe=0;
    maxd++;
  }
  saveFrame("frames/out-####.png");
}

void drawBG() {
  background(0, 200, 0);
  strokeWeight(4);
  for (int i = -250; i < width+250; i+=15) {
    stroke(0, map(i, 0, width, 150, 255), 0);
    line(i+250, 0, i, height);
  }
}

void keyPressed() {
  if (keyCode==UP) {
  } else if (keyCode==DOWN) {
  } else if (key=='s') {
    save("out"+frameCount+".png");
  }
}
