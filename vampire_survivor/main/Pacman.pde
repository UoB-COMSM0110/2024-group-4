final int[] PACMAN_HOME = {14, 23};

class Pacman extends Entity {

  int lives;
  int totalDotsEaten;
  int currentDotsEaten;

  int offsetX;
  int offsetY;
  int currentFrame;
  int totalFrames;
  int frameCell;
  int spriteRow;
  int hold;
  int delay;

  // Constructor
  Pacman(int startCol, int startRow, Pathfinder pf, GameMap map) {
    super(startCol, startRow, pf, map);

    this.lives = 3;
    this.totalDotsEaten = 0;
    this.currentDotsEaten = 0;

    this.currentFrame = 0;
    this.totalFrames = 2;
    this.hold = 0;
    this.delay = 8;
  }


  // Draw Pacman
  void draw() {

    this.frameCell = currentFrame * cellSize;

    switch ( this.direction ) {
    case UP:
      this.offsetX = 16 + frameCell;
      this.offsetY = 285;
      break;
    case RIGHT:
      this.offsetX = 16 + frameCell;
      this.offsetY = 205;
      break;
    case DOWN:
      this.offsetX = 16 + frameCell;
      this.offsetY = 325;
      break;
    case LEFT:
      this.offsetX = 16 + frameCell;
      this.offsetY = 245;
      break;
    default:
      println("Error in Pacman.draw()");
      break;
    }

    // Animate sprite
    this.hold = ( this.hold + 1 ) % this.delay;
    if ( hold == 0 ) {
      this.currentFrame = ( this.currentFrame + 1 ) % this.totalFrames;
    }

    // Draw sprite
    fill(0, 0, 0, 0);
    rect(x, y, WIDTH, HEIGHT);
    copy(sprites, offsetX, offsetY, WIDTH, HEIGHT, x, y, WIDTH, HEIGHT);

    // Eat dot
    if ( ( x == this.col * map.cellSize ) && ( y == this.row * map.cellSize ) ) {
      if (map.checkDot(this.col, this.row)) {
        map.eatDot(this.col, this.row);
        this.currentDotsEaten++;
        this.totalDotsEaten++;
      } else if (map.checkBigDot(this.row, this.col)) {
        map.eatBigDot(this.row, this.col);
        this.lives++;
        this.currentDotsEaten++;
        this.totalDotsEaten++;
      }
    }

    // Move pacman
    if ( !map.checkPause() ) {
      update();
    }
  }
}
