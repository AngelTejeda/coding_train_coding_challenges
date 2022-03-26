class Spring extends VerletSpring2D {
  private int orientation;
  
  public Spring(Particle a, Particle b, float len, int orientation) {
    super(a, b, len, 1);
    
    this.orientation = orientation;
  }
  
  public void show() {
    color c = color(0);
    float weight = 0.6;
    
    if (!activePhysics && mouseOver()) {
      c = color(212, 4, 4);
      weight = 2;
    }
      
    stroke(c);
    strokeWeight(weight);
    line(a.x, a.y, b.x, b.y);
  }
  
  private boolean mouseOver() {
    if (orientation == 1) {
      return a.x - sep / 2 < mouseX && mouseX <= a.x + sep / 2;
    }
    else if (orientation == 0) {
      return a.y - sep / 2 < mouseY && mouseY <= a.y + sep / 2;
    }
    else {
      return false;
    }
  } 
}
