class Cell {
  float a;
  float b;
  float da = 1.0;
  float db = 0.5;
  float f = 0.055;
  float k = 0.062;
  float dt = 1.0;
  
  int i;
  int j;
  
  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    
    a = 1;
    b = 0;
  }
  
  public void show() {
    noStroke();
    
    int c = floor((a - b) * 255);
    c = constrain(c, 0, 255);
    
    fill(c);
    rect(j * scale, i * scale, scale, scale); 
  }
  
  public float[] getNextValues() {
    float[] laplaceVals = laplace();
    
    float nextA = a + dt * (
      (da * laplaceVals[0]) -
      (a * b * b) +
      (f * (1 - a)));
      
    float nextB = b + dt * ( 
      (db * laplaceVals[1]) +
      (a * b * b) - 
      ((k + f) * b));
    
    return new float[] {nextA, nextB};
  }
  
  public float[] laplace() {
    float sumA = 0;
    float sumB = 0;
    
    for (int y=i-1 ; y<i+1 ; y++) {
      if (y < 0 || y >= rows)
        continue;
        
      for (int x=j-1 ; x<j+1 ; x++) {
        if (x < 0 || x >= cols)
          continue;
        
        int iDiff = abs(i - y);
        int jDiff = abs(j - x);
        
        float adjustedA = grid[y][x].a;
        float adjustedB = grid[y][x].b;
        
        switch (iDiff + jDiff) {
          case 0:
            adjustedA *= -1;
            adjustedB *= -1;
            //println("zero");
            break;
          case 1:
            adjustedA *= 0.2;
            adjustedB *= 0.2;
            //println("one");
            break;
          case 2:
            adjustedA *= 0.05;
            adjustedB *= 0.05;
            //println("two");
            break;
        }
        
        sumA += adjustedA;
        sumB += adjustedB;
      }
    }
    
    return new float[] {sumA, sumB};
  }
}
