import peasy.*;

Tree tree;
int maxOrder;
PeasyCam cam;

static final float maxDistance = 100;
static final float minDistance = 10;

void setup() {
  size(400, 400, P3D);
  
  maxOrder = 0;
  generateTree();
  
  cam = new PeasyCam(this, width / 2, height / 2, 0, 400);
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

void keyPressed() {
  if (key == ' ')
    generateTree();
}
