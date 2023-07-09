Turtle t;
int maxd = 0;
int inframe=0;
int divisions = 15;

void setup() {
  size(1080, 1080);
  background(255);
  t = new Turtle(new PVector(width/2+50, height-25));
  t.speed = 1000;
  t.setPenColor(color(0, 0, 100));
  t.turn(radians(-90));
  tree(height/3.4, 25);
  tree(height/3.4, 0);
  tree(height/3.4, -21);
  println(t.commands);
}

void tree(float len, float turn) {
  if (len < 10) return;
  println(len + " " + turn);
  t.setPenColor(len > 20 ? #62411E : color(0, 200, 0, 50));

  t.setStrokeWidth((int)map(len, 0, height/3, 1, 8));
  t.forward((int)len);
  t.turn(radians(turn));
  tree(len/1.5, 25);
  tree(len/1.5, 0);
  tree(len/1.5, -21);

  t.setPenColor(len > 20 ? #62411E : color(0, 200, 0, 50));

  t.turn(-radians(turn));
  t.forward(-(int)len);
}

void draw() {
  inframe++;

    drawBg();
    t.display();
  
  saveFrame("frames/out-####.png");
}

void drawBg() {
  background(255);
  stroke(0, 200, 255, 20);
  strokeWeight(85);
  for (int i=0; i < width+100; i += 50) {
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
