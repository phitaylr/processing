Turtle t;
int maxd = 0;
int inframe=0;
int divisions = 15;

void setup() {
  size(955, 500);
  background(255);

  t = new Turtle(new PVector(width/2, height-25));
  t.speed = 1000;
  t.setPenColor(color(0, 0, 100));
  //t.hideTurtle();

  t.turn(radians(-90));
  tree(height/3, 20);
  tree(height/3, -64);
  println(t.commands);
}

void drawBg(){
  background(255);
  stroke(0,100,255,10);
  strokeWeight(75);
   for(int i=0; i < width; i += 50){
     line(i,0,i,height);
   }
}

void tree(float len, float turn) {
  if (len < 5) return;
  println(len + " " + turn);
  t.setPenColor(len > 20 ? #62411E : color(0, 200, 0));

  t.setStrokeWidth((int)map(len, 0, height/3, 1, 8));
  t.forward((int)len);
  t.turn(radians(turn));
  tree(len/1.5, 70);
  tree(len/1.5, -20);

  t.setPenColor(len > 20 ? #62411E : color(0, 200, 0));

  t.turn(-radians(turn));
  t.forward(-(int)len);
}

void draw() {
  inframe++;

  if (key != 'r'){
    drawBg();
    t.display();
  }
  //saveFrame("frames/out-####.png");
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
