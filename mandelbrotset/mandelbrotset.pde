
double cx, cy, w, h, xa, xb, ya, yb;
boolean record = false;
PGraphics img;
int DIM;
int frames = 900;

void setup() {
  size(1080, 1080);
  cx = 0.26130767887687684;
  cy = 0.001977910610795032;

  w = 4;
  h =4;
  updateRanges();
}

void updateRanges() {
  xa = (cx-w/2);
  xb = (cx+w/2);
  ya = (cy-h/2);
  yb = (cy+h/2);
}

void draw() {
  img = createGraphics(1080, 1080);
  DIM = (int)(img.width*2);
  img.beginDraw();
  img.loadPixels();
  img.background(255);
  img.stroke(255);
  for (double r=xa; r < xb; r+=w/DIM) {
    for (double i=ya; i < yb; i+=h/DIM) {
      Complex z = new Complex(r, i);
      Complex c = new Complex(r, i);
      int its = 0;
      for (int time = 0; time < 100 && z.magnitude() < 50; time++) {
        z = z.multiply(z).add(c);
        its++;
      }
      int col;
      if (its == 100) {
        col=color(0, 0, map((float)Math.abs(z.magnitude() - c.magnitude()), 0, .25, 50, 255));
      } else {
        col=color(255-map(its, 0, 100, 100, 255));
      }
      int row = (int) (img.width/2.0 + img.width/w*(r-cx));
      int column = (int) (img.width/2.0 +img.height/h*(i-cy));
      
      try{
      img.pixels[column*img.width + row] = col;
      }catch(Exception e){
      println(row, column);  
      }
    }
  }
 
  w=-0.0000049321*frameCount*frameCount + 4;
  h=-0.0000049321*frameCount*frameCount + 4;

  updateRanges();
  img.updatePixels();
  img.endDraw();
  if (record && frameCount < frames) {
    img.save(String.format("frames/%06d.png", frameCount));
    println("Saved " +frameCount +"/" + frames);
  }
  image(img, 0, 0, width, height);
}

void mousePressed() {

  println("cx = "+(xa+(xb-xa)*mouseX/width) + "; cy = " +(ya+(yb-ya)*mouseY/height) + ";");
}
