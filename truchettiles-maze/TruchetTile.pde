enum Type{
  UP, DOWN 
}

class TruchetTile{
 
  float x, y, w, h;
  Type config;
  
  TruchetTile(float x, float y, float w, float h){
     this.x = x;
     this.y = y; 
     this.w = w;
     this.h = h;
     config = (int) random(2) < 1 ? Type.UP : Type.DOWN;
  }
  
  void display(){
    textureMode(NORMAL);
    strokeWeight(3);
    stroke(0);
     if(config == Type.DOWN){
       line(x, y, x+w, y+h);
     }
     else if(config == Type.UP){
       line(x, y+h, x+w, y);
     }
  
  }
  
  
  
}
