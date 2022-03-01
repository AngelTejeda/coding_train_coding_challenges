class Star {
  float x;
  float y;
  float z;
  
  float pz;

  Star() {
    x = random(-width / 2, width / 2);
    y = random(-height / 2, height / 2);
    z = random(width / 2);
    
    pz = z;
  }

  public void show() {
    fill(255);
    noStroke();
    
    float sx = map(x / z, 0, 1, 0, width / 2);
    float sy = map(y / z, 0, 1, 0, height / 2);
    float r = map(z, 0, width / 2, 10, 0);
    
    ellipse(sx, sy, r, r);
    
    float px = map(x / pz, 0, 1, 0, width / 2);
    float py = map(y / pz, 0, 1, 0, height / 2); 

    pz = z;
    
    stroke(255);
    line(px, py, sx, sy);
  }

  public void update()
  {
    z -= speed;
    
    if (z <= 0) {
      z = width / 2;
      x = random(-width / 2, width / 2);
      y = random(-height / 2, height / 2);
      pz = z;
    }
  }
}
