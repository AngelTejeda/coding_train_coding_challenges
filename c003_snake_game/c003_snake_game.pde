int cellW;
int cellH;
int rows = 20; 
int cols = 20;

Snake snake;
Food food;

enum Directions{
  UP,
  RIGHT,
  DOWN,
  LEFT
}

void setup() {
  size(400, 400);
  
  cellW = width / cols;
  cellH = height / rows;
  
  frameRate(10);
  
  snake = new Snake();
  food = new Food();
}

void draw() {  
  background(0);
  snake.update(food);
  snake.show();
  food.show();
}

void keyPressed() {
  if (!keyPressed)
    return;
    
  if (key != CODED)
    return;
  
  if (keyCode == UP)
    snake.changeDirection(Directions.UP);
  else if (keyCode == RIGHT)
    snake.changeDirection(Directions.RIGHT);
  else if (keyCode == DOWN)
    snake.changeDirection(Directions.DOWN);
  else if (keyCode == LEFT)
    snake.changeDirection(Directions.LEFT);
  else if (keyCode == SHIFT)
     return;
  else if (keyCode == CONTROL)
     snake.reset();
}
