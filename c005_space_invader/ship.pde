import java.util.Iterator;

class Ship {
  private float x;
  private float y;
  private float size;
  private float speed;
  private float maxSpeed;
  private int direction;
  private ArrayList<Projectile> projectiles;
  private int gunCooldown;
  
  Ship(float y, float size) {
    this.size = size;
    this.y = y;
    
    x = width / 2;
    speed = 4;
    maxSpeed = 15;
    size = 20;
    direction = 0;
    projectiles = new ArrayList<Projectile>();
    gunCooldown = 0;
  }
  
  public void show() {
    noStroke();
    fill(255);
    rect(x, y, size, size);
  }
  
  private void updateProjectiles() {
    Iterator<Projectile> itr = projectiles.iterator();
    
    while (itr.hasNext()) {
      Projectile projectile = itr.next();
      
      if (!projectile.isActive) {
        itr.remove();
      }
      else {
        projectile.update();
        projectile.show();
      }
    }
  }
  
  private void move() {
    x += speed * direction;
    
    if (x < 0) {
      x = 0;
      //speed = 0;
      direction = 0;
    }
    if (x > width - size) {
      x = width - size;
      //speed = 0;
      direction = 0;
    }
  }
  
  private void updateCooldown() {
    if (gunCooldown > 0)    
      gunCooldown--;
  }
  
  public void update() {
    updateProjectiles();
    updateCooldown();
    //updateSpeed();
    move();
  }
  
  public void setDir(int direction) {
    this.direction = direction;
  }
  
  private void updateSpeed() {
    speed += direction != 0 ? 0.5 : -0.1;
    
    if (speed < 0)
      speed = 0;
    
    else if (speed > maxSpeed)
      speed = maxSpeed;
  }
  
  public void shoot() {
    if (gunCooldown > 0)
      return;
    
    float projX = x + size/2;
    
    projectiles.add(new Projectile(projX, y));
    gunCooldown = 30;
  }
  
  public boolean collides(Enemy enemy) {
    boolean hitX = (enemy.x <= x && x <= enemy.x + enemy.size) || (enemy.x <= x + size && x + size <= enemy.x + enemy.size);
    boolean hitY = (enemy.y <= y && y <= enemy.y + enemy.size) || (enemy.y <= y + size && y + size <= enemy.y + enemy.size);
    
    return hitX && hitY;
  }
  
  public ArrayList<Projectile> getProjectiles() {
    return projectiles;
  }
}
