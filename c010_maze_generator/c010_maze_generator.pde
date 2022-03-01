import java.util.Stack;

float w;
float h;
static int rows = 20;
static int cols = 20;

Cell[] cells;
Stack<Cell> stack;
Cell currentCell;

void setup() {
  size(400, 400);
  
  w = (float)width / cols;
  h = (float)height / rows;
  
  createCells();
  
  stack = new Stack<Cell>();
  chooseFirstCell();
}

void draw() {
  background(0);
  
  showCells();
  markStackCells();
  highligthCurrentCell();
  
  dfs();
}

void createCells() {
  cells = new Cell[rows * cols];
  
  for (int i=0 ; i<rows ; i++) {
    for (int j=0 ; j<cols ; j++){
      cells[i * rows + j] = new Cell(i, j);
    }
  }
}

void chooseFirstCell() {
  // Choose an initial cell, Mark it as visited and push it to the stack
  int index = floor(random(rows * cols));
  Cell firstCell = cells[index];
  
  firstCell.markAsVisited();
  stack.push(firstCell);
}

void dfs() {
  // While the stack is not empty
  if(!stack.isEmpty()) {
    // Pop a cell and mark it as the current cell
    currentCell = stack.pop();
    
    // If the current cell has any unvisited neighbors
    ArrayList<Cell> neighbors = currentCell.getUnvisitedNeighbors(cells);
    if (neighbors.size() == 0)
      return;
    
    // Push the current cell to the stack
    stack.push(currentCell);
    
    // Choose one of the unvisited neighbors
    Cell neighbor = neighbors.get(floor(random(neighbors.size())));
    
    // Remove the wall between the current cell and the chosen cell
    neighbor.removeWall(currentCell);
    currentCell.removeWall(neighbor);
    
    // Mark the chosen cell as visited and push it to the stack 
    neighbor.markAsVisited();
    stack.push(neighbor);
  }
}

void showCells() {
  for (Cell cell : cells) {
    if (cell.isVisited())
      cell.drawBackground(new PVector(122, 52, 201));
      
    cell.drawWalls();
  }
}

void markStackCells() {
  float prevX = -1;
  float prevY = -1;
  
  for (Cell cell : stack) {
    float x = w * (cell.j + 0.5);
    float y = h * (cell.i + 0.5);
    
    fill(255);
    ellipse(x, y, w/3, h/3);
    
    if (prevX != -1 && prevY != -1) {
      line(x, y, prevX, prevY);
    }
    
    prevX = x;
    prevY = y;
  }
}

void highligthCurrentCell() {
  if (currentCell != null)
    currentCell.drawBackground(new PVector(0, 255, 0));
}
