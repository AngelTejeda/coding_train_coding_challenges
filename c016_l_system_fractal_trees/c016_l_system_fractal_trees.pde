String axiom;

boolean showProcess = false;
boolean smooth = true;

HashMap<Character, String> rules;

Turtle turtle;

void setup() {
  size(700, 600);
  
  rules = new HashMap<Character, String>();
  rules.put('F', "FF+[+F-F-F]-[-F+F+F]");
  
  PVector initialPos = new PVector(width / 2, height);
  turtle = new Turtle(initialPos, generateInstructions(5));
  
  if (!showProcess) {
    while(turtle.isActive) {
      turtle.update();
    }
  }
}

void draw() {
  background(51);
  
  turtle.show();
  if (showProcess) {
    turtle.update();
  }
}

String generateInstructions(int iterations) {
  String instructions = "F";
  
  for (int i=0 ; i<iterations ; i++) {
    instructions = getNextSentence(instructions);
  }
  
  return instructions;
}

String getNextSentence(String sentence) {
  StringBuilder nextSentence = new StringBuilder();
  
  for (int i=0 ; i<sentence.length() ; i++) {
    Character c = sentence.charAt(i);
    String nextValue = rules.get(c);
    
    nextSentence.append(nextValue == null ? c : nextValue);
  }
  
  return nextSentence.toString();
}
