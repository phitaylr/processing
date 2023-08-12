import java.util.*;

// from https://micahtillman.com/lsystem/

LSystem lsys;
float fc=0;

void setup() {
  size(1080, 1080);
  lsys = new LSystem();
  
}
void drawbg() {
  background(0);
  for (int i = height; i >= -50; i-=15) {
    float r = map(i, height, 0, 0, red(color(#121D62)));
    float g = map(i, height, 0, 0, green(color(#121D62)));
    float b = map(i, height, 0, 0, blue(color(#121D62)));
    stroke(r, g, b);
    strokeWeight(12);
    line(0, i, width, i+50);
  }
}

void draw() {
  drawbg();
  lsys.display(Integer.MAX_VALUE);
  fc+=4;
  //if (lsys.level < 13 && fc -30 > lsys.lines.size()) {
  //  lsys.increment();
  //  fc=0;
  //  println(lsys.level);
  //}
  //saveFrame("frames/######.png");
}

void mousePressed() {
  save(String.format("%d.png", lsys.level));
  lsys.increment();
}
