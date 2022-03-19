class Cell {
  float a;
  float b;
  
  int i;
  int j;
  
  static final float da = 1.0;
  static final float db = 0.5;
  static final float f = 0.055;
  static final float k = 0.062;
  static final float dt = 1.0;
  
  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    
    a = 1;
    b = 0;
  }
  
  public void show() {
    int pixel = i * width + j;
    color c = color(a * 125, b * 255, a * 255, 255); 
    
    pixels[pixel] = c; 
  }
  
  public float[] getNextValues() {
    float[] laplaceVals = laplace();
    
    float nextA =  a + dt * (
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
    
    for (int y=i-1 ; y<=i+1 ; y++) {
      // The cell is on the top or on the bottom of the screen
      if (y < 0 || y >= height)
        continue;
        
      for (int x=j-1 ; x<=j+1 ; x++) {
        // The cell is on the left or the right of the screen
        if (x < 0 || x >= width)
          continue;
        
        // If the sum of the absolute value of the difference in the x and y coordinates of
        // the cell and its neighbor is 1, the neighbor is adjacent, if its 2 its diagonal,
        // and if its 0, its the same cell.
        
        int iDiff = abs(i - y);
        int jDiff = abs(j - x);
        
        float adjustedA = grid[y][x].a;
        float adjustedB = grid[y][x].b;
        
        switch (iDiff + jDiff) {
          case 0:
            adjustedA *= -1;
            adjustedB *= -1;
            break;
          case 1:
            adjustedA *= 0.2;
            adjustedB *= 0.2;
            break;
          case 2:
            adjustedA *= 0.05;
            adjustedB *= 0.05;
            break;
        }
        
        sumA += adjustedA;
        sumB += adjustedB;
      }
    }
    
    return new float[] {sumA, sumB};
  }
}
