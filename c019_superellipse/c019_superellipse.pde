void setup() {
  size(400, 400);
}

float n = 1;

void draw() {
  background(51);

  translate(width / 2, height / 2);
  stroke(255);
  noFill();
  
  float steps = 150;
  float a = 100;
  float b = 100;
  
  beginShape();
  for (float i=0 ; i<steps ; i++) {
    float theta = i * TWO_PI / steps;
    
    float x = pow(abs(cos(theta)), 2 / n) * a * sgn(cos(theta));
    float y = pow(abs(sin(theta)), 2 / n) * b * sgn(sin(theta));
    
    vertex(x, y);
  }
  endShape(CLOSE);
}

float sgn(float t) {
  if (t < 0) return -1;
  else if (t == 0) return 0;
  else return 1;
}

void mouseWheel(MouseEvent event) {
  n += event.getCount() * 0.05 * n;
  n = constrain(n, 0.02, 100);
}
