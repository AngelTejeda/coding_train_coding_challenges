class Food {
  int x;
  int y;
  
  Food() {
    locate();
  }
  
  void show() {
    fill(255, 0, 100);
    rect(x * cellW, y * cellH, cellW, cellH);
  }
  
  void locate() {
    x = floor(random(cols));
    y = floor(random(rows));
  }
}
