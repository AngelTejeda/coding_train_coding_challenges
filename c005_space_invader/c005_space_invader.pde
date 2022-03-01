import java.util.Iterator;
import java.util.List;

Ship ship;
ArrayList<Enemy> enemies;
int aliveEnemies;

float entitySize;
float enemySeparation = 0.3;  // Space between enemies expressed as a percentage of the entitySize.

float cols = 10;
float rows = 6;


void reset() {
  float shipY = (rows - 1) * (1 + enemySeparation) * entitySize;
  
  ship = new Ship(shipY, entitySize);
  enemies = new ArrayList<Enemy>();
  aliveEnemies = 0;
  
  spawnEnemies(3, 5);
}

// === Events === //

void setup() {
  size(300, 250);
  
  entitySize = height / (rows * (1 + enemySeparation));
  
  reset();
}

void draw() {
  background(0);
  
  updateShip();
  updateEnemies();
  checkProjectilesCollisions();
}

void keyReleased() {
  List<Character> movementKeys = List.of('a', 'A', 'd', 'D');
  
  if (movementKeys.contains(key)) {
    ship.setDir(0);
  }
}

void keyPressed() {
  if (key == 'a' || key == 'A')
    ship.setDir(-1);
  else if (key == 'd' || key == 'D')
    ship.setDir(1);
  
  if (key == ' ')
    ship.shoot();
}

// === Ship === //

void updateShip() {
  ship.update();
  checkShipCollisions();
  ship.show();
}

void checkShipCollisions() {
  for (Enemy enemy : enemies) {
    if (!enemy.isAlive)
      continue;
    
    if (ship.collides(enemy))
      reset();
  }
}

// === Enemies === //

void updateEnemies() {
  boolean collides = false;
  
  for (Enemy enemy : enemies) {
    enemy.move();
    enemy.show();
    
    if (enemy.collidesWithWall())
      collides = true;
  }
  
  if (collides) {
    for (Enemy enemy : enemies) {
      enemy.shiftDown();
    }
  }
}

void spawnEnemies(int enemyRows, int enemiesPerRow) {
  //float xDisplacement = 40;
  //int enemiesPerRow = floor((width - xDisplacement) / (entitySize + enemySeparation));
  
  for (int i=0 ; i<enemyRows ; i++){
    float y = i * (1 + enemySeparation) * entitySize;

    for (int j=0 ; j<enemiesPerRow ; j++) {
      float x = j * (1 + enemySeparation) * entitySize;
      
      enemies.add(new Enemy(x, y, entitySize, entitySize * enemySeparation));
    }
    
    aliveEnemies += enemiesPerRow;
  }
}

// === Projectiles === //

void checkProjectilesCollisions() {
  // For each projectile, check if it hits any of the alive enemies.
  
  for (Projectile projectile : ship.getProjectiles()) {
    for (Enemy enemy : enemies) {
      if (!enemy.isAlive) continue;
      
      if (projectile.hits(enemy)) {
        enemy.die();
        aliveEnemies--;
        break;
      }
    }
  }
  
  if (aliveEnemies == 0)
    reset();
}
