
double fx, fy, cx, cy, w, h, xa, xb, ya, yb, r, theta, scalefactor;
boolean record = true;
PGraphics img;
int DIM;
int frames = 3600;
float steps = 10;

void setup() {
  size(1080, 1080);
  theta = PI;
  fx = -0.6581437656752878;
  fy = -0.41193127715849426;
  scalefactor = .992;

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
  steps=min(steps+.5, 2500);
}

void draw() {
  img = createGraphics(2160, 2160);
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
        //col=color(0, 0, map((float)(Math.abs(c.b*c.a)), 0,1, 50, 255));
        col = color(0);
      } else {
        col=color(0, 0, map((float)(z.a*z.b), 0, steps, 80, 225));
        //col = color(255);
      }
      int row = (int) (img.width/2.0 + img.width/w*(r-cx));
      int column = (int) (img.width/2.0 +img.height/h*(i-cy));

      try {
        img.pixels[column*img.width + row] = col;
      }
      catch(Exception e) {
        println(row, column);
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
  //println(w);
}

void mousePressed() {

  println("fx = "+(xa+(xb-xa)*mouseX/width) + "; fy = " +(ya+(yb-ya)*mouseY/height) + ";");
}
