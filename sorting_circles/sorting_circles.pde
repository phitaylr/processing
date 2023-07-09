import java.util.*;
ArrayList<float[]> circles;
color[] colors = new color[50];
float[] speed = new float[50];
int frame=0;

void setup() {
  size(1080, 1350);
  circles=new ArrayList<>();
  for (int i=0; i<50; i++) {
    circles.add(new float[]{random(width), random(height), random(sqrt(width*height))*1.9});
    colors[i] = color(0, random(255), random(255), random(100, 150));
    speed[i] = random(1.4, 2.1);
  }
  Collections.sort(circles, new Comparator<float[]>() {
    @Override
      public int compare(float[] o1, float[] o2) {
      return (int)(o2[2] - o1[2]);
    }
  }
  );
}

void draw() {
  background(255);
  noFill(); noStroke();
  for (int i=0; i<50; i++) {
    fill(colors[i]);
    float[] c = circles.get(i);
    circle(c[0], c[1], c[2]);
    PVector t = new PVector(width/2.5-c[0], height*.55-c[1]);
    t.normalize().mult(speed[i]);
    if (dist(c[0], c[1], width/2.5, .55*height) > 1.5) {
      c[0] += t.x;
      c[1] += t.y;
    }
  }
  saveFrame("frames/######.png");
}
