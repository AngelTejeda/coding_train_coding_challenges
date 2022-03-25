Tree tree;
int maxOrder;

static final float maxDistance = 100;
static final float minDistance = 10;

void setup() {
  size(400, 400);
  
  maxOrder = 0;
  generateTree();
}

void draw() {
  background(51);
  
  tree.show();
  tree.grow();
  
  if (!tree.isGrowing()) {
    tree.removeLeaves();
  }
}

void generateTree() {
  tree = new Tree(width / 2, height);
  
  tree.generateLeaves();
  tree.generateTrunk();
}

void mousePressed() {
  if (mouseButton == LEFT)
    generateTree();
}
