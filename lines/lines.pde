import java.util.*;

PImage pt;
ArrayList<ArrayList<Point>> strokes;

void setup() {
  size(800, 800, P2D);
  pt = loadImage("pt.png");
  strokes = new ArrayList<>();
  textureMode(NORMAL);
}

void mousePressed() {
  // Start a new stroke
  ArrayList<Point> stroke = new ArrayList<>();

  // Begin at the mouse position with an initial thickness
  stroke.add(new Point(new PVector(mouseX, mouseY), 2));
  strokes.add(stroke);
}

void mouseDragged() {

  // Add a new point to the latest stroke
  ArrayList<Point> stroke = strokes.get(strokes.size() - 1);

  // Instead of directly adding the mouse coordinate,
  // move from the last point *toward* the mouse, but
  // not quite getting there. This smooths the line
  PVector targetPt = new PVector(mouseX, mouseY);
  PVector lastPt = stroke.get(stroke.size()-1).pt;

  // This moves 10% of the way to the mouse. Try other values here
  // for different amounts of smoothing
  PVector pt = lastPt.copy().lerp(targetPt, 0.2);

  // Do the same for thickness
  float targetThickness = new PVector(pmouseX, pmouseY).dist(targetPt)*15;
  float lastThickness =  stroke.get(stroke.size()-1).thickness;
  float thickness = lerp(lastThickness, targetThickness, 0.2);

  stroke.add(new Point( pt, thickness ));
}

void draw() {
  background(255);
  fill(0);
  noStroke();


  // Loop over all strokes
  for (ArrayList<Point> stroke : strokes) {
    // Got to have at least two points to connect into a line!
    if (stroke.size() < 2) continue;

    // Calculate the direction to expand each stroke in
    ArrayList<PVector> tangents = new ArrayList<>();
    for (int i = 1; i < stroke.size(); i++) {
      Point prev = stroke.get(i-1);
      Point next = stroke.get(i);
      tangents.add(next.pt.copy().sub(prev.pt).normalize());
    }

    // We want a direction for each stroke but we have strokes.length-1
    // *differences* between strokes, so we just duplicate the last one
    tangents.add(tangents.get(tangents.size()-1).copy());

    // Rotate the tangent directions to point directly out
    ArrayList<PVector> normals = new ArrayList<>();
    for (PVector p : tangents) {
      normals.add(p.copy().rotate(90));
    }

    // Draw the outline of the shape
    beginShape(TRIANGLE_STRIP);
    texture(pt);  
    for (int i = 0; i < stroke.size(); i++) {
      PVector n = normals.get(i);
      fill(0, max(50, map(stroke.get(i).thickness,0,15, 50, 255)));
      // Loop over inside and outside of the curve
      vertex(
        stroke.get(i).pt.x + 1 * n.x * stroke.get(i).thickness / 2,
        stroke.get(i).pt.y + 1 * n.y * stroke.get(i).thickness / 2,
        1,
        map(i, 0, stroke.size(), 0, 1)
        );
      vertex(
        stroke.get(i).pt.x + -1 * n.x * stroke.get(i).thickness / 2,
        stroke.get(i).pt.y + -1 * n.y * stroke.get(i).thickness / 2,
        0,
        map(i, 0, stroke.size(), 0, 1)
        );
    }
    endShape();
  }
  //saveFrame("frames/######.png");
}



void keyPressed(){
   if(key == 'r'){
      strokes =   new ArrayList<>();
   }else if (keyCode == DOWN){
      strokes.remove(strokes.size() - 1); 
   }
  
}
