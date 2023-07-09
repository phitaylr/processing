import java.util.*;


List<Tile> tiles;
int rows = 0;
int cols = 0;
PShader frag;
PGraphics img;


void setup() {
  size(540, 960, P2D);
  img = createGraphics(1080, 1920);

  generateTiles();
}

void generateTiles() {
  rows++;
  cols++;
  tiles = new ArrayList<>();
  float w = (float)img.width/rows;
  float h = (float)img.height/cols ;
  for (int i = 0; i < rows*cols; i++) {
    tiles.add(new Tile(i / rows * w, i % cols * h, w, h, 5));
  }
}

void draw() {


    img = createGraphics(1080, 1920);
    img.beginDraw();
    img.background(255);
    if(frameCount %5 == 0){
    generateTiles();
    }
    for (Tile t : tiles) {
      t.display();
    }
      img.endDraw();
      //image(img, 0, 0, width, height);
      if(frameCount < 30*30)
    img.save(String.format("frames/%06d.png", frameCount));

  println(frameCount/30);


}
