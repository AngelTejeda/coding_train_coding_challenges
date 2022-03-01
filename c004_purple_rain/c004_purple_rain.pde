Drop[] rain = new Drop[500];
SplashDrop[] drops = new SplashDrop[20];

void setup() {
  size(640, 360);
  
  for (int i=0 ; i<rain.length ; i++) {
    rain[i] = new Drop();
  }
  
  for (int i=0 ; i<drops.length ; i++) {
    drops[i] = new SplashDrop(width/2, 2, 2);
  }
}

void draw() {
  background(230, 230, 250);
  rain();
  
}

void rain() {
  for (Drop drop : rain) {
    drop.update();
    drop.show();
  }
}

void splash() {
  for (SplashDrop drop : drops) {
    drop.update();
    drop.show();
  }
}
