class TruchetTile {

  float x, y, w, h, transp;
  int config;

  TruchetTile(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    config = (int) random(2);
    transp = 100;
  }

  void display() {
    img.strokeWeight(11);
    img.noFill();
    
    frag.set("transp", (float) transp);    
    if (config == 0) {
      img.arc(x+w/2, y-w/2, w, w, PI/2, 1*PI);
       img.arc(x-w/2, y+w/2, w, w, 1.5*PI, 2*PI);
    } else if (config == 1) {
      img.arc(x-w/2, y-w/2, w, w, 0, .5*PI);
      img.arc(x+w/2, y+w/2, w, w, 1*PI, 1.5*PI);
    } else if (config == 2) {
      img.arc(x-w/2, y+w/2, w, w, 1.5*PI, 2*PI);
      img.arc(x+w/2, y-w/2, w, w, PI/2, 1*PI);
    } else if (config == 3) {
      img.arc(x+w/2, y+w/2, w, w, 1*PI, 1.5*PI);
       img.arc(x-w/2, y-w/2, w, w, 0, .5*PI);
    }
    
  }
  
 
}
