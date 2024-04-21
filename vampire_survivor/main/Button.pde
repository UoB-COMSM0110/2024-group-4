class Button {
  float x, y;
  float width, height;
  String label;
  int textSize;
  int backgroundcolour = 150;
  int textcolour = 0;
  int hoverbackgroundcolour = 200;
  int hovertextcolour = 100;

  Button(float x, float y, float width, float height, String label, int textSize) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.textSize = textSize;
  }

  void display() {
    if (hover()) {
      fill(hoverbackgroundcolour); // color
      rect(x, y, width, height, 10);
      fill(hovertextcolour); // text color
      textSize(this.textSize);
      textAlign(CENTER, CENTER);
      text(label, x + width / 2, y + height / 2);
      return;
    }
    fill(backgroundcolour); // color
    rect(x, y, width, height, 10);
    fill(textcolour); // text color
    textSize(this.textSize);
    textAlign(CENTER, CENTER);
    text(label, x + width / 2, y + height / 2);
  }

  private boolean hover() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }

  boolean clicked() {
    return hover();
  }
}
