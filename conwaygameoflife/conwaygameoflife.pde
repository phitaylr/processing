import java.util.*;

Conway gol;
int rows = 40;
int cols = 40;
float rowH, colW;
PVector lastadd=new PVector(-1, -1);
PGraphics bg;
PGraphics frame;

void setup() {
  size(800, 800);
  gol = new Conway();
  frame = createGraphics(1080, 1080);

  colW = (float) frame.width/cols;
  rowH = (float) frame.height/rows;

  createBG();
}

void draw() {
  frame = createGraphics(1080, 1080);
  frame.beginDraw();
  frame.image(bg, 0, 0, frame.width, frame.height);

  gol.display();
  frame.endDraw();
  frame.save(String.format("frames/%06d.png", frameCount));
  image(frame, 0, 0, width, height);
}

void createBG() {
  bg = createGraphics(frame.width, frame.height);
  bg.beginDraw();
  bg.background(0, 0, 100);
  for (int x=-200; x < frame.width; x+=7) {
    bg.strokeWeight(5);
    bg.stroke(0, 0, 50);
    bg.line(x, 0, x+200, frame.width);
  }
  bg.endDraw();
}

void keyPressed() {
  if (key == 't') {
    gol.randomize();
  } else if (key == 'p') {
    gol.playing = !gol.playing;
  } else if (key == 'r') {
    gol=new Conway();
  }
}

void mouseDragged() {
  if (lastadd.x != (int)(mouseX/colW) || lastadd.y != (int)(mouseY/rowH)) {
    gol.toggle((int)(mouseX/colW), (int)(mouseY/rowH));
    lastadd = new PVector((int)(mouseX/colW), (int)(mouseY/rowH));
  }
}

void mousePressed() {
  gol.toggle((int)(mouseX/colW), (int)(mouseY/rowH));
}
