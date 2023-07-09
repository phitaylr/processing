import java.util.*;
color c = color(random(0, 100), random(0,50), random(200,255));
int threshold = 100;

void setup() {
  size(1080, 1350);
  background(255);
  stroke(0);
  strokeWeight(3);
  noFill();
  for (int i = 0; i < 30; i++) {
    circle(random(width), random(height), random(width/2));
  }

  for (int i = 0; i < width; i ++) {
    for(int j =0;j<height; j++){
    c = nextColor();

    if(get(i, j) == color(255)) flood(i,j);
    }
  }
  save((int)random(9999999)+".png"); 
}

color nextColor(){
  return color( 0, random(200), random(100, 255)); 
}


void draw() {
}

void flood(int x, int y) {
  LinkedList<int[]> queue = new LinkedList();
  queue.add(new int[] {x, y});
  while (!queue.isEmpty()) {
    int[] nextpt = queue.pop();
    if (nextpt[0] > 0 && nextpt[0]<width && nextpt[1] > 0 && nextpt[1] < height) {
      color target = get(nextpt[0], nextpt[1]);
      if (target != c && target != color(0)) {
        set(nextpt[0], nextpt[1],
        color(c));
        queue.add(new int[]{nextpt[0]-1, nextpt[1]});
        queue.add(new int[]{nextpt[0]+1, nextpt[1]});
        queue.add(new int[]{nextpt[0], nextpt[1]-1});
        queue.add(new int[]{nextpt[0], nextpt[1]+1});
      }
    }
  }
}

void mousePressed() {
  c = color(random(2)*255, random(2)*255, random(2)*255);
  flood(mouseX, mouseY);
}

void keyPressed(){
  if(key==' ') save(frameCount+".png"); 
}
