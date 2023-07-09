class TruchetTile{
 
  float x, y, w, h;
  int config;
  
  TruchetTile(float x, float y, float w, float h){
     this.x = x;
     this.y = y; 
     this.w = w;
     this.h = h;
     config = (int) random(4);
  }
  
  void display(){
    textureMode(NORMAL);
    stroke(0);
    if(random(1) < .001) config = (int)random(4);
    beginShape();
    shader(frag);
     if(config == 0){
       vertex(x-w/2, y - h/2);
       vertex(x+w/2, y - h/2);
       vertex(x+w/2, y + h/2);
     }
     else if(config == 1){
       vertex(x-w/2, y - h/2);
       vertex(x-w/2, y + h/2);
       vertex(x+w/2, y + h/2);
     }
     else if(config == 2){
       vertex(x-w/2, y - h/2);
       vertex(x-w/2, y + h/2);
       vertex(x+w/2, y - h/2);
     }else if(config == 3){
       vertex(x+w/2, y - h/2);
       vertex(x-w/2, y - h/2);
       vertex(x-w/2, y + h/2);
     }
    endShape();
  }
  
  
  
}
