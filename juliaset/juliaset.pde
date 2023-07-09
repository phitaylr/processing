float ca, cb;
int i = 0;
int maxits = 5;
float zoom = 0;

void setup() {
  size(1024, 1024);
  ca = .355;
  cb = .355;
  i = 0;
}

void draw() {
  ca = -.4+.01*pow(cos(frameCount/50.0), 1);
  cb = -.59+.01*pow(sin(frameCount/50.0), 1);
  loadPixels();
  background(0);
  for (int r = 0; r < height; r++) {
    for (int c = 0; c < width; c++) {
      float a = -1.5 + zoom/2 + (3.0 - zoom) / width * c;
      float b = -1.5 + zoom/2 + (3.0 - zoom) / height * r;
      float res = inJuliaSet(a, b);

      pixels[r*width+c] = res < 100 ? color(50, map(res, 0, 50, 0, 255), map(res, 0, 5, 120, 255)) : color(255);
    }
  }
  if (frameCount % 10 == 0) {
    maxits++;
  }
  zoom += .002;
  updatePixels();
  strokeWeight(20);
  stroke(0, 0, 255, 100);
  save(String.format("frames/%06d.png", frameCount));  i++;
  println(i);
}

float inJuliaSet(float a, float b) {
  Complex z0 = new Complex(ca, cb);
  Complex zN = new Complex(a, b);
  for (int i = 0; i < min(maxits, 100); i++) {
    zN = zN.squared().add(z0);
    if (zN.abs() > min(maxits, 100)) return 100;
  }
  return zN.abs();
}
