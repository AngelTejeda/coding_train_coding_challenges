class Planet {
  private float angle;
  private float radius;
  private float speed;
  private PVector tVector; // Translation Vector
  private PVector pVector; // Perpendicular Vector
  private Planet[] moons;
  private PShape globe;
  
  Planet(float radius, float speed, PImage image) {
    this.radius = radius;
    this.speed = speed;
    angle = random(0, 2 * PI);
    
    noStroke();
    noFill();
    globe = createShape(SPHERE, radius);
    globe.setTexture(image);
  }
  
  // Creates the moons of the planet recursively. The value it returns is the radius of the system
  // (from the center of the planet to the last of the planets that revolve around it)
  public float spawnMoons(int quantity, int level) {
    if (level >= maxLevel)
      return radius;

    float systemRadius = radius;

    moons = new Planet[quantity];    
    
    for (int i=0 ; i<quantity; i++) {
      // Create new planet
      int moonDirection = random(0, 1) > 0.5 ? -1 : 1;
      float moonSpeed = random(PI / 400, PI / 300) * (quantity - i + 1) * moonDirection;
      float moonRadius = radius * random(0.3, 0.6);
      moons[i] = new Planet(moonRadius, moonSpeed, getRandomTexture());
      
      // Create the new planet moons
      int subMoons = int(random(0, maxMoons));
      float moonSystemRadius = moons[i].spawnMoons(subMoons, level + 1);
      
      // Set the translation vector
      float moonDistance = systemRadius + moonSystemRadius + radius * random(0.3, 0.8); 
      PVector moonTranslationVector = PVector.random3D().mult(moonDistance);
      //PVector v = new PVector(1, 0, 0).mult(d);

      moons[i].setTranslationVector(moonTranslationVector);
      
      systemRadius += moonSystemRadius * 2;
    }
    
    return systemRadius;
  }
  
  public void setTranslationVector(PVector v) {
    tVector = v;
    PVector v2 = new PVector(1, 0, 1);//.mult(radius);
    pVector = tVector.cross(v2);
  }
  
  public void show() {
    if (tVector == null)
      return;
    
    pushMatrix();
      rotate(angle, pVector.x, pVector.y, pVector.z);
      translate(tVector.x, tVector.y, tVector.z);
      
      //sphere(radius);
      shape(globe);
      
      showMoons();
      showLines();
    popMatrix();   
  }
  
  private void showLines() {
    if (moons == null || !drawLines)
      return;
    
    for (Planet moon : moons) {
      stroke(0, 100, 0);
      strokeWeight(1);
      
      line(0, 0, 0, moon.pVector.x, moon.pVector.y, moon.pVector.z);
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
