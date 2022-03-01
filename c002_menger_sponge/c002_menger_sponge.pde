Box firstBox;
ArrayList<Box> sponge;

float xRotation = 0;
float yRotation = 0;

void setup() {
  size(400, 400, P3D);
  firstBox = new Box(0, 0, 0, 200);
  sponge = new ArrayList<Box>();
  sponge.add(firstBox);
}

void draw() {
  xRotation = map(mouseX, width, 0, 0, PI);
  yRotation = map(mouseY, height, 0, 0, PI);
  
  background(0);
  stroke(255);
  noFill();
  lights();
  
  translate(width/2, height/2);
  rotateX(yRotation);
  rotateZ(xRotation);
  
  for (Box box : sponge) {
    box.show();
  }
}

void mousePressed() {
  ArrayList<Box> next = new ArrayList<Box>();
  
  for (Box b : sponge) {
    next.addAll(b.generate());
  }
  
  sponge = next;
}
