Turtle t;
int maxd = 0;
int inframe=0;
int divisions = 15;
float[] turns = {PI/3, -2*PI/3, PI/3, 0};
color[] colors = {color(0, 100, 150), color(0, 75, 100),
  color(0, 125, 175), color(0, 50, 100),
  color(0, 100, 50)};

void setup() {
  size(1080, 1080);
  //size(600, 600);
  background(255);

  t = new Turtle(new PVector(width/10, height/10));
  t.speed = 100;
  t.hideTurtle();
  for (int j=1; j<5; j++) {
    t.setPenColor(colors[j]);
    t.setStrokeWidth(8-j);
    for (int i=0; i<1; i++) {
      drawSide(width-width/5, j);
      t.turn(PI/2);
    }
  }
  t.hideTurtle();
}

void drawSide(float len, int order) {
  if (order > 0) {
    for (float turn : turns) {
      drawSide(len/3, order-1);
      t.turn(turn);
    }
  } else {
    t.forward(len);
  }
}


void draw() {
  inframe++;

  drawBg();
  t.display();

  saveFrame("frames/out-####.png");
}

void drawBg() {
  background(255);
  noStroke();
  fill(0, 100, 200, 30);
  rect(0, 0, width, height);
  stroke(0, 200, 100, 20);
  strokeWeight(50);
  for (int i=-width; i < width*2; i += 70) {
    line(i, 0, i+150, height);
  }
}

void keyPressed() {

  if (key==' ') {
    background(255);
    //code to restart
  } else if (key == 'r') {
    background(255);
  } else if (key == 's') {
    save("output"+frameCount+".png");
  }
}
