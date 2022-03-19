Tree tree;
int maxLevel = 7;

void setup() {
  size(400, 400);
  
  createTree();
}

void draw() {
  background(51);
  tree.show();
}

void mousePressed() {
  if (mouseButton == LEFT)
    createTree();
  else
    tree.shake();
}

void createTree() {
  PVector root = new PVector(width / 2, height);
  float size = 100;
  float angle = HALF_PI;
  tree = new Tree(root, angle, size, 1);
}
