class Point {
  float x, y;
  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }
  
  String toString(){ return "("+x+", "+y+")"; }
}


class LSystem {

  String first;
  String current;
  HashMap<Character, String> rules;
  ArrayList<Point> points;
  int level;
  float angle;
  float startx, starty;
  float dist;

  LSystem() {
    level = 0;
    first = "A";
    current = first;
    angle = PI/3;
    rules = new HashMap<>();
    rules.put('A', "B-A-B");
    rules.put('B', "A+B+A");
    rules.put('+', "+");
    rules.put('-', "-");
    startx = .1*width;
    starty = .85*height;
    dist = .8*width;
    increment();
    increment();
    calculatePoints();
  }

  void increment() {
    level++;
    String next = "";
    for (int i = 0; i < current.length(); i++) {
      next += rules.get(current.charAt(i));
    }
    current = next;
    dist *= .5;
     calculatePoints();
         println(points);

  }

  void calculatePoints() {
    points = new ArrayList<>();
    pushMatrix();
        points.add(new Point(screenX(startx, starty), screenY(startx, starty)));

    translate(startx, starty);
    for (int i =0; i < current.length(); i++) {
      char op = current.charAt(i);
      if (op == 'A' || op == 'B') {
        points.add(new Point(screenX(dist, 0), screenY(dist, 0)));
        translate(dist, 0);
      } else if (op == '+') {
        rotate(-angle);
      } else if (op == '-') {
        rotate(angle);
      }
    }

    popMatrix();
  }

  void display(int ub) {
    //angle = map(mouseX, 0, width, 0, 2*PI);
    calculatePoints();
    strokeWeight(45./(3*level+1));
    
    for(int i = 0; i < min(ub,points.size()-1); i++){
      float perc = map(i, 0, points.size(), 0, 255);
      stroke(0, 255-perc, perc);
      line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
    }
  }
}
