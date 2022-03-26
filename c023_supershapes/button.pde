public enum ButtonStates {
  Untouched,
  PressedOver,
  PressedAway,
  ActivePress,
  SingleActive
}

public class Button {
  private PVector pos;
  private float size;
  private String label;
  private int cooldown;
  private PFont font;
  private ButtonStates state;
  
  public Button(PVector pos, float size, String label) {
    this.pos = pos;
    this.size = size;
    this.label = label;
    
    font = createFont("Arial", size * 0.75, true);
    
    state = ButtonStates.Untouched;
    cooldown = 100;
  }
  
  public boolean isPressed() {
    return state == ButtonStates.PressedAway || state == ButtonStates.PressedOver || state == ButtonStates.ActivePress;
  }
  
  public boolean isActive() {
    return state == ButtonStates.ActivePress || state == ButtonStates.SingleActive;
  }
  
  public void update() {
    boolean over = mouseOver();
    int baseCooldown = 40;
    int pressedCooldown = 5;
    
    if (state == ButtonStates.ActivePress) {
      cooldown = pressedCooldown;
      state = ButtonStates.PressedOver;
    }
    
    else if (state == ButtonStates.SingleActive) {
      cooldown = baseCooldown;
      state = ButtonStates.Untouched;
    }
    
    else if (!over && !mousePressed) {
      state = ButtonStates.Untouched;
      cooldown = baseCooldown;
    }
    
    else if (!over && mousePressed) {
      if (state == ButtonStates.PressedOver) {
        state = ButtonStates.PressedAway;
        cooldown = baseCooldown;
      }
    }
    
    else if (over && !mousePressed) {
      if (state == ButtonStates.PressedOver) {
        cooldown = baseCooldown;
        state = ButtonStates.SingleActive; 
      }
    }
    
    else if (over && mousePressed) {
      if (state == ButtonStates.PressedOver) {
        if (cooldown > 0) {
          cooldown--;
        }
        else {
          state = ButtonStates.ActivePress;
        }
      }
      else {
        state = ButtonStates.PressedOver;
      }
    }
    
  }
  
  public void show() {
    color fillColor = isPressed()
      ? color(140)
      : mouseOver()
        ? color(200)
        : color(255);
      
    fill(fillColor);
    stroke(100);
    
    rect(pos.x, pos.y, size, size);
    
    fill(0);
    textAlign(CENTER);
    float textH = th.getHeight(label, font);
    text(label, pos.x + size / 2, pos.y + size / 2 + textH / 2);
  }
  
  private boolean mouseOver() {
    boolean isOverX = pos.x <= mouseX && mouseX <= pos.x + size;
    boolean isOverY = pos.y <= mouseY && mouseY <= pos.y + size;
    
    return isOverX && isOverY;
  }
}
