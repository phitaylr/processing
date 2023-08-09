import java.util.*;

LSystem lsys;
float fc=0;

void setup() {
  size(1080, 1080);
  lsys = new LSystem();
  background(0);
  for(int i = height; i >= 0; i-=15){
    float r = map(i, height, 0, 0, red(color(#4B3E34)));
     float g = map(i, height, 0, 0, green(color(#4B3E34)));
      float b = map(i, height, 0, 0, blue(color(#4B3E34)));
    stroke(r, g, b);
    strokeWeight(12);
    line(0,i,width, i-50);
   
  }
}

void draw() {

  lsys.display((int)fc);
  fc+=2.5*lsys.level;
  if(fc -30 > lsys.lines.size()){
    lsys.increment();
  fc=0;
  }
  if(frameCount < 30*60)saveFrame("frames/######.png");
  else println("done");
}

void mousePressed() {
  lsys.increment();
  fc=0;
}
