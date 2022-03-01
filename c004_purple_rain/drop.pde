import java.util.LinkedList;

class Drop {
  float x;
  float y;
  float z;
  
  float len;
  
  float ySpeed;
  LinkedList<SplashDrop> splash;
  boolean falling;
  
  Drop() {
    x = random(width);
    y = random(-500, -100);
    z = random(20);
    len = map(z, 0, 20, 10, 20);
    ySpeed = map(z, 0, 20, 4, 10);
    falling = true;
  }
  
  void show() {
    float lineWidth = map(z, 0, 20, 0.8, 2);
    
    strokeWeight(lineWidth);
    stroke(138, 43, 226);
    line(x, y, x, y + len);
  }
  
  void update() {    
    if (falling)
      fall();
    else
      splash();
    
  }
  
  private void fall() {
    y += ySpeed;
    ySpeed += 0.02;
    
    if (y > height) {
      falling = false;
      splash = getNewList();
      x = random(width);
      y = random(-200, -100);
      len = map(z, 0, 20, 10, 20);
      ySpeed = map(z, 0, 20, 4, 10);
    }
  }
  
  private LinkedList<SplashDrop> getNewList() {
    LinkedList<SplashDrop> list = new LinkedList<SplashDrop>();
    
    for (int i=0 ; i<2 ; i++) {
      list.add(new SplashDrop(x, z, ySpeed));
    }
    
    return list;
  }
  
  private void splash() {
    int count = 0;
    for (SplashDrop drop : splash) {
      if (drop.finish)
        continue;
        
      drop.update();
      drop.show();
      count++;
    }
    
    if (count == 0)
      falling = true;
  }
}
