class NumberInput {
  private PVector pos;
  private float size;
  private String label;
  private float increment;
  private float value;
  private Button upButton;
  private Button downButton;
  private PFont font;
  private float margin;

  
  public NumberInput(PVector pos, float size, String label, float increment) {
    this.pos = pos;
    this.size = size;
    this.label = label;
    this.increment = increment;
    
    margin = size / 4;
    
    float upButtonBottom = pos.y + size;
    PVector downButtonPos = new PVector(pos.x, upButtonBottom + margin);
    
    upButton = new Button(pos.copy(), size, "▲");
    downButton = new Button(downButtonPos, size, "▼");
    
    font = createFont("Arial", size * 0.75, true);
    
    value = 0;
  }
  
  public float getValue() {
    return value;
  }
  
  public void setValue(float value) {
    this.value = value;
  }
  
  public void update() {
    upButton.update();
    downButton.update();
    
    if (upButton.isActive())
      value += increment;
    else if (downButton.isActive()) {
      value -= increment;
    }
  }
  
  public void show() {
    upButton.show();
    downButton.show();
    
    textFont(font);
    float textH = th.getHeight(label, font);


    // Label
    float bottomY = (pos.y) + (2 * size) + margin;
    
    textAlign(CENTER);
    text(label, pos.x + size/2, bottomY + textH + margin);
    
    // Counter    
    String valueString = Float.toString(value);    
    float middleY = pos.y + (bottomY - pos.y) / 2;
    
    textAlign(LEFT);
    text(valueString, pos.x + size + margin, middleY + textH / 2);

  }
}
