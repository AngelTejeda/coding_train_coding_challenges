import peasy.*;

PeasyCam cam;

float x;
float y;
float z;

float sigma = 10;
float rho = 28;
float beta = 8.0 / 3.0;
float dt = 0.01;



ArrayList<LinePoint> points;
float hue;

void setup() {
  size(400, 400, P3D);
  
  cam = new PeasyCam(this, 500);
  
  colorMode(HSB);
  background(0);
  
  x = 0.1;
  y = 0.1;
  z = 0.1;
  
  points = new ArrayList<LinePoint>();
  hue = 0;
}

void draw() {
  background(0);
  float dx = dt * (sigma * (y - x));
  float dy = dt * (x * (rho - z) - y);
  float dz = dt * (x * y - beta * z);
  
  x += dx;
  y += dy;
  z += dz;
  
  points.add(new LinePoint(new PVector(x, y, z), color(hue, 255, 255)));
  hue += 0.5;
  
  if (hue > 255)
    hue = 0;

  showPoints();
}

void vertex(PVector v) {
  vertex(v.x, v.y, v.z);
}

void showPoints() {  
  noFill();
  strokeWeight(2);
  
  beginShape();
  for (LinePoint p : points) {
    stroke(p.c);
    vertex(p.pos);
  }
  endShape();
}
