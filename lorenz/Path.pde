

class Path {
  PVector current;
  List<PVector> path;
  float dt = .01;
  float dx, dy, dz;
  float scale = 9;
  float rho = 28;
  float sigma = 10;
  float beta = 8./3.;

  Path(float x, float y, float z) {
    current = new PVector(x, y, z);
    path = new ArrayList<>();
    path.add(current);
  }

  void display(PGraphics img) {
    img.strokeWeight(2);
    img.stroke(0, 255, 200, 60);
    for (int i = 0; i < path.size()-1; i++) {
      img.line(scale*path.get(i).x, scale*path.get(i).y, scale*path.get(i).z,
        scale*path.get(i+1).x, scale*path.get(i+1).y, scale*path.get(i+1).z);
    }
    img.strokeWeight(map(dx+dy+dz, 1.5, 0, 3, 8));
    img.stroke(255, 255, 255);
    img.point(scale*current.x, scale*current.y, scale*current.z);
  }

  void calcNextPoint() {
    dx = sigma*(current.y-current.x);
    dy = current.x*(rho-current.z) - current.y;
    dz = current.x * current.y - beta*current.z;
    dx*=dt;
    dy*=dt;
    dz*=dt;
    current = new PVector(current.x + dx, current.y + dy, current.z + dz);
    path.add(current);
  }
}
