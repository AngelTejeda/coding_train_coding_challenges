float n1 = 1;
float n2 = 1;
float n3 = 1;
float a = 1;
float b = 1;
float m = 5;
float radius = 100;

float steps = 500;
float increment = TWO_PI / steps;

NumberInput n1Button;
NumberInput n2Button;
NumberInput n3Button;
NumberInput aButton;
NumberInput bButton;
NumberInput mButton;
NumberInput radiusButton;

TextHelper th;

NumberInput[] buttons;

void setup() {
  size(700, 600);
  
  float leftMargin = 25;
  float base = 10;
  float buttonSize = 20;
  float inputSize = (buttonSize * 2) + (buttonSize / 4) + (buttonSize * 2);
  
  float n1Increment = 0.1;
  float n2Increment = 0.1;
  float n3Increment = 0.1;
  float aIncrement = 0.1;
  float bIncrement = 0.1;
  float mIncrement = 0.1;
  float radiusIncrement = 1;
  
  n1Button = new NumberInput(new PVector(leftMargin, base + inputSize * 0), buttonSize, "n1", n1Increment);
  n2Button = new NumberInput(new PVector(leftMargin, base + inputSize * 1), buttonSize, "n2", n2Increment);
  n3Button = new NumberInput(new PVector(leftMargin, base + inputSize * 2), buttonSize, "n3", n3Increment);
  aButton = new NumberInput(new PVector(leftMargin, base + inputSize * 3), buttonSize, "a", aIncrement);
  bButton = new NumberInput(new PVector(leftMargin, base + inputSize * 4), buttonSize, "b", bIncrement);
  mButton = new NumberInput(new PVector(leftMargin, base + inputSize * 5), buttonSize, "m", mIncrement);
  radiusButton = new NumberInput(new PVector(leftMargin, base + inputSize * 6), buttonSize, "radius", radiusIncrement);
  
  buttons = new NumberInput[] { n1Button, n2Button, n3Button, aButton, bButton, mButton, radiusButton };
  
  n1Button.setValue(n1);
  n2Button.setValue(n2);
  n3Button.setValue(n3);
  aButton.setValue(a);
  bButton.setValue(b);
  mButton.setValue(m);
  radiusButton.setValue(radius);
  
  th = new TextHelper();
}


void draw() {
  background(230, 230, 250);
  
  for (NumberInput button : buttons) {
    button.show();
    button.update();
  }
  
  n1 = n1Button.getValue();
  n2 = n2Button.getValue();
  n3 = n3Button.getValue();
  a = aButton.getValue();
  b = bButton.getValue();
  m = mButton.getValue();
  radius = radiusButton.getValue();

  drawShape();
}

void drawShape() {
  translate(width / 2, height / 2);
  stroke(0);
  noFill();
  
  beginShape();
  for (float i=0 ; i<steps ; i++) {
    float theta = i * increment;
    
    float r = supershape(theta);
    
    float x = radius * r * cos(theta);
    float y = radius * r * sin(theta);
    
    vertex(x, y);
  }
  endShape(CLOSE);
}

float sgn(float t) {
  if (t < 0) return -1;
  else if (t == 0) return 0;
  else return 1;
}

float supershape(float phi) {
  float firstTerm = (1 / a) * cos(m / 4 * phi);
  firstTerm = pow(abs(firstTerm), n2);
  
  float secondTerm = (1 / b) * sin(m / 4 * phi);
  secondTerm = pow(abs(secondTerm), n3);

  return 1 / pow(firstTerm + secondTerm, 1 / n1);
}
