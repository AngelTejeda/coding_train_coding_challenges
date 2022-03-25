class Branch {
  // Fields
  private PVector pos;
  private PVector originalDir;
  private int timesPulled;
  private int order;
    
  public PVector dir;
  public ArrayList<Branch> children;
  
  // Constants
  private static final float len = 5;
  color branchColor = color(105, 53, 23);

  // Constructor
  public Branch(PVector pos, PVector dir, int order) {
    this.order = order;
    this.pos = pos;
    this.dir = dir.copy();
    originalDir = dir.copy();
    
    timesPulled = 0;    
    children = new ArrayList();
    
    if (order > maxOrder)
      maxOrder = order;
  }
  
  // Getters and Setters
  public PVector getPosition() {
    return pos.copy();
  }
  
  public boolean isPulled() {
    return timesPulled > 0;
  }
  
  public void increaseTimesPulled() {
    timesPulled++;
  }
  
  // Methods
  public void show() {
    //float weight = 6 / (order + 2) +1;
    float weight = map(order, 0, maxOrder + 1, 5, 0.5);
    
    stroke(branchColor);
    strokeWeight(weight);    
    
    if (children == null)
      return;
      
    for (Branch child : children) {
      line(pos.x, pos.y, pos.z, child.pos.x, child.pos.y, child.pos.z);
      
      child.show();
    }
  }
  
  /*
    Add a child branch to the current branch, based on its angle
  */
  public Branch generateBranch() {
    dir.div(timesPulled + 1);
    
    PVector newDir = PVector.mult(dir, len);
    PVector newPos = PVector.add(pos, newDir);

    Branch newBranch = new Branch(newPos, this.dir.copy(), order + 1);
    children.add(newBranch);
    
    return newBranch;
  }
  
  public void reset() {
    timesPulled = 0;
    dir = originalDir.copy();
  }
}
