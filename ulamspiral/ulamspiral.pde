size(600, 600);
int step = 1;
int rows = 100;
int cols = 100;
int x = width/2;
int y = height/2;
int cell_width = width/cols;
int cell_height = height/rows;
int direction = 0;
int seq = 0;
int stepsInSeq = 1;

background(255);

fill(0);
textSize(25);
textAlign(CENTER);
strokeWeight(10);
stroke(0,0,255);

for (int i=0; i < 100; i=i+1) {

  for (int j=step; j<step+stepsInSeq; j=j+1) {
    boolean isPrime = true;
    for(int k = 2; k < j; k++){
       if (j%k == 0){
         isPrime = false;
       }
    }
    if(isPrime && j!= 1){
      //text(j, x, y);
      stroke(random(50),random(255), random(255));
      point(x, y);
    }
    if (direction % 4 == 0) x = x + cell_width;
    if (direction % 4 == 1) y = y - cell_height;
    if (direction % 4 == 2) x = x - cell_width;
    if (direction % 4 == 3) y = y + cell_height;
  }

  if (seq %2 == 0) {
    stepsInSeq = stepsInSeq + 1;
  }
  
  direction++;
  step = step + stepsInSeq-1;
}
