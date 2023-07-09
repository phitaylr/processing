
int DIM = 4000;

void setup() {
  size(800, 800);
  noLoop();
}

void draw() {
  background(0);
  stroke(255);
  translate(width/1.5, height/2);
  for (float r=-2; r < 2; r+=4.0/DIM) {
    for (float i=-2; i < 2; i+=4.0/DIM) {
      Complex z = new Complex(r, i);
      Complex c = new Complex(r, i);
      float oldval = 0, newval =0;
      for (int time = 0; time < 10; time++) {
        z = z.multiply(z).add(c);
        if(time == 3) oldval = z.magnitude();
        if(time == 9) newval = z.magnitude();
 
      }
      if (abs(newval-oldval) < 1000) {
        stroke(0,map(abs(newval-oldval), 0, 1, 255, 50),0);
        point((int)(width/4*r), (int)(height/4*i));
      }
    }
  }
}
