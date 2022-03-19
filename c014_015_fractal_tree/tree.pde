import java.util.Iterator;

class Tree {
  PVector root;
  PVector end;
  float angle;
  float size;
  float level;
  ArrayList<Tree> branches;
  ArrayList<PVector> leaves;
  
  color leafColor = color(11, 133, 43);
  color trunkColor = color(105, 53, 23);
  
  public Tree(PVector root, float angle, float size, float level) {
    this.root = root;
    this.angle = angle;
    this.size = size;
    this.level = level;
    
    float endX = root.x + size * cos(angle);
    float endY = root.y - size * sin(angle);
    end = new PVector(endX, endY);
    
    branches = new ArrayList<Tree>();
    leaves = new ArrayList<PVector>();
    
    branchOut();
  }
  
  private boolean isLeaf() {
    return level >= maxLevel -1;
  }
  
  public void shake() {
    for (Tree branch : branches) {
      branch.shake();
    }
    
    if (!isLeaf())
      return;
    
    if (random(5000) < 5)
      dropLeaf();
  }
  
  public void show() {
    showTree();
    showBranches();
    showLeafParticles();
  }
  
  private void showTree() {
    if (isLeaf()) {
      stroke(leafColor);
    }
    // If is trunk or branch
    else {
      stroke(trunkColor);
    }
      
    strokeWeight(5 / level);
    
    line(root.x, root.y, end.x, end.y);
  }
  
  private void showBranches() {
    for (Tree branch : branches) {
      branch.show();
    }
  }
  
  private void showLeafParticles() {
    Iterator<PVector> itr = leaves.iterator();
    
    while(itr.hasNext()) {
      PVector leaf = itr.next();
      
      leaf.add(random(-1, 1), random(1, 1.5));
      
      if (leaf.y > height + 10)
        itr.remove();
    }
    
    strokeWeight(2);
    stroke(leafColor);
    for (PVector leaf : leaves) {
      point(leaf.x, leaf.y);
    }
  }
  
  public void branchOut() {
    if (level > maxLevel)
      return;
    
    int numBranches = floor(random(level + 2) + 2);
    
    for (int i=0 ; i<numBranches ; i++) {
      PVector r = end;
      float a = angle + random(-PI / 3, PI / 3);
      float s = size * random(0.5, 0.8);
      float l = level + 1;
      
      Tree branch = new Tree(r, a, s, l);
      branches.add(branch);
    }
  }
  
  public void dropLeaf() {
    PVector leaf = new PVector(end.x, end.y);
    leaves.add(leaf);
  }
}
