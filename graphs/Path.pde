

class Path {

  List<Vertex> path;

  Path() {
    path = new ArrayList<>();
  }

  void add(Vertex n) {
    path.add(n);
  }

  float length() {
    float d = 0;
    for (int i = 0; i < path.size() - 1; i++) {
      d+=path.get(i).weight(path.get(i+1));
    }
    return d;
  }

  void display() {
    display(1);
  }

  void display(float perc) {
    fill(255, 0, 0, 10);
    float d = length();
    if (path.size() > 0) {
      circle( path.get(0).x, path.get(0).y, 20);
      circle( path.get(path.size() - 1).x, path.get(path.size() - 1).y, 10);
    }
    float travelled = 0.;
    for (int i = 0; i < path.size() - 1; i++) {
      Vertex src = path.get(i);
      Vertex target = path.get(i+1);
      stroke(0, map(src.weight(target), 0, sqrt(width*width+height*height), 200, 255), 255, 200);
      strokeWeight(10);
       if(perc*d > travelled && perc*d <= travelled + src.weight(target)){ //draw last part
        PVector last = new PVector(target.x-src.x, target.y-src.y);
        last.normalize().mult(src.weight(target) * (perc-travelled/d));
        line(src.x, src.y, src.x+last.x, src.y+last.y);
        break;
      } else if (travelled + src.weight(target) <= perc*d) { //draw whole thing
        line(src.x, src.y, target.x, target.y);
        travelled += src.weight(target);
      }
    }
  }



  String toString() {
    String out="";
    for (int i = 0; i < path.size(); i++) {
      Vertex src = path.get(i);

      out += (src);
    }
    return out;
  }
}
