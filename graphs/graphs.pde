import java.util.*;

enum State {
  NORMAL, ADDEDGE, SHORTESTPATH
}

Graph g;
Vertex lastClicked;
Path shortestPath;
State state = State.NORMAL;
float animationstart;
String status = "Normal";
boolean record = true;

void setup() {
  size(1080, 1080);
  g = new Graph();
  g.generateGraph(10, 1, 2);
}

void draw() {
  background(255);
  stroke(255, 255, 0);
  circle(mouseX, mouseY, 20);
  fill(0);
  textSize(24);
  text(status, 10, 30);
  g.display();
  if (state == State.ADDEDGE) {
    stroke(0, 0, 255, 100);
    strokeWeight(3);
    line(mouseX, mouseY, lastClicked.x, lastClicked.y);
  } else if (state == State.SHORTESTPATH) {
    shortestPath.display(animationstart+=.01);
    status = "Shortest path: " + shortestPath.length();
  }
  if (record) {
    saveFrame("frames/######.png");
  }
}

void mousePressed() {
  // reset old things
  if (key != 's') {
    shortestPath = null;
    state = State.NORMAL;
  }

  // do new things
  if (key == 'n') {
    Vertex n = new Vertex(mouseX, mouseY);
    g.add(n);
  } else if (key == 'e') {
    state = State.ADDEDGE;
    if (lastClicked == null) {
      lastClicked = g.getClosestVertex(mouseX, mouseY);
    } else {
      Vertex second = g.getClosestVertex(mouseX, mouseY);
      lastClicked.edges.put(second, lastClicked.weight(second));
      second.edges.put(lastClicked, second.weight(lastClicked));
      lastClicked = null;
      state = State.NORMAL;
    }
  } else if (key == 'd') { //delete vertex
    Vertex toRemove =g.getClosestVertex(mouseX, mouseY);
    g.vertices.remove(toRemove);
    for (int i=0; i < g.vertices.size(); i++) {
      Vertex n = g.vertices.get(i);
      Iterator it = n.edges.entrySet().iterator();
      while (it.hasNext()) {
        Map.Entry<Vertex, Float> o = (Map.Entry) it.next();
        if (o.getKey() == toRemove) {
          it.remove();
        }
      }
    }
  } else if (key == 's') {
    if (lastClicked == null) {
      shortestPath = new Path();

      lastClicked = g.getClosestVertex(mouseX, mouseY);
    } else {
      state = State.SHORTESTPATH;
      Vertex second = g.getClosestVertex(mouseX, mouseY);
      shortestPath = g.getShortestPath(lastClicked, second);
      lastClicked = null;
      animationstart = 0.0;
    }
  } else if (key == 'r') {
    shortestPath = null;
    lastClicked = null;

    state = State.NORMAL;
  }
}

void keyPressed() {
  state = State.NORMAL;
  if (key == 'n') {
    status = "Add a new vertex.";
  } else if (key == 'e') {
    status = "Add a new edge.";
  } else if (key == 's') {
    status = "Select two vertices to find the shortest path.";
  } else if (key == 'd') {
    status = "Remove a vertex.";
  } else if (key == 'm') {
    status = "Move a vertex.";
  } else {
    status = "Make a valid choice.";
  }
}

void mouseDragged() {
  if (key == 'm') {
    Vertex target = g.getClosestVertex(mouseX, mouseY);
    target.x = mouseX;
    target.y = mouseY;
    g.recalcDistances();
  }
}
