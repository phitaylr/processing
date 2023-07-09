class Vertex {

  Map<Vertex, Float> edges;
  float x, y;

  Vertex(float x, float y) {
    this.x = x;
    this.y = y;
    edges = new HashMap<>();
  }

  void display() {

    for (Map.Entry<Vertex, Float> entry : edges.entrySet()) {
      Vertex o = entry.getKey();
      float dist = entry.getValue();
      stroke(0, 0, map(dist, 0, sqrt(width*width+height*height), 100, 255));
      strokeWeight(3);
      line(x, y, o.x, o.y);
    }
    strokeWeight(map(edges.size(), 0, 8, 20, 40));
    stroke(50, 200, 50);
    point(x, y);
  }

  float weight(Vertex b) {
    return dist(x, y, b.x, b.y);
  }

  boolean equals(Object o) {
    Vertex b = (Vertex) o;
    return abs(b.x-x) < .001 && abs(b.y-y) < .001;
  }
  
  String toString(){
   return ("("+x+","+y+")"); 
  }
}
