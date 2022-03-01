import java.util.Arrays;

class Cell {
  public int i;
  public int j;
  private boolean[] walls;
  private boolean visited;
  
  Cell(int i, int j) {
    this.i = i;
    this.j = j;
    
    // Top, Right, Bottom, Left
    walls = new boolean[] {true, true, true, true};
    visited = false;
  }
  
  public void drawBackground(PVector c) {
    noStroke();
    fill(c.x, c.y, c.z);
    rect(j * w, i * h, w, h);
  }
  
  public void drawWalls() {
    float x = j * w;
    float y = i * h;
    
    stroke(255);
    if (walls[0]) line(x    , y,     x + w, y);
    if (walls[1]) line(x + w, y,     x + w, y + h);
    if (walls[2]) line(x,     y + h, x + w, y + h);
    if (walls[3]) line(x    , y,     x    , y + h);
  }
  
  public void markAsVisited() {
    visited = true;
  }
  
  public boolean isVisited() {
    return visited;
  }
  
  public int getIndex(int row, int col) {
    if (row < 0 || col < 0 || row >= rows || col >= cols)
      return -1;
      
    return row * cols + col;
  }
  
  public ArrayList<Cell> getUnvisitedNeighbors(Cell[] grid) {
    ArrayList<Cell> neighbors = new ArrayList<Cell>();
    
    int[] indexes = new int[4];
    
    indexes[0] = getIndex(i + 1, j);
    indexes[1] = getIndex(i    , j + 1);
    indexes[2] = getIndex(i - 1, j);
    indexes[3] = getIndex(i    , j - 1);
    
    for (int index : indexes) {
      if (index == -1)
        continue;
      
      Cell cell = grid[index];
      if (!cell.isVisited())
        neighbors.add(cell);
    }
    
    return neighbors;
  }
  
  public void removeWall(Cell neighbor) {
    int iDiff = neighbor.i - i;
    int jDiff = neighbor.j - j;
    
    // Check if they are neighbors
    if (abs(iDiff) + abs(jDiff) != 1)
      return;
    
    // Top
    if (iDiff == -1)
      walls[0] = false;
    // Right
    else if(jDiff == 1)
      walls[1] = false;
    // Bottom
    else if(iDiff == 1)
      walls[2] = false;
    // Left
    else
      walls[3] = false; 
  }
  
  public boolean isNeighbor(Cell cell) {
    return abs((cell.i + cell.j) - (i + j)) == 1;
  }
}
