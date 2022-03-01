class Box {
  PVector pos;
  float size;
  
  Box(float x, float y, float z, float size) {
    pos = new PVector(x, y, z);
    this.size = size; 
  }
  
  void show() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(0);
    fill(255);
    box(size);
    popMatrix();
  }
  
  ArrayList<Box> generate() {
    ArrayList<Box> boxes = new ArrayList<Box>();
    
    for (int x=-1 ; x<2 ; x++) {
      for (int y=-1 ; y<2 ; y++) {
        for (int z=-1 ; z<2 ; z++) {
          float sum = abs(x) + abs(y) + abs(z);
          
          if (sum <= 1)
            continue;
          
          float newSize = size / 3;
          float newX = pos.x + x * newSize;
          float newY = pos.y + y * newSize;
          float newZ = pos.z + z * newSize;
          
          Box box = new Box(newX, newY, newZ, newSize);
          boxes.add(box);
        }
      }
    }
    
    return boxes;
  }
}
