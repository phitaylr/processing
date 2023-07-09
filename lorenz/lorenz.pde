import java.util.*;

List<Path> paths;
int N = 20;
boolean record = true;


void setup() {
  size(800, 800, P3D);
  paths = new ArrayList();
  for (int i=0; i<N; i++) {
    paths.add(new Path(random(-1, 1), 0, random(-.2, .2)));
  }
}

void draw() {
  PGraphics img = createGraphics(1080, 1080, P3D);
  img.beginDraw();
  img.pushMatrix();
  img.translate(img.width/2, img.height/2);
  img.rotateY(sin(frameCount/100.) + cos(frameCount/200.));
  img.background(0, 0, 50);
  for (Path p : paths) {
    p.display(img);
    p.calcNextPoint();
  }
  img.popMatrix();
  if (record  && frameCount < 30*45) {
    img.save(String.format("frames/%06d.png", frameCount));
  }
  img.endDraw();
  image(img, 0, 0, width, height);
}
