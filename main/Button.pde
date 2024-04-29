class Button {
  float x, y;
  float width, height;
  String label;
  int textSize;
  int backgroundcolour = 150;
  int textcolour = 0;
  int hoverbackgroundcolour = 200;
  int hovertextcolour = 100;
  boolean playsound = true;

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
      if (playsound) {
        selectSound.play();
        playsound = false;
      }
    } else {
      playsound = true;
    }  
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

  protected boolean hover() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }

  boolean clicked() {
    clickSound.play();
    return hover();
  }
}


class Block extends Button {
  int [] rgb;
  // int padding = 0;
  // int margin = 0;
  // You can freely set the response range and boundaries by calling padding and margin by overloading hover()

  Block(float x, float y, float width, float height, int [] rgb) {
    super(x, y, width, height, "", 0);

    if (rgb.length != 3) {
      throw new IllegalArgumentException("RGB array must have exactly three elements.");
    }
    this.rgb = rgb;
  }

  @Override
  void display() {
    if (hover()) {
      fill(this.hoverbackgroundcolour);
      rect(x, y, width, height);
    }
    fill(rgb[0], rgb[1], rgb[2]); // color
    rect(x + width/4, y + height/4, width/2, height/2);
  }
  
  @Override
  boolean clicked() {
    return hover();
  }
}


class PauseButton extends Button {
  boolean isOn = false;  // = is paused
  int [] rgb = {135, 206, 250};
  int [] rgb_hover = {105, 196, 250};

  PauseButton(float x, float y, float width, float height) {
    super(x, y, width, height, "", 0);
  }

  @Override
  void display() {
    fill(rgb[0], rgb[1], rgb[2]); // color
    if (hover()) {
      if (playsound) {
        selectSound.play();
        playsound = false;
      }
    } else {
      playsound = true;
    }
    if (hover()) {
      fill(rgb_hover[0], rgb_hover[1], rgb_hover[2]);
    }
    rect(x , y , width, height);
    // x=1550 y=10 width=height=80
    fill(255);
    if(isOn) {
      triangle(x+width*2/8, y+height/16*3, x+width*2/8, y+height/16*3 + height/5*3, x+width*4/5, y+height/2);
    } else {
      rect(x+width/5, y+height/16*3, height/5, height*3/5);
      rect(x+width*3/5, y+height/16*3, height/5, height*3/5);
    }
  }

  @Override
  boolean clicked() {
    clickSound.play();
    boolean ishover = hover();
    if(ishover){
      this.isOn = !this.isOn;
    }
    return ishover;
  }
}

class SpeedUpButton extends Button {
  boolean isOn = false;
  SpeedUpButton(float x, float y, float width, float height, String label, int textSize) {
    super(x, y, width, height, "", 0);
  }

    @Override
  boolean clicked() {
    clickSound.play();
    boolean ishover = hover();
    if(ishover){
      this.isOn = !this.isOn;
    }
    return ishover;
  }

  // @Override
  // void display() {
  //   if (hover()) {
  //     if (playsound) {
  //       selectSound.play();
  //       playsound = false;
  //     }
  //   } else {
  //     playsound = true;
  //   }  
  //   if (hover()) {
  //     fill(hoverbackgroundcolour); // color
  //     rect(x, y, width, height, 10);
  //     fill(hovertextcolour); // text color
  //     textSize(this.textSize);
  //     textAlign(CENTER, CENTER);
  //     text(label, x + width / 2, y + height / 2);
  //     return;
  //   }
  //   if (isOn) {
  //     fill(150); // color
  //     rect(x, y, width, height, 10);
  //     fill(hovertextcolour); // text color
  //     textSize(this.textSize);
  //     textAlign(CENTER, CENTER);
  //     text(label, x + width / 2, y + height / 2);
  //     return;
  //   }
  //   fill(backgroundcolour); // color
  //   rect(x, y, width, height, 10);
  //   fill(textcolour); // text color
  //   textSize(this.textSize);
  //   textAlign(CENTER, CENTER);
  //   text(label, x + width / 2, y + height / 2);
  // }
}
