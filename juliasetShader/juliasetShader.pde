
PShader shader;
PGraphics img;
float w = 4;
float cx = .0, cy = -.0;

void setup() {
  size(960, 540, P2D);
  img = createGraphics(960, 540, P2D);

  shader = loadShader( "frag.glsl");
  shader.set("u_resW", (float)img.width);
  shader.set("u_resH", (float)img.height);
  
}


void draw() {
  img.beginDraw();
  img.background(255);
  img.textureMode(NORMAL);
  img.shader(shader);
  //shader.set("u_time", (float)millis()/100.);
  shader.set("mouseX", (float) mouseX);
  shader.set("mouseY", (float) img.width-mouseY);
 shader.set("width", (float) w);
  shader.set("height", (float) (img.width/img.height) * w);

 shader.set("centerx", (float) 0);
 shader.set("centery", (float) 0);
  shader.set("maxIterations", (int) (frameCount/10.0));

  img.rect(0, 0, img.width, img.height);
  img.endDraw();
  
  image(img,0,0, width, height);
  w*=.999;
  //img.save(String.format("frames/%06d.png", frameCount));
}





void keyPressed() {
  if(key == 's') img.save(frameCount+".png");
}
