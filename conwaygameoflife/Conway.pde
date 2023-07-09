
class Cell {

  int row, col;
  color c;
  boolean alive;

  Cell(int c, int r) {
    row=r;
    col=c;
    alive=false;
    this.c = color(0, 0, 255);
  }

  void display() {
    if (alive) {
      frame.fill(0,0,255);
      frame.noStroke();
                  frame.circle((col+.5)*colW+2, (row+.5)*rowH+2, sqrt(colW*rowH));

      frame.fill(c);
      frame.stroke(0);
      frame.circle((col+.5)*colW, (row+.5)*rowH, sqrt(colW*rowH));
      

    }
  }

  Cell copy(){
   Cell newc = new Cell(col, row);
   newc.alive = alive;
   newc.c = c;
   return newc;
  }


  String toString() {
    return "("+row+", " + col+")";
  }
  
}


class Conway {

  Cell[][] cells;
  boolean playing = false;
  int border = 10;
  int speed = 45;

  Conway() {
    cells = new Cell[rows + 2*border][cols + 2*border];
    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[0].length; c++) {
        cells[r][c] = new Cell(-border + r, -border + c);
      }
    }
  }

  void display() {
    for (Cell[] row : cells) {
      for (Cell c : row) {
        c.display();
      }
    }
    if(playing && frameCount % speed == 0){
      doRound();
    }
  }
  
  void randomize(){
        cells = new Cell[rows + 2*border][cols + 2*border];

    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[0].length; c++) {
        cells[r][c] = new Cell(-border + r, -border + c);
        if(random(3) < 1) cells[r][c].alive = true;
      }
    }
  }
  
  void doRound(){
    int[][] dirs = {{-1, -1}, {0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}};
    Cell[][] newcells = new Cell[cells.length][cells[0].length];
    for (int r = 0; r < cells.length; r++) {
      for (int c = 0; c < cells[0].length; c++) {
        newcells[r][c] = cells[r][c].copy();
        int neighbors=0;
        for(int[] d : dirs){
         try{
           neighbors += cells[r+d[0]][c+d[1]].alive ? 1 : 0;
         }catch(Exception e){} //out of array
        }
        if(cells[r][c].alive && (neighbors >= 2 && neighbors <=3)){
          newcells[r][c].alive = true;
        }else if (!cells[r][c].alive && neighbors == 3){
          newcells[r][c].alive = true;
        }else{
          newcells[r][c].alive = false;
        }
        if(newcells[r][c].alive){
          newcells[r][c].c = color(red( newcells[r][c].c), green( newcells[r][c].c)+5, blue( newcells[r][c].c));
        }
      }
    }
    speed = max(speed-1, 12);
    cells = newcells;
  }

  void toggle(int row, int col) {
    cells[border + row][border + col].alive = !cells[border + row][border + col].alive;
  }
}
