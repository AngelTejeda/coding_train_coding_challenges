class Cell {
  public float x;
  public float y;
  public float r;
  private float extraH;
  private float area;

  public boolean isDividing;
  public boolean isAlive;
  private float divisionProgress;
  
  private float inertia;  // Used for the wiggle animation
  private float angle;
  
  Cell(float x, float y, float r, float initialAngle) {
    this.x = x;
    this.y = y;
    this.r = r;
    
    extraH = 0;
    area = PI * r * r;  // Area is calculated once and never changes
    
    isDividing = false;
    isAlive = true;
    divisionProgress = 0;
    
    inertia = 2 * PI; // Inertia starts at its maximum value
    angle = initialAngle;
  }
  
  public void show() {
    float extraW = 0;
    
    // The area is consistent, even when the height changes
    // Area = pi * (r + extraH) * (r + extraW)
    if (extraH != 0)
      extraW = (area / (PI * (r + extraH))) - r;
    
    strokeWeight(1);
    stroke(3, 94, 27);
    fill(35, 219, 84);
    
    pushMatrix();
      rectMode(CENTER);
      translate(x, y);
      rotate(angle);
      ellipse(0, 0, (r + extraW) * 2, (r + extraH) * 2);
      // This line shows the angle of rotation
      //line(0, 0, 0, -2 * r);
    popMatrix();
    
  }
  
  public void update() {
    if (isDividing) {
      stretch();
      return;
    }
    
    wiggle();
    
    angle += 0.0005 * random(10, 40);
    if (angle > 2 * PI)
      angle = 0;
  }
  
  // Normal animation
  private void wiggle() {
    inertia -= 0.005 * random(5, 20);
    
    if (inertia <= 0) 
      inertia = 4 * PI / 3;
      
    float inverseInertia = 2 * PI - inertia;
    
    // A sine function is used in the range [0, 4PI / 3],
    // and another one in the range (4PI / 3, 2PI]
    if (inertia <= 4 * PI / 3)
      extraH = sin(3 * inverseInertia + PI) * 0.1;
    else
      extraH = -1 * sin(3 * inverseInertia) / (3 * inverseInertia);
    
    extraH *= r / 2;
  }
  
  // Animation when the cell is dividing
  private void stretch() {
    divisionProgress += 0.02;
      
    if (divisionProgress > 1) {
      isDividing = false;
      isAlive = false;
    }
    
    float logValue = 0.3 * log(divisionProgress) + 1;
    
    extraH = logValue * r;
  }
  
  public void divide() {
    isDividing = true;
  }
  
  public ArrayList<Cell> getNewCells() {
    ArrayList<Cell> newCells = new ArrayList<Cell>();
    
    float newR = sqrt((area / 2) / PI);
    
    newCells.add(new Cell(x + r * sin(angle), y - r * cos(angle), newR, angle));
    newCells.add(new Cell(x - r * sin(angle), y + r * cos(angle), newR, angle));
    
    return newCells;
  }
}
