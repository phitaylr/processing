
double fx, fy, cx, cy, w, h, xa, xb, ya, yb, r, theta, scalefactor;
boolean record = true;
PGraphics img;
int DIM;
int frames = 1800;
float steps = 10;

void setup() {
  size(1080, 1080);
  theta = PI;
fx = -0.764252792750076; fy = 0.1347536940355154;

  scalefactor = .995;

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
  steps=min(steps+.5, 200);
}

void draw() {
  img = createGraphics(2160, 2160);
  DIM = (int)(img.width*1.1);
  img.beginDraw();
  img.loadPixels();
  img.background(0);
  img.stroke(255);
  //Complex c = new Complex(map(mouseX, 0, width, -2, 2), map(mouseY, 0, width, -2, 2));

Complex c = new Complex(-.8+.05*cos(frameCount/100.),.156+.05*sin(frameCount/100.));
  for (double r=xa; r < xb; r+=w/DIM) {
    for (double i=ya; i < yb; i+=h/DIM) {
      Complex z = new Complex(r, i);

      Complex last = new Complex(c.a, c.b);
      int its = 0;
      for (int time = 0; time < steps && z.magnitude() < 50; time++) {
        if (time%3==0) last = new Complex(z.a, z.b);
        z = z.multiply(z).add(c);
        its++;
      }
      int col;
      if (its >= (int) steps) {

        col = color(0, 0, map((float)Math.abs(z.a*c.a), 0, .01, 50, 255));
        col = color(255);
      } else {
        col=color(0, 0, map((float)(z.b*z.b), 0, 100000, 50, 255));
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
  if (frameCount == 1615) println(w);
}

void mousePressed() {

  println("fx = "+(xa+(xb-xa)*mouseX/width) + "; fy = " +(ya+(yb-ya)*mouseY/height) + ";");
}
