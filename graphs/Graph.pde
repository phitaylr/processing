

class Graph {

  List<Vertex> vertices;

  Graph() {
    vertices = new ArrayList<>();
  }

  void add(Vertex n) {
    vertices.add(n);
  }

  void generateGraph(int n, int a, int b) {
    for (int i = 0; i < n; i++) {
      Vertex newVertex = new Vertex(random(.1*width, .9*width), random(.1*height, .9*height));
      add(newVertex);
    }
    for (Vertex vertex : vertices) {
      for (int i = 0; i < random(b-a) + a; i++) {
        int target = -1;
        while (target < 0 || vertices.get(target).equals(vertex)) {
          target = (int) random(vertices.size());
        }
        vertex.edges.put(vertices.get(target), vertex.weight(vertices.get(target)));
      }
    }
    makeBidirectional();
  }

  Path getShortestPath(Vertex s, Vertex t) {
    println(s);
    println(t);
    Path p = new Path();
    HashMap<Vertex, Float> distances = new HashMap<>();
    List<Vertex> settled = new ArrayList<>();
    List<Vertex> unsettled = new ArrayList<>();
    Map<Vertex, Vertex> predecessors = new HashMap<>();

    for (Vertex v : vertices) {
      distances.put(v, Float.MAX_VALUE);
    }
    distances.put(s, 0.);
    unsettled.add(s);

    while (!unsettled.isEmpty()) {
      //get node with lowest distance
      Vertex eval = unsettled.get(0);
      float mind = distances.get(eval);
      for (Vertex v : unsettled) {
        if (distances.get(v) < mind) {
          eval = v;
        }
      }
      unsettled.remove(eval);
      settled.add(eval);

      //evaluated Neighbors
      for (Map.Entry<Vertex, Float> edge : eval.edges.entrySet()) {
        if (!settled.contains(edge.getKey())) {
          float edgedist = edge.getValue();
          float newdist = edgedist + distances.get(eval);
          if (distances.get(edge.getKey()) > newdist) {
            distances.put(edge.getKey(), newdist);
            unsettled.add(edge.getKey());
            predecessors.put(edge.getKey(), eval);
          }
        }
      }
    }
    p.add(t);
    Vertex step = t;


    while (predecessors.get(step) != null) {
      step = predecessors.get(step);
      p.add(step);
    }
    Collections.reverse(p.path);
    println(p);
    return p;
  }

  Vertex getClosestVertex(int x, int y) {
    float mind = Float.MAX_VALUE;
    Vertex closest = vertices.get(0);
    for (Vertex n : vertices) {
      if (dist(n.x, n.y, x, y) < mind) {
        mind =  dist(n.x, n.y, x, y);
        closest = n;
      }
    }
    return closest;
  }
  
  void recalcDistances(){
    for(Vertex v: vertices){
      for(Map.Entry<Vertex, Float> edge : v.edges.entrySet()){
         v.edges.put(edge.getKey(), v.weight(edge.getKey())); 
      }
    }
  }

  void makeBidirectional() {
    for (Vertex n : vertices) {
      for (Map.Entry<Vertex, Float> o : n.edges.entrySet()) {
        o.getKey().edges.put(n, o.getValue());
      }
    }
  }

  void display() {
    for (Vertex n : vertices) {
      n.display();
    }
  }
}
