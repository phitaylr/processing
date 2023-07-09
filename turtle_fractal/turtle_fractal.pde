Turtle t;
int maxd = 0;
int inframe=0;
int divisions = 15;
float[] turns = {PI/3, -2*PI/3, PI/3, 0};
color[] colors = {color(0, 100, 150, 50), color(0, 75, 100, 75),
  color(0, 125, 175, 100), color(0, 50, 100, 150),
  color(0, 100, 50, 255)};

void setup() {
  size(1080, 1080);
  //size(800, 800);
  background(255);

  t = new Turtle(new PVector(width/10, height/10));
  t.speed = 100;

  for (int j=1; j<5; j++) {
    t.setPenColor(colors[j]);
    t.setStrokeWidth(3);
    for (int i=0; i<4; i++) {
      drawSide(width-width/5, j);
      t.turn(PI/2);
    }
  }
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
  fill(0, 200, 100, 30);
  rect(0, 0, width, height);
  stroke(0, 200, 100, 20);
  strokeWeight(50);
  for (int i=0; i < width+100; i += 70) {
    line(i, 0, i, height);
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
