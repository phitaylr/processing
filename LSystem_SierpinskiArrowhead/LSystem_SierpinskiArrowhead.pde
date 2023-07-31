import java.util.*;

LSystem lsys;

void setup() {
  size(1080, 1080);
  lsys = new LSystem();
}

void draw() {
  background(255);

  lsys.display();
  if (lsys.level < 16) {
     saveFrame("frames/######.png");
    lsys.increment();
    lsys.increment();
  }
 
}

void mousePressed() {
  lsys.increment();
  lsys.increment();
}
