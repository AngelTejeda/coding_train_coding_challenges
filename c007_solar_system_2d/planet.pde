class Planet {
  private float angle;
  private float distance;
  private float radius;
  private float speed;
  private Planet[] moons;
  private color planetColor;
  
  Planet(float radius, float speed, color planetColor) {
    this.radius = radius;
    this.speed = speed;
    this.planetColor = planetColor;
    
    angle = random(0, 2 * PI);
    distance = 0;
  }
  
  public void setDistance(float distance) {
    this.distance = distance;
  }
  
  public float spawnMoons(int quantity, int level) {
    if (level >= maxLevel)
      return radius;
      
    float systemRadius = radius;

    moons = new Planet[quantity];
    
    color moonColor = color(random(255), random(255), random(255));
    
    for (int i=0 ; i<quantity; i++) {
      // Create new planet
      int moonDirection = random(0, 1) > 0.5 ? -1 : 1;
      float moonSpeed = random(PI / 400, PI / 300) * (quantity - i + 1) * moonDirection;      
      float moonRadius = radius * random(0.3, 0.6); 
      moons[i] = new Planet(moonRadius, moonSpeed, moonColor);
      
      // Create the planet moons
      int subMoons = int(random(0, maxMoons));
      float moonSystemRadius = moons[i].spawnMoons(subMoons, level + 1);
      
      float moonDistance = systemRadius + moonSystemRadius + radius * random(0.3, 0.8);
      moons[i].setDistance(moonDistance);
      
      systemRadius += moonSystemRadius * 2;
    }
    
    return systemRadius;
  }
  
  public void show() {
    fill(planetColor);
    noStroke();
    
    pushMatrix();
      rotate(angle);
      translate(distance, 0);
      ellipse(0, 0, radius * 2, radius * 2);
      
      showMoons();
      showLines();
    popMatrix();   
  }
  
  private void showLines() {
    if (moons == null || !drawLines)
      return;
    
    for (Planet moon : moons) {
      float x = moon.distance * cos(moon.angle);
      float y = moon.distance * sin(moon.angle);
      
      stroke(0, 100, 0);
      strokeWeight(1);
      
      line(0, 0, x, y);
    }
  }
  
  public void orbit() {
    this.angle += speed;
    
    if (moons == null)
      return;
      
    for (Planet moon : moons) {
      moon.orbit();
    }
  }
  
  private void showMoons() {
    if (moons == null)
      return;
      
    for (Planet moon : moons) {
      moon.show();
    }
  }
}
