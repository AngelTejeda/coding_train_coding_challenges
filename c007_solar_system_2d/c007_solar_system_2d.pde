Planet sun;

int maxLevel = 3;
int maxMoons = 5;
boolean drawLines = true;

void setup() {
  size(800, 800);
  
  sun = new Planet(30, 0, color(random(255), random(255), random(255)));
  sun.spawnMoons(5, 1);
}

void draw() {
  background(0);
  translate(width / 2, height / 2);
  
  sun.show();
  sun.orbit();
}

void mousePressed() {
  drawLines = !drawLines;
}
