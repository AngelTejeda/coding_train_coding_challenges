 
class BodyPart {
  int x;
  int y;
  
  BodyPart(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void show() {
    fill(255);
    rect(x * cellW, y * cellH, cellW, cellH);
  }
}
