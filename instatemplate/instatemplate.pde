import processing.svg.*;

color[] colors;
int maxd = 0;
int inframe=0;
int divisions = 15;

void setup() {
  //size(1080, 1350);
  size(540, 675);
  colors = new color[1000];
  for (int i=0; i<1000; i++)
    colors[i] = color(0, 255, 255, 100);
    noLoop();
  beginRecord(SVG, "filename.svg");
}


void draw() {
  background(255);
  //drawBG();
  
  inframe++;
  stroke(0);
  strokeWeight(1.5);
  PVector p1 = new PVector(0, 0);
  PVector p2 = new PVector(width, 0);
  PVector p3 = new PVector(width, height);
    PVector p4 = new PVector(0, height);


  for(int i=0; i <=  divisions; i++){
    PVector src = PVector.lerp(p1, p2, (float)i/divisions);
    PVector dest = PVector.lerp(p2, p3, (float)i/divisions);
    line(src.x, src.y, dest.x, dest.y);
  }
  
  for(int i=0; i <= divisions; i++){
    PVector src = PVector.lerp(p1, p4, (float)i/divisions);
    PVector dest = PVector.lerp(p4, p2, (float)i/divisions);
    line(src.x, src.y, dest.x, dest.y);
  }
  
  for(int i=0; i <=  divisions; i++){
    PVector src = PVector.lerp(p2, p4, (float)i/divisions);
    PVector dest = PVector.lerp(p4, p3, (float)i/divisions);
    line(src.x, src.y, dest.x, dest.y);
  }
  
  endRecord();
  saveFrame("frames/out-####.png");
}

void drawBG() {
  background(200, 200, 0);
  strokeWeight(4);
  int offset = 400;
  for (int i = -offset; i < width+offset; i+=10) {
    stroke(0, map(i, 0, width, 150, 200), 0);
    line(i-offset, 0,i+offset, height);
  }
}

void keyPressed() {
  if (keyCode==UP) {
   
  } else if (keyCode==DOWN) {
    
  } else if(key=='s'){
     save("out"+frameCount+".png"); 
  }
}
