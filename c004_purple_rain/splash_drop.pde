class SplashDrop {
  float x;
  float y;
  float z;
  float angle;
  float velocity;
  float xVelocity;
  float yVelocity;
  boolean finish;
  
  SplashDrop(float x, float z, float velocity) {
    this.x = x;
    this.z = z;
    this.velocity = map(velocity, 4, 11, 0.2, 0.8) + random(0.5);
    
    y = height;
    angle = random(-PI, 0);
    xVelocity = this.velocity * cos(angle);
    yVelocity = this.velocity * sin(angle);
    finish = false;
  }
  
  void show() {
    float lineWidth = map(z, 0, 20, 0.5, 1.3);
    strokeWeight(lineWidth);
    stroke(138, 43, 226);
    ellipse(x, y, 0.5, 0.5);
  }
  
  void update() {
    x += xVelocity;
    y += yVelocity;
    yVelocity += 0.05;
    
    if (y >= height) {
      finish = true;
    }
  }
}
