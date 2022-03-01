import java.util.Iterator;

ArrayList<Cell> cells;

void setup() {
  size(600, 600);
  //frameRate(1);
  
  cells = new ArrayList<Cell>();
  
  for (int i=0 ; i<10; i++) {
    cells.add(new Cell(random(width) - 40, random(height) - 40, random(20, 40), random(0, 2 * PI)));
  }
}

float a = 0;

void draw() {
  background(0);
  
  updateCells();
  
  stroke(255, 0, 100);
  strokeWeight(4);
  point(mouseX, mouseY);
  noStroke();
}

void mousePressed() {
  for (Cell cell : cells) {
    float distance = dist(mouseX, mouseY, cell.x, cell.y); 
    
    if (distance <= cell.r) {
      if (mouseButton == LEFT)
        cell.divide();
      break;
    }
  }
}

void updateCells() {
  Iterator<Cell> itr = cells.iterator();
  ArrayList<Cell> newCells = new ArrayList<Cell>();
  
  while(itr.hasNext()) {
    Cell cell = itr.next();
    
    if (!cell.isAlive) {
      newCells.addAll(cell.getNewCells());
      itr.remove();
      continue;
    }
    
    cell.show();
    cell.update();
  }
  
  cells.addAll(newCells);
}
