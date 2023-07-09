import java.util.*;

int[][] map = new int[50][50];
int BLANK = 0;
int WALL = 1;
int FLOODED = 2;
int START = 3;
int maxd = 0;
int sx=-1, sy=-1;

void setup() {
  size(1080, 1080);
  for(int i=0; i < 3; i++) makeWalls();
}

void draw() {
  resetMap(false);
  if (sx>=0 && sy>=0) flood(sx, sy, 0);
  drawMap();
  maxd++;
  frameRate(10);
  saveFrame("frames/#######.png");
}

void makeWalls(){
  int y = (int) random(map.length-map.length/2);
  int x = (int) random(map[0].length- map[0].length/2);
  int h = (int) random(y+1, map.length);
  int w = (int) random(x+1, map[0].length);
  for (int i = x; i < w; i++) {
    map[y][i] = WALL;
    map[h][i] = WALL;
  }
  for (int i = y; i < h; i++) {
    map[i][x] = WALL;
    map[i][w] = WALL;
  }
  map[h][w] = WALL;
}

void flood(int x, int y, int d) {
  LinkedList<int[]> queue = new LinkedList<>();
  queue.add(new int[] {x, y, d});
  while (!queue.isEmpty()) {
    int[] nextcell = queue.pop();
    x = nextcell[0];
    y = nextcell[1];
    d = nextcell[2];
    if (x < 0 || x >= map.length || y <0 || y >= map[0].length) continue;
    if (map[x][y] == WALL || map[x][y] >= 10) continue;
    if (map[x][y] != START) map[x][y] = 10+d;
    queue.add(new int[] {x+1, y, d+1});
    queue.add(new int[] {x-1, y, d+1});
    queue.add(new int[] {x, y+1, d+1});
    queue.add(new int[] {x, y-1, d+1});
  }
}

void floodR(int x, int y, int d) {
  if (x >= 0 && x < map.length && y >=0 && y < map[0].length && d != maxd) {
    if (map[x][y] != WALL && map[x][y] != FLOODED) {
      if (map[x][y] != START) map[x][y] = FLOODED;
      flood(x+1, y, d+1);
      flood(x-1, y, d+1);
      flood(x, y-1, d+1);
      flood(x, y+1, d+1);
    }
  }
}

void resetMap(boolean resetStart) {
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[0].length; y++) {
      if (map[x][y] >= 10) map[x][y] = BLANK;
      if (map[x][y] == START && resetStart) map[x][y] = BLANK;
    }
  }
}

void drawMap() {
  background(255);
  strokeWeight(width/map.length);
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[0].length; y++) {
      int cell = map[x][y];
      if (cell == WALL) stroke(0);
      if (cell == START) stroke(0, 0, 255);
      if (cell - 10 > maxd) stroke(255);
      else if (cell > 10) stroke(0,map(cell, 10, 10+maxd, 0, 255), 255);
      if (cell != BLANK) point(x*width/map.length + width/map.length/2, y * height/map[0].length+ width/map.length/2);
    }
  }
}

void keyPressed() {
  if (keyCode == UP) {
    maxd++;
  } else if (keyCode == DOWN) {
    maxd--;
  }
}

void mousePressed() {

  resetMap(true);
  maxd=0;
  sx = (int)((float)mouseX/width*map.length);
  sy = (int)((float)mouseY/height*map[0].length);
  map[sx][sy] = START;
}
