import java.util.*;

ArrayList<TruchetTile> tiles;
ArrayList<Node> graph;
ArrayList<Node> nodesToDraw = new ArrayList();


int cols = 20;
int rows = 20;
float colWidth, rowHeight;
int animationStart = 0;

void setup() {
  size(800, 800, P2D);
  colWidth = width/cols;
  rowHeight = height/rows;

  tiles = new ArrayList<>();
  graph = new ArrayList();

  // gen tiles
  for (int i = 0; i < cols*rows; i++) {
    tiles.add(new TruchetTile(i/cols *colWidth,
      i%rows * rowHeight,
      colWidth, rowHeight));
  }
  for (TruchetTile tile : tiles) {
    tile.display();
  }

  //add nodes
  for (TruchetTile tile : tiles) {
    if (tile.config == Type.UP) {
      graph.add(new Node(tile.x+.25*colWidth, tile.y+.25*rowHeight));
      graph.add(new Node(tile.x+.75*colWidth, tile.y+.75*rowHeight));
    } else if (tile.config == Type.DOWN) {
      graph.add(new Node(tile.x+.25*colWidth, tile.y+.75*rowHeight));
      graph.add(new Node(tile.x+.75*colWidth, tile.y+.25*rowHeight));
    }
  }

  // add edges
  for (int i = 0; i < graph.size(); i++) {
    for (int j = i+1; j < graph.size(); j++) {
      if (dist(graph.get(i).x, graph.get(i).y, graph.get(j).x, graph.get(j).y) < colWidth) {
        if (get((int)(graph.get(i).x + graph.get(j).x)/2, (int)(graph.get(i).y + graph.get(j).y)/2 ) != color(0)) {
          graph.get(i).neighbors.add(graph.get(j));
          graph.get(j).neighbors.add(graph.get(i));
        }
      }
    }
  }
}

void draw() {
  background(255);
  for (TruchetTile tile : tiles) {
    tile.display();
  }

  animationStart += 1;
  for (int i = 0; i < min((int)animationStart, nodesToDraw.size()-1); i++) {
    strokeWeight(10);
    stroke(0, 0, 255);
    if (dist(nodesToDraw.get(i).x, nodesToDraw.get(i).y, nodesToDraw.get(i+1).x, nodesToDraw.get(i+1).y) < colWidth)
      line(nodesToDraw.get(i).x, nodesToDraw.get(i).y, nodesToDraw.get(i+1).x, nodesToDraw.get(i+1).y);
  }


     save(String.format("frames/%06d.png", frameCount));
  
}


void mousePressed() {
  //find closest node
  nodesToDraw = new ArrayList();
  animationStart = 0;
  float mindist = dist(mouseX, mouseY, graph.get(0).x, graph.get(0).y);
  Node closestNode = graph.get(0);
  for (int i = 1; i < graph.size(); i++) {
    if (dist(mouseX, mouseY, graph.get(i).x, graph.get(i).y) < mindist) {
      mindist = dist(mouseX, mouseY, graph.get(i).x, graph.get(i).y);
      closestNode = graph.get(i);
    }
  }
  closestNode.getNeighbors(nodesToDraw);
  println(nodesToDraw.size());
}
