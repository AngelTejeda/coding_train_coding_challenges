class Enemy {
  public float x;
  public float y;
  public float size;
  public boolean isAlive;
  
  private int direction;
  private float separation;
  private float speed;
  
  Enemy(float x, float y, float size, float separation) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.separation = separation;
    
    isAlive = true;
    direction = 1;
    speed = 0.3;
  }
  
  public void show() {
    noStroke();
    fill(255);
    
    if (!isAlive) {
      size -= 5;
      
      if (size <= 0)
        size = 0;
    }
    
    rect(x, y, size, size);
  }
  
  public void move() {
    x += speed * direction;
  }
  
  public boolean collidesWithWall() {
    return x <= 0 || x + size >= width;
  }
  
  public void shiftDown() {
    direction *= -1;
    y += size + separation;
  }
  
  public void die() {
    isAlive = false;
  }
}
