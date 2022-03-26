class TextHelper {
  public void textWithBoxes(String string, PFont font, float x, float y) {
    float leftMost = Float.POSITIVE_INFINITY;
    float rightMost = Float.NEGATIVE_INFINITY;
    float topMost = Float.POSITIVE_INFINITY;
    float bottomMost = Float.NEGATIVE_INFINITY;
  
    textFont(font);
    text(string, x, y);
    
    noFill();
    for (Character c : string.toCharArray()) {
      if (c != ' ') {
        PFont.Glyph glyph = font.getGlyph(c);
  
        float left = x + glyph.leftExtent;
        float top = y - glyph.topExtent;
        
        float right = left + glyph.width;
        float bottom = top + glyph.height;
  
        leftMost = left < leftMost ? left : leftMost;
        topMost = top < topMost ? top : topMost;
        rightMost = right > rightMost ? right : rightMost;
        bottomMost = bottom > bottomMost ? bottom : bottomMost;
  
        rect(left, top, glyph.width, glyph.height);
      }
      x += textWidth(c);
    }
    rect(leftMost, topMost, rightMost - leftMost, bottomMost - topMost);
  }
  
  public float getWidth(String str, PFont font) {
    float leftMost = Float.POSITIVE_INFINITY;
    float rightMost = Float.NEGATIVE_INFINITY;
  
    //textFont(font);
    for (Character c : str.toCharArray()) {
      if (c != ' ') {
        PFont.Glyph glyph = font.getGlyph(c);
  
        float left = glyph.leftExtent;
        float right = left + glyph.width;
  
        leftMost = left < leftMost ? left : leftMost;
        rightMost = right > rightMost ? right : rightMost;
      }
    }
    
    return rightMost - leftMost;
  }
  
  public float getHeight(String str, PFont font) {
    float topMost = Float.POSITIVE_INFINITY;
    float bottomMost = Float.NEGATIVE_INFINITY;
  
    textFont(font);
    for (Character c : str.toCharArray()) {
      if (c != ' ') {
        PFont.Glyph glyph = font.getGlyph(c);
  
        float top = glyph.topExtent;
        float bottom = top + glyph.height;
  
        topMost = top < topMost ? top : topMost;
        bottomMost = bottom > bottomMost ? bottom : bottomMost;
      }
    }
    
    return bottomMost - topMost;
  }
}
