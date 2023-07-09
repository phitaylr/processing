 enum Orientation { UP, DOWN } 
  
  class Tile{
  
    Orientation orientation;
    float x, y, w,h;
    int strokeW;
  
   public Tile(float x, float y, float w,float h, int s){
     orientation = (int)(random(2)) == 0 ? Orientation.UP : Orientation.DOWN;
     this.x=x;
     this.y=y;
     this.w=w;
     this.h=h;
     strokeW = s;
   }
  
    public void display(){
      img.noStroke();
      img.stroke(0,0,map(rows, 0, 100, 100, 250));
      img.strokeWeight(strokeW);
     if(orientation == Orientation.DOWN){
        img.line(x, y, x+w, y+h);
      }else if (orientation == Orientation.UP){
         img.line(x, y+h, x+w, y);
      }
      
    }
  
}
