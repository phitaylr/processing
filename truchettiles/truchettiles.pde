import java.util.*;

ArrayList<TruchetTile> tiles;
PShader frag;
int cols = 10;
int rows = 10;

void setup() {
  size(800, 800, P2D);
  tiles = new ArrayList<>();
  for (int i = 0; i < cols*rows; i++) {
    tiles.add(new TruchetTile(i/cols * (width/cols) + .5*(width/cols),
      i%rows * (width/cols)  + .5*(height/rows),
      (width/cols), (height/rows)));
  }
  frag = loadShader("frag.glsl");
  frag.set("width", (float) width);
  frag.set("height", (float) height);
  
}

void draw() {
  background(255);
  frag.set("time", (float) frameCount);
  for (TruchetTile tile : tiles) {
    tile.display();
  }
  //if(frameCount % 30 == 0){
  //   save(String.format("frames/%06d.png", frameCount/30)); 
  //}
}
