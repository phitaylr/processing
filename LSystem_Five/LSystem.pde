class Point {
  float x, y;
  Point(float x, float y) {
    this.x=x;
    this.y=y;
  }


  String toString() {
    return "("+x+", "+y+")";
  }
}

class Line {
  Point a, b;
  float weight;
  color c;
  Line(Point a, Point b, float w, color c) {
    this.a = a;
    this.b=b;
    this.weight=w;
    this.c = c;
  }
  float distance(){
     return dist(a.x, a.y, b.x, b.y); 
  }
  void display() {
    stroke(c);
    line(a.x, a.y, b.x, b.y);
  }
}


class LSystem {

  String first;
  String current;
  HashMap<Character, String> rules;
  ArrayList<Line> lines;
  int level;
  float angle;
  float startx, starty;
  float dist;

  LSystem() {
    level = 0;
    first = "X";
    current = first;
    angle = radians(60);
    rules = new HashMap<>();
    rules.put('X', "X-FYF-X");
    rules.put('Y', "Y+FXF+Y");
    rules.put('+', "+");
    rules.put('-', "-");
    rules.put('[', "[");
    rules.put(']', "]");
    startx = .5*width;
    starty = .5*height;
    dist = .4*width;
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
  }

  void calculatePoints() {
    lines = new ArrayList<>();
    pushMatrix();

    translate(startx, starty);
    for (int i =0; i < current.length(); i++) {
      char op = current.charAt(i);
      //angle = radians(25+.25*sin(frameCount/100.));
      if (op == 'F') {
        Point a = new Point(screenX(0,0), screenY(0,0));
        Point b = new Point(screenX(dist, 0), screenY(dist, 0));
        float c = map(frameCount, 0, 30*60, 100, 255);
        lines.add(new Line(a, b, 1, color(255, 100) ));
        translate(dist, 0);
      } else if (op == 'X' || op =='Y') {
        continue;
      } else if (op == '+') {
        rotate(-angle);
      } else if (op == '-') {
        rotate(angle);
      } else if (op == '[') {
        pushMatrix();
      } else if (op == ']') {
        popMatrix();
      }
    }

    popMatrix();
  }

  void display(int ub) {
    //angle = PI/6.0 + PI/3.0*sin(frameCount / 100.0);
    calculatePoints();
    strokeWeight(1);

    for (int i = 0; i < min(ub, lines.size()); i++) {
       lines.get(i).display();
    }
  }
}
