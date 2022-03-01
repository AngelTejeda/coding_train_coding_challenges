int rows;
int cols;
float scale = 1;

Cell[][] grid;
Cell[][] next;


void setup() {
  size(300, 300);
  //frameRate(1);
  
  rows = floor(height / scale);
  cols = floor(width / scale);
  
  grid = new Cell[rows][cols];
  next = new Cell[rows][cols];
  
  for (int i=0 ; i<rows ; i++) {
    for (int j=0 ; j<cols ; j++) {
      grid[i][j] = new Cell(i, j);
      next[i][j] = new Cell(i, j);
    }
  }
  
  int areaSize = 10;
  for (int i=floor((rows - areaSize)/2) ; i<floor((rows + areaSize)/2) ; i++) {
    for (int j=floor((cols - areaSize)/2) ; j<floor((cols + areaSize)/2) ; j++) {
      grid[i][j].b = 1;
    }
  }
  
  next = grid;
}

void draw() {
  background(51);
  
  for (int i=1 ; i<rows - 1 ; i++) {
    for (int j=1 ; j<cols - 1 ; j++) {
      float[] nextValues = grid[i][j].getNextValues();
      
      next[i][j].a = nextValues[0];
      next[i][j].b = nextValues[1];
      
      next[i][j].a = constrain(next[i][j].a, 0, 1);
      next[i][j].b = constrain(next[i][j].b, 0, 1);
      
      if (next[i][j].a > 1 || next[i][j].b > 1)
        println("a");
    }
  }
  
  for (Cell[] row : next) {
    for (Cell cell : row) {
      cell.show();
    }
  }
  
  Cell[][] temp = grid;
  grid = next;
  next = temp;
}
