final int UP = 1;
final int RIGHT = 2;
final int DOWN = 3;
final int LEFT = 4;

final int WIDTH = 40;
final int HEIGHT = 40;

final int EVADE = 0;
final int CHASE = 1;
final int SCATTER = 2;
final int TELEPORT = 3;
final int REAPPEAR = 4;
final int RETURN_HOME = 5;


class Entity {
  // Properties
  protected int x;
  protected int y;
  protected float true_x;
  protected float true_y;
  int col;
  int row;
  int targetCol;
  int targetRow;
  int interval;
  int lastUpdateTime;
  int animInterval;
  int lastAnimTime;

  int direction;
  float speed;
  boolean freeze;
  int state;
  boolean onScatterPath;

  Pathfinder pf;
  GameMap map;
  Entity target;

  protected boolean reachedNext = true;

  PImage[] frames;
  int frameIndex;
  int frameCount;

  // Constructor
  Entity(int startCol, int startRow, Pathfinder pf, GameMap map) {
    this.col = startCol;
    this.row = startRow;
    this.x = (startCol * map.cellSize);
    this.y = (startRow * map.cellSize);
    this.true_x = x;
    this.true_y = y;
    // this.speed = 2; // Speed must always be a factor of the cellSize, otherwise will get errors, i.e. 1, 2, 4, 5, 8...
    this.speed = 3;  // Number of grids/second   // Now you can set the speed to any number(int/float)
    this.freeze = false;
    this.pf = pf;
    this.map = map;
    this.interval = 5;  // 200 fps
    this.lastUpdateTime = 0;
  }


  void drawEntity() {
    fill(10, 245, 72);
    rect(x, y, WIDTH, HEIGHT);

    update();
  }


  // Getter for this.x and this.y
  int[] getPosition() {
    int[] pos = {this.x, this.y};
    return pos;
  }


  // Sets position of Entity on map
  void setPosition(int col, int row) {
    this.col = col;
    this.row = row;
    this.x = (col * cellSize);
    this.y = (row * cellSize);
    this.true_x = this.x;
    this.true_y = this.y;
    this.reachedNext = true;
  }


  // Current position getter
  // Returns Node to be passed to Pathfinder
  int[] getCurrentNode() {
    int[] node = {this.col, this.row};
    return node;
  }


  // Current direction getter
  int getCurrentDirection() {
    return direction;
  }


  // this.direction setter
  void setDirection(int direction) {
    this.direction = direction;
  }


  // this.state setter
  void setState(int state) {
    if ( this.state == SCATTER ) {
      this.onScatterPath = false;
    }
    this.state = state;
  }


  // this.target setter
  void setTarget(Entity target) {
    this.target = target;
  }


  // this.freeze setter
  void freeze(boolean bool) {
    this.freeze = bool;
  }


  // Update position in the map
  void update() {
    if (reachedNext) {
      reachedNext = false;
      if ( state == EVADE ) {
        if ( isPortal() ) { // Assuming all non-temporary portals teleport to opposite side of map, but same row
          if ( this.col == 1 ) {
            this.col = 26;
            this.x = (26 * map.cellSize);
          } else if ( this.col == 26 ) {
            this.col = 1;
            this.x = (1 * map.cellSize);
          }
        }
        randomMove();
      }

      if ( state == CHASE || state == SCATTER ) {

        int nextCol;
        int nextRow;

        pf.setGrid(col, row, this.targetCol, this.targetRow);

        if ( pf.traverse() ) {
          nextCol = pf.optimalPath.get(0).x;
          nextRow = pf.optimalPath.get(0).y;

          setDirection(getOptimalDirection(nextCol, nextRow));
        } else {
          randomMove();
        }
      }
    }

    if ( this.freeze ) {
      return;
    }

    int currentTime = millis();
    int times = (currentTime - lastUpdateTime) / interval;
    lastUpdateTime = currentTime;
    // Move
    true_x += (3-direction)%2 * speed * map.cellSize * interval * times / 1000.0;
    true_y += (direction-2)%2 * speed * map.cellSize * interval * times / 1000.0;
    x = round(true_x);
    y = round(true_y);
    // x += (3-direction)%2 * round(speed * map.cellSize * interval * times / 1000.0);
    // y += (direction-2)%2 * round(speed * map.cellSize * interval * times / 1000.0);
    reachedNext = abs(x - col * map.cellSize) >= map.cellSize || abs(y - row * map.cellSize) >= map.cellSize;
    // update tile
    if (reachedNext) {
      col += (3-direction)%2;
      row += (direction-2)%2;
      x = col * map.cellSize;
      y = row * map.cellSize;
      true_x = x;
      true_y = y;
    }
  }


  void changeSpeed(float newSpeed) {
    speed = newSpeed;
  }


  // Return true if next cell is non-traversable
  boolean checkCollision(int direction) {
    int nextCol = col;
    int nextRow = row;

    switch ( direction ) {
    case UP:
      nextRow -= 1;
      break;
    case RIGHT:
      nextCol += 1;
      break;
    case DOWN:
      nextRow += 1;
      break;
    case LEFT:
      nextCol -= 1;
      break;
    default:
      println("ERROR: invalid direction code in Entity.update() - " + direction);
      break;
    }

    if ( map.checkMove(nextCol, nextRow) && !isGhostHome(nextRow, nextCol) ) {
      return false;
    }

    return true;
  }


  // Change Entity direction
  void changeDirection(int direction) {

    int dir;

    if ( onlyBackValid(direction) ) {
      switch ( direction ) {
      case UP:
        dir = DOWN;
        break;
      case RIGHT:
        dir = LEFT;
        break;
      case DOWN:
        dir = UP;
        break;
      default:
        dir = RIGHT;
        break;
      }
    } else {
      do {
        dir = (int) random(1, 5);
      } while ( checkCollision(dir) || abs(dir - direction) == 2 ); // i.e. cannot move into non-traversable tile or cannot go back the same way it came
    }

    this.direction = dir;
  }


  // Checks if only valid move is to go back
  boolean onlyBackValid(int direction) {
    switch ( direction ) {
    case UP:
      return ( checkCollision(UP) && checkCollision(LEFT) && checkCollision(RIGHT) );
    case RIGHT:
      return ( checkCollision(UP) && checkCollision(DOWN) && checkCollision(RIGHT) );
    case DOWN:
      return ( checkCollision(DOWN) && checkCollision(LEFT) && checkCollision(RIGHT) );
    default:
      return ( checkCollision(UP) && checkCollision(LEFT) && checkCollision(DOWN) );
    }
  }


  // Checks if perpendicular move is valid
  boolean perpendicularValid(int direction) {
    switch ( direction ) {
    case UP:
      return ( checkCollision(LEFT) || checkCollision(RIGHT) );
    case RIGHT:
      return ( checkCollision(UP) || checkCollision(DOWN) );
    case DOWN:
      return ( checkCollision(LEFT) || checkCollision(RIGHT) );
    default:
      return ( checkCollision(UP) || checkCollision(DOWN) );
    }
  }


  // Check if current tile is a portal
  boolean isPortal() {
    if ( map.map[this.row][this.col] == PORTAL ) {
      return true;
    }

    return false;
  }


  // Sets a random direction for Entity to move towards
  void randomMove() {
    if ( checkCollision(this.direction) ) {
      changeDirection(this.direction);
    } else if ( perpendicularValid(this.direction) ) {
      changeDirection(this.direction); // Translates to roughly 50% or 66% chance of switching directions
    }
  }


  // Returns which direction Entity should move according to A* algorithm
  int getOptimalDirection(int nextCol, int nextRow) {
    if ( nextCol == this.col + 1 ) {
      return RIGHT;
    } else if ( nextCol == this.col - 1 ) {
      return LEFT;
    } else if ( nextRow == this.row + 1 ) {
      return DOWN;
    } else if ( nextRow == this.row - 1 ) {
      return UP;
    } else {
      println("Error in Entity.getOptimalDirection()");
      return -1;
    }
  }


  // Check if Entity has reached target
  boolean caughtTarget() {
    int targetX = this.target.getPosition()[0];
    int targetY = this.target.getPosition()[1];

    if ( abs(this.x - targetX) < cellSize * 0.25 && abs(this.y - targetY) < cellSize * 0.25 ) { // Entity caught if within a quarter of a tile
      return true;
    }
    return false;
  }


  // Check if Entity is on target tile
  boolean reachedTargetTile() {
    return ( this.targetCol == this.col && this.targetRow == this.row );
  }


  // Check if tile is in ghost home
  boolean isGhostHome(int row, int col) {
    return ( row >= 12 && row <= 16 && col >= 10 && col <= 17 );
  }
}
