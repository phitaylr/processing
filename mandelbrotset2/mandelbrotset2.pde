
double fx, fy, cx, cy, w, h, xa, xb, ya, yb, r, theta, scalefactor;
boolean record = false;
PGraphics img;
int DIM;
int frames = 3600;
float steps = 2;

void setup() {
  size(512, 512);
  theta = PI;
fx = -1.2836093661720935; fy = 0.06589396547671364;

  scalefactor = .99;

  cx = 0;
  cy = 0;
  w = 5;
  h =5 ;
  updateRanges();
}

void updateRanges() {

  //r = (1 - Math.cos(theta))/2; cx = r*Math.cos(theta)+0.25; cy = r*Math.sin(theta);
  //theta += .01;
  PVector move = new PVector((float)(fx-cx), (float)(fy-cy));
  float d = dist((float)fx, (float)fy, (float)cx, (float)cy)*(1-(float)scalefactor);
  move.normalize().mult(d);
  cx = move.x+cx;
  cy = move.y +cy;
  //cx = fx; cy = fy;
  w*=scalefactor;
  h*=scalefactor;
  xa = (cx-w/2);
  xb = (cx+w/2);
  ya = (cy-h/2);
  yb = (cy+h/2);
  steps=min(steps+.5, 25);
}

void draw() {
  img = createGraphics(512, 512);
  DIM = (int)(img.width*1.1);
  img.beginDraw();
  img.loadPixels();
  img.background(255);
  img.stroke(255);
  for (double r=xa; r < xb; r+=w/DIM) {
    for (double i=ya; i < yb; i+=h/DIM) {
      Complex z = new Complex(r, i);
      Complex c = new Complex(r, i);
      Complex last = new Complex(c.a, c.b);
      int its = 0;
      for (int time = 0; time < steps && z.magnitude() < 50; time++) {
        if (time%3==0) last = new Complex(z.a, z.b);
        z = z.multiply(z).add(c);
        its++;
      }
      int col;
      if (its >= (int) steps) {
        col=color(0, 0, map((float)(Math.abs(c.a*c.b)), 0,1, 50, 255));
        //col = color(255);
      } else {
        col=color(0, map((float)(z.a), 10, -10, 80, 225), map((float)(z.b), -10, 10, 80, 225));
        //col = color(255);
      }
      int row = (int) (img.width/2.0 + img.width/w*(r-cx));
      int column = (int) (img.width/2.0 +img.height/h*(i-cy));

      try {
        img.pixels[column*img.width + row] = col;
      }
      catch(Exception e) {
        //println(row, column);
      }
    }
  }



  updateRanges();
  img.updatePixels();
  img.endDraw();
  if (record && frameCount < frames) {
    img.save(String.format("frames/%06d.png", frameCount));
    println("Saved " +frameCount +"/" + frames);
  }
  image(img, 0, 0, width, height);
  if(frameCount == 1615) println(w);
}

void mousePressed() {

  println("fx = "+(xa+(xb-xa)*mouseX/width) + "; fy = " +(ya+(yb-ya)*mouseY/height) + ";");
}
