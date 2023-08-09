import java.util.*;

LSystem lsys;
int fc=0;

void setup() {
  size(1080, 1080);
  lsys = new LSystem();
}

void draw() {
  background(255);

  lsys.display(fc);
  fc+=4;
  //saveFrame("frames/######.png");
 
}

void mousePressed() {
  lsys.increment();
  lsys.increment();
  fc=0;
}
