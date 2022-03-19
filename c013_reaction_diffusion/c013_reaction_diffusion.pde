Cell[][] grid;
Cell[][] next;

void setup() {
  size(200, 200);
  
  pixelDensity(1);
  
  grid = new Cell[height][width];
  next = new Cell[height][width];
  
  for (int i=0 ; i<height ; i++) {
    for (int j=0 ; j<width ; j++) {
      grid[i][j] = new Cell(i, j);
      next[i][j] = new Cell(i, j);
    }
  }
  
  int areaSize = 10;
  for (int i=floor((height - areaSize)/2) ; i<floor((height + areaSize)/2) ; i++) {
    for (int j=floor((width - areaSize)/2) ; j<floor((width + areaSize)/2) ; j++) {
      grid[i][j].b = 1;
    }
  }
}

void draw() {
  background(51);
  
  calculateNextValues();
  updateScreen();
  swap();
}

void calculateNextValues() {
  for (int i=0 ; i<height ; i++) {
    for (int j=0 ; j<width ; j++) {
      float[] nextValues = grid[i][j].getNextValues();
      
      float nextA = nextValues[0];
      float nextB = nextValues[1];
      
      next[i][j].a = nextA;
      next[i][j].b = nextB;
    }
  }
}

void updateScreen() {
  loadPixels();
  for (Cell[] row : next) {
    for (Cell cell : row) {
      cell.show();
    }
  }
  updatePixels();
}

void swap() {
  Cell[][] temp = grid;
  grid = next;
  next = temp;
}
