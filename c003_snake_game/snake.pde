class Snake {
  Directions direction;
  ArrayList<BodyPart> body;
  
  Snake() {
    reset();    
  }
  
  void reset() {
    direction = Directions.RIGHT;
    body = new ArrayList();
    body.add(new BodyPart(0, 0));
  }
  
  private int[] getNextCoords(int x, int y) {
    switch(direction) {
      case UP:
        y --;
        break;
      case RIGHT:
        x ++;
        break;
      case DOWN:
        y ++;
        break;
      case LEFT:
        x --;
        break;
    }
    
    return new int[]{x, y};
  }
  
  private boolean collides(int x, int y) {
    // Collision with walls
    if (x < 0 || x >= cols || y < 0 || y >= rows)
      return true;
    
    // Collision with body
    for (int i=body.size()-1 ; i>=0 ; i--) {
      BodyPart bodyPart = body.get(i);
      
      if (bodyPart.x == x && bodyPart.y == y)
        return true;
    }
    
    return false;
  } 
  
  void update(Food food) {
    BodyPart head = body.get(body.size() - 1);
    int[] newValues = getNextCoords(head.x, head.y);
    int newX = newValues[0];
    int newY = newValues[1];
    
    if (collides(newX, newY)) {
      reset();
      return;
    }
      
      
    if (head.x == food.x && head.y == food.y) {
      BodyPart newHead = new BodyPart(newX, newY);
      body.add(newHead);
      
      food.locate();
    }
    else {
      for (int i=0 ; i<=body.size()-2 ; i++) {
        BodyPart current = body.get(i);
        BodyPart next = body.get(i + 1);
        
        current.x = next.x;
        current.y = next.y;
      }
      
      head.x = newX;
      head.y = newY;
    }
  }
  
  void show() {
    for (BodyPart bodyPart : body) {
      bodyPart.show();
    }
  }
  
  void changeDirection(Directions newDirection) {
    if (newDirection != getOpossiteDirection(direction))
      direction = newDirection;
  }
  
  private Directions getOpossiteDirection(Directions direction) {
    switch(direction) {
      case UP: return Directions.DOWN;
      case RIGHT: return Directions.LEFT;
      case DOWN: return Directions.UP;
      case LEFT: return Directions.RIGHT;
      default: return null;
    }
  }
}
