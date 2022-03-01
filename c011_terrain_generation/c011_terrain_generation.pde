int rows;
int cols;
float scale = 20;

float terrainW = 1200;
float terrainH = 1200;

float [][] terrain;

void setup()  {
  size(600, 600, P3D);
  
  cols = int(terrainW / scale);
  rows = int(terrainH / scale);
}

float offset = 0;

void draw() {
  background(0);
  
  offset -= 0.1;
  
  terrain = new float[rows][cols];
  for (int i=0 ; i < rows ; i++) {
    for (int j=0 ; j < cols ; j++) {
      terrain[i][j] = map(noise(j * 0.2, offset + i * 0.2), 0, 1, -60, 60); 
    }
  }
  
  stroke(255);
  noFill();
  
  translate(width / 2, height / 2);
  rotateX(PI / 3);
  translate(-terrainW / 2, -terrainH / 2);
  
  for (int i=0 ; i < rows-1 ; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j=0 ; j < cols ; j++) {
      vertex(j * scale, i * scale, terrain[i][j]);
      vertex(j * scale, (i + 1) * scale, terrain[i+1][j]);
    }
    endShape();
  }
}
