float PHI=1.618;
int max = 0, levelDir = 1, framesPerBox=100;
void setup() {
  size(1618, 1000);
}

void draw() {
  float colend = ((float) (frameCount%framesPerBox)/framesPerBox) ;
  if(max%4==0)
  background(255*colend, 255-255*colend,255*colend);
  if(max%4==1)
  background( 255-255*colend,255*colend,255-255*colend);
  if(max%4==2)
  background(255*colend, 255-255*colend,255*colend);
  if(max%4==3)
  background(255-255*colend,255*colend,255-255*colend);
  
  noFill();
  fib(0, 0, width/PHI, 0, 0);
  if (frameCount % framesPerBox==0) {
    max+=levelDir;
    if (max > 10 || max < 0) levelDir*=-1;
  }
}


void fib(float x, float y, float w, int dir, int lev) {
  if (lev>max) return;
  fill(255);
  //rect(x, y, w, w);
  dir%=4;
  strokeWeight(20);
  float end = .5*PI;
  float colend=1;
  if (lev == max) {
    end = ((float) (frameCount%framesPerBox)/framesPerBox) ;
    colend = ((float) (frameCount%framesPerBox)/framesPerBox) ;
    if (levelDir == 1) end = .5*PI*end;
    else end = .5*PI-.5*PI*end;
  }


  switch(dir) {
  case 0:
    fib(x+w, y, w/PHI, dir+1, lev+1);
    noFill();
    //fill(255*colend, 255*colend, 255-255*colend);
    arc(x+w, y+w, 2*w, 2*w, PI, PI+end);
    break;
  case 1:
    fib(x+w/PHI/PHI, y+w, w/PHI, dir+1, lev+1);
    //fill(255-255*colend, 255-255*colend, 255*colend);
    noFill();
    arc(x, y+w, 2*w, 2*w, 1.5*PI, 1.5*PI+end);
    break;
  case 2:
    fib(x-w/PHI, y+w/PHI/PHI, w/PHI, dir+1, lev+1);
    //fill(255-255*colend, 255*colend, 255*colend);
    noFill();
    arc(x, y, 2*w, 2*w, 0, end);
    break;
  case 3:
    fib(x, y-w/PHI, w/PHI, dir+1, lev+1);
    //fill(255*colend, 255-255*colend, 255*colend);
    noFill();
    arc(x+w, y, 2*w, 2*w, 0.5*PI, 0.5*PI+end);
    break;
  }
  noFill();
  //rect(x, y, w, w);
}
