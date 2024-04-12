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
            hoverdisplay();
            return;
        }
        fill(backgroundcolour); // color
        rect(x, y, width, height, 10);
        fill(textcolour); // text color
        textSize(this.textSize);
        textAlign(CENTER, CENTER);
        text(label, x + width / 2, y + height / 2);
    }

    boolean hover() {
        return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
    }

    void hoverdisplay() {
        fill(hoverbackgroundcolour); // color
        rect(x, y, width, height, 10);
        fill(hovertextcolour); // text color
        textSize(this.textSize);
        textAlign(CENTER, CENTER);
        text(label, x + width / 2, y + height / 2);
    }

    boolean clicked() {
        return hover();
    }
}

class ImageButton extends Button {
    PImage img;

    ImageButton(float x, float y, float width, float height, PImage img) {
        super(x, y, width, height, "", 0);
        this.img = img;
    }

    @Override
    void display() {
        if (hover()) {
            hoverdisplay();
        } else {
            fill(backgroundcolour);
        }
        rect(x, y, width, height, 10);

        imageMode(CENTER);
        image(img, x + width / 2, y + height / 2, width, height);
    }

    @Override
    void hoverdisplay() {
        fill(hoverbackgroundcolour);
    }
}