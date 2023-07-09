import java.util.*;

ArrayList<TruchetTile> tiles;
PShader frag;
int cols = 15;
int rows = 15;
PGraphics img;

void setup() {
  size(540, 540, P2D);
  img = createGraphics(1080, 1080, P2D);
  tiles = new ArrayList<>();
  for (int i = 0; i < cols*rows; i++) {
    tiles.add(new TruchetTile(i/cols * (img.width/cols) + .5*((float)img.width/cols),
      i%rows * (img.height/rows)  + .5*((float)img.height/rows),
      (img.width/cols), (img.height/rows)));
  }
  frag = loadShader("frag.glsl");
  frag.set("width", (float) img.width);
  frag.set("height", (float) img.height);
  
}

void draw() {
  img.beginDraw();
    img.background(255);

  frag.set("time", (float) frameCount);
  img.shader(frag);
  for (TruchetTile tile : tiles) {
    tile.display();
  }
  if(frameCount < 30*60) img.save(String.format("frames/%06d.png", frameCount));
    img.endDraw();

  image(img, 0, 0, width, height);
}
