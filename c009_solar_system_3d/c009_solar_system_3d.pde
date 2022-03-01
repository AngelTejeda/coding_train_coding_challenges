import peasy.*;

PeasyCam cam;
Planet sun;
PImage sunTexture;
PImage[] planetTextures;

int maxLevel = 3;
int maxMoons = 5;
boolean drawLines = false;

void setup() {
  size(700, 700, P3D);

  cam = new PeasyCam(this, 600);
  
  loadTextures();
  loadSun();
}

void draw() {
  background(0);
  lights();
  //pointLight(255, 255, 255, 0, 0, 0);
  
  sun.show();
  sun.orbit();
}

void loadTextures() {
  String[] textures = new String[] {"earth.jpg", "mars.jpg", "neptune.jpg", "jupiter.jpg", "venus.jpg"};
  
  sunTexture = loadImage("sun.jpg");
  planetTextures = new PImage[textures.length];
  
  for (int i=0 ; i<planetTextures.length ; i++) {
    planetTextures[i] = loadImage(textures[i]);
  }
}

void loadSun() {
  sun = new Planet(40, 0, sunTexture);
  sun.setTranslationVector(new PVector(0, 0, 0));
  sun.spawnMoons(5, 1);
}

PImage getRandomTexture() {
  int index = floor(random(planetTextures.length));
  return planetTextures[index];
}
