class Projectile {
  private float x;
  private float y;
  private float speed;
  public boolean isActive;
  private float w;
  private float h;
  
  Projectile(float x, float y) {
    speed = 5;
    isActive = true;
    w = 5;
    h = 10;
    
    this.x = x - w/2;
    this.y = y - h/2;
  }
  
  public void show() {
    fill(255);
    noStroke();
    rect(x, y, w, h);
  }
  
  public void update() {
    y -= speed;
    
    if (y <= 0)
      isActive = false;
  }
  
  public boolean hits(Enemy enemy) {
    boolean hitX = (enemy.x <= x && x <= enemy.x + enemy.size) || (enemy.x <= x + w && x + w <= enemy.x + enemy.size);
    boolean hitY = (enemy.y <= y && y <= enemy.y + enemy.size) || (enemy.y <= y + h && y + h <= enemy.y + enemy.size);
    
    if (hitX && hitY) {
      isActive = false;
      return true;
    }
    
    return false;
  }
}
