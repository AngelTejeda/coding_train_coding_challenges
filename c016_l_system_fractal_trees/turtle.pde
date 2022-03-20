import java.util.Stack;
import java.util.Arrays;

class Turtle {
  Stack<Triplet<PVector, PVector, Float>> checkpoints;  // currentPos, lastPos, angle
  ArrayList<Triplet<PVector, PVector, Integer>> points; // An array of points where the turtle has been. start, end, strokeWeight
  PVector currentPos;  // Position of the turtle
  PVector lastPoint;   // Last point were the turtle was
  PVector nextPoint;   // Next point were the turtle should be
  
  static final float speed = 5;     // Speed of the turtle when drawing
  PVector dir;  // Represents the direction the turtle is moving
  float angle;  // Angle of the turtle

  String instructions;   // Instructions to draw
  int instructionIndex;  // Current instruction
  
  boolean isActive;  // The turtle is still drawing
  
  public Turtle(PVector initialPos, String instructions) {
    checkpoints = new Stack();
    points = new ArrayList<Triplet<PVector, PVector, Integer>>();
    currentPos = cloneVector(initialPos);
    lastPoint = cloneVector(initialPos);
    
    this.instructions = instructions;
    instructionIndex = 0;
    
    angle = 0;
    
    isActive = true;
  }
  
  private PVector cloneVector(PVector v) {
    return new PVector(v.x, v.y);
  }
  
  // ================= //
  // ==== Display ==== //
  // ================= //
  
  public void show() {
    if (showProcess) {
      showTurtle();
    }
    showPath();
  }
  
  private void showTurtle() {
    noStroke();
    fill(0, 255, 0);
    
    circle(currentPos.x, currentPos.y, 10);
  }
  
  private void showPath() {
    stroke(255);
    
    // Previous points
    int i = 0;
    for (Triplet<PVector, PVector, Integer> point : points) {
      PVector last = point.value1;
      PVector next = point.value2;
      
      float weight = map(i, 0, points.size(), maxBranchWidth, minBranchWidth);
      strokeWeight(weight);
      line(last.x, last.y, next.x, next.y);
      
      i++;
    }
    
    // From lastpoint to current point
    line(lastPoint.x, lastPoint.y, currentPos.x, currentPos.y);
  }
  
  // ============== //
  // ==== Draw ==== //
  // ============== //
  
  public void update() {
    if (instructionIndex >= instructions.length()) {
      isActive = false;
      return;
    }
    
    switch(instructions.charAt(instructionIndex)) {
      case 'F': move(); break;
      case '+': turn(PI / 6); break;
      case '-': turn(-PI / 6); break;
      case '[': saveCheckpoint(); break;
      case ']': loadCheckpoint(); break;
    }
  }
  
  // Moves the turtle to the next point
  public void move() {
    // If the turtle is on its not moving, this section calculates its next point
    if (!isMoving()) {
      float nextX = currentPos.x + branchLength * sin(angle);
      float nextY = currentPos.y - branchLength * cos(angle);
      
      nextPoint = new PVector(nextX, nextY);
      
      dir = PVector.sub(nextPoint, currentPos);
      dir.mult(speed / dir.mag());
    }
    
    // Move the turtle towards the next point
    if (smooth)
      currentPos.add(dir);
    else
      currentPos = nextPoint;
    
    // Check if the turtle has reached the next point
    if (hasReachedTarget()) {
      points.add(new Triplet(cloneVector(lastPoint), cloneVector(nextPoint), 1));
      
      lastPoint = currentPos;
      currentPos = nextPoint;
      nextPoint = null;
      dir = null;
      
      instructionIndex++;
    }
  }
  
  // Rotate the turtle a certain angle
  private void turn(float a) {
    angle += a;
    instructionIndex++;
  }
  
  // Save the current position of the turtle, its last point and its angle.
  private void saveCheckpoint() {
    PVector current = cloneVector(currentPos);
    PVector last = cloneVector(lastPoint);
    float a = angle;
    
    Triplet<PVector, PVector, Float> checkpoint = new Triplet(current, last, a);;
    checkpoints.push(checkpoint);
    
    instructionIndex++;
  }
  
  // Take the turtle to its last checkpoint
  private void loadCheckpoint() {
    Triplet<PVector, PVector, Float> checkpoint = checkpoints.pop();
    
    currentPos = checkpoint.value1;
    lastPoint = checkpoint.value2;
    angle = checkpoint.value3;
    
    instructionIndex++;
  }
  
  private boolean isMoving() {
    return nextPoint != null;
  }
  
  private boolean hasReachedTarget() {
    return currentPos.mag() > dir.mag();
  }
  
  
}
