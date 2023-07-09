class Node {

  float x, y;
  List<Node> neighbors;

  Node(float x, float y) {
    this.x=x;
    this.y=y;
    neighbors = new ArrayList();
  }

  void display() {
    strokeWeight(8);
    stroke(255, 0, 0);
    point(x, y);
  }

  void drawEdges() {
    strokeWeight(10);
    stroke(0, 0, 255);
    for (Node n : neighbors) {
      line(x, y, n.x, n.y);
    }
  }

  void getNeighbors(ArrayList<Node> connectedneighbors) {
    if (!connectedneighbors.contains(this)) {
      connectedneighbors.add(this);
      for (int i = 0; i < neighbors.size(); i++) {
        neighbors.get(i).getNeighbors(connectedneighbors);
        if (!connectedneighbors.contains(this)) {
          connectedneighbors.add(neighbors.get(i));
        }
      }
    }
  }
}
