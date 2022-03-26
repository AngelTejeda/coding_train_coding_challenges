public class Particle extends VerletParticle2D {
  
  public boolean isLocked;
  public boolean allowToggle;
  
  public Particle(float x, float y) {
    super(x, y);
    isLocked = false;
    allowToggle = true;
  }
  
  public void show() {
    float weight = isLocked ? 6 : 3;
    color c = color(0);
    
    if (!activePhysics) {
      if (mouseOver()) c = color(212, 4, 4);
      else if (isLocked) c = color(212, 4, 4);
    }
    
    strokeWeight(weight);
    stroke(c);
    point(x, y);
  }
  
  public void toggleLock() {
    if (!allowToggle && !mousePressed) {
      allowToggle = true;
      return;
    }
    
    if (!allowToggle) {
      return;
    }
    
    if (mouseOver() && mousePressed) {
      allowToggle = false;
      isLocked = !isLocked;
      
      if (isLocked)
        this.lock();
      else
        this.unlock();
    }
  }
  
  public boolean mouseOver() {
    boolean isOverX = x - sep / 2 < mouseX && mouseX <= x + sep / 2;
    boolean isOverY = y - sep / 2 < mouseY && mouseY <= y + sep / 2;
    
    return isOverX && isOverY;
  }
}
