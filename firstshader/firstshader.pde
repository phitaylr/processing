float rotx = 0;
float roty = 0;
float zoom = 1;

PShader shader;

void setup()
{
  size(800, 800, P3D);
  rectMode(CENTER);
  shader = loadShader("frag.glsl");
  textureMode(NORMAL);
  shader.set("width", (float) width);
  shader.set("height", (float) height);
}

void draw()
{
  background(255);
  if (keyPressed) {
    if (keyCode == UP) {
      zoom *= 1.03;
    } else if (keyCode == DOWN) {
      zoom *= 0.97;
    }
  }
  translate(width/2.0, height/2.0);
  scale(zoom);
  rotateX(rotx);
  rotateY(roty);

  shader.set("u_time", (float) frameCount/100.);
  noStroke();
  fill(0);
  beginShape();
  shader(shader);
  vertex(0, 0, 0, 0, 0);
  vertex(0, 400, 0, 1, 0);
  vertex(0, 400, 400, 1, 1);
  vertex(0, 0, 400, 0, 1);

  endShape();

  draw3DCoordinateAxes();
}

void mouseDragged()
{
  float rate = 0.01;
  rotx = rotx + (pmouseY-mouseY) * rate;
  roty = roty + (mouseX-pmouseX) * rate;
}



void draw3DCoordinateAxes()
{

  text("X", 90, 0, 0);
  text("Y", 5, 90, 0);
  text("Z", 5, 0, 90);

  beginShape(LINES);
  stroke(255, 0, 0);
  vertex(-100, 0, 0);
  vertex(0, 0, 0);
  stroke(100, 0, 0);
  strokeWeight(3);
  vertex(0, 0, 0);
  vertex(100, 0, 0);
  strokeWeight(1);
  stroke(0, 100, 0);
  vertex(0, -100, 0);
  vertex(0, 0, 0);
  stroke(0, 255, 0);
  strokeWeight(3);
  vertex(0, 0, 0);
  vertex(0, 100, 0);
  strokeWeight(1);
  stroke(0, 0, 100);
  vertex(0, 0, -100);
  vertex(0, 0, 0);
  stroke(0, 0, 255);
  strokeWeight(3);
  vertex(0, 0, 0);
  vertex(0, 0, 100);
  strokeWeight(1);
  endShape();
}
