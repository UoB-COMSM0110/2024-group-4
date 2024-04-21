abstract class Animation {
  PImage[] frames;
  int frameIndex;
  int frameCount;
  int x, y;
  int interval;
  int lastUpdateTime;

  Animation(int frameCount, int x, int y, int interval) {
    this.frames = new PImage[frameCount];
    this.frameCount = frameCount;
    this.frameIndex = 0;
    this.x = x;
    this.y = y;
    this.interval = interval;
    this.lastUpdateTime = 0;
  }

  abstract void loadFrames();

  void display() {
    int currentTime = millis();
    if (currentTime > lastUpdateTime + interval) {
      frameIndex = (frameIndex + 1) % frameCount;
      lastUpdateTime = currentTime;
    }
    image(frames[frameIndex], x, y);
  }
}

class AnimationPacman extends Animation {
  int width = 400;
  int height = 400;
  AnimationPacman(int x, int y, int interval) {
    super(2, x, y, interval);
    this.frames = new PImage[frameCount];

    for (int frameCell = 0; frameCell < frameCount; frameCell++) {
      frames[frameCell] = createImage(width, height, ARGB);
    }
    loadFrames();
  }

  @Override
    void loadFrames() {
    final int cellSize = 400;
    PImage sprites = loadImage("src/pacman10.png");
    for (int frameCell = 0; frameCell < frameCount; frameCell++) {
      // RIGHT
      int offsetX = frameCell * cellSize;
      int offsetY = 0;
      frames[frameCell].copy(sprites, offsetX, offsetY, width, height, 0, 0, width, height);
    }
  }
}

class AnimationGhosts extends Animation {
  int width = 500;
  int height = 520;
  AnimationGhosts(int x, int y, int interval) {
    super(2, x, y, interval);
    this.frames = new PImage[frameCount];

    for (int frameCell = 0; frameCell < frameCount; frameCell++) {
      frames[frameCell] = createImage(width, height, ARGB);
    }
    loadFrames();
  }

  @Override
    void loadFrames() {
    final int cellSize = 580;
    PImage sprites = loadImage("src/ghosts.png");
    for (int frameCell = 0; frameCell < frameCount; frameCell++) {
      // LEFT
      int offsetX = frameCell * cellSize;
      int offsetY = 0;
      frames[frameCell].copy(sprites, offsetX, offsetY, width, height, 0, 0, width, height);
    }
  }
}
