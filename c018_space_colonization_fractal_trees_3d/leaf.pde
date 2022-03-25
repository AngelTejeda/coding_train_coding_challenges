class Leaf {
  // Fields
  private PVector pos;
  private boolean reached;
  
  // Constants
  color leafColor = color(11, 133, 43);
  
  // Constructor
  public Leaf(float x, float y, float z) {
    pos = new PVector(x, y, z);
    reached = false;
  }
  
  // Getters and Setters
  public PVector getPosition() {
    return pos.copy();
  }
  
  public void markAsReached() {
    reached = true;
  }
  
  public boolean isReached() {
    return reached;
  }
  
  // Methods
  public void show() {
    stroke(leafColor);
    strokeWeight(3);
    
    point(pos.x, pos.y, pos.z);
  }
}
