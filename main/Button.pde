class Button {
    float x, y;
    float width, height;
    String label;
    int textSize;
    int backgroundcolour = 150;
    int textcolour = 0;

    Button(float x, float y, float width, float height, String label, int textSize) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.label = label;
        this.textSize = textSize;
    }

    void display() {
        fill(backgroundcolour); // color
        rect(x, y, width, height, 10);
        fill(textcolour); // text color
        textSize(this.textSize);
        textAlign(CENTER, CENTER);
        text(label, x + width / 2, y + height / 2);
    }

    boolean clicked(float mx, float my) {
        return mx >= x && mx <= x + width && my >= y && my <= y + height;
    }

    void backgroundcolour(int backgroundcolour) {
        this.backgroundcolour = backgroundcolour;
    }

    void textcolour(int textcolour) {
        this.textcolour = textcolour;
    }
}