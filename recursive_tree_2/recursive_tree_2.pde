int maxdepth = 11;

void setup() {
  size(800, 1000);
  reset();
}

void draw() {

}

void reset(){
  background(255);
  strokeWeight(1);
  for (int i = 0; i <height; i++) {
    stroke(map(i, height, 0, 50, 0), 50, map(i, height, 0, 200, 100), 200);
    line(0, i, width, i);
  }
}

void drawTree(float x, float y, float theta, int depth) {
  if (depth == maxdepth) return;
  if(depth > maxdepth-3 && random(1) > .3) return;
  pushMatrix();
  translate(x, y);
  rotate(theta);
  strokeWeight(map(depth, 0, maxdepth, maxdepth, 0)-1);
  float h = random(maxdepth-depth)*10;
  if (depth>8) {
    noStroke();
    if(random(1) > .6)
    fill(10, map(depth, 0, maxdepth, 0, 150), 1);
    else fill(10, map(depth, 0, maxdepth, 0, 255), 1);
    circle(0, 0, h);
  } else if (depth > 0) {
    stroke(35, 25, 50);
    line(0, 0, h, 0);
  }
  else if (depth==0) {
    h =height/4;
    strokeWeight(20);
    stroke(35, 25, 50);
    line(0, 0, h, 0);
  }
  int branches = (int)random(depth/3)+3;
  for (int i = 0; i < branches; i++)
    drawTree(h, 0, -3*PI/16 + (float)i*(PI/2)/branches, depth+1);
  popMatrix();
}

void mousePressed() {
  reset();
  strokeWeight(1);
  for (int i = 0; i <height; i++) {
    stroke(map(i, height, 0, 50, 0), 50, map(i, height, 0, 200, 100), 200);
    line(0, i, width, i);
  }

  drawTree(width/2, .9*height, 3*PI/2, 0);
}

void keyPressed() {
  if (key == ' ')
    save("bg"+frameCount+".png");
  else if (key == 'r') {
    reset();
  }
}
