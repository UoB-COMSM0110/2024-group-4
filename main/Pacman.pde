final int[] PACMAN_HOME = {14, 23};

// Pacman-specific states
final int EFFICIENT_EVADE = 6;
final int CHASE_DOT = 7;

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
  
  
  // Update position in the map
  @Override
  void update() {
    if (reachedNext) {
      reachedNext = false;
      if ( state == EVADE || state == EFFICIENT_EVADE ) {
        if ( isPortal() ) { // Assuming all non-temporary portals teleport to opposite side of map, but same row
          if ( this.col == 1 ) {
            this.col = 26;
            this.x = (26 * map.cellSize);
          } else if ( this.col == 26 ) {
            this.col = 1;
            this.x = (1 * map.cellSize);
          }
        }
        else if ( state == EFFICIENT_EVADE ) {
          if ( !dotsInRange() ) {
            Node targetNode = getRandomDot();
            this.targetRow = targetNode.y;
            this.targetCol = targetNode.x;
            this.setState(CHASE);
          }
          else {
            randomEfficientMove();
          }
        }
        else {
          randomMove();
        }
      }

      if ( state == CHASE || state == SCATTER ) {

        int nextCol;
        int nextRow;

        pf.setGrid(this.col, this.row, this.targetCol, this.targetRow);

        if ( pf.traverse() ) {
          nextCol = pf.optimalPath.get(0).x;
          nextRow = pf.optimalPath.get(0).y;

          setDirection(getOptimalDirection(nextCol, nextRow));
        } else {
          randomMove();
        }
      }
      
      if ( state == CHASE_DOT ) {
        
        pf.setGridBFS(this.col, this.row);
        
        if ( pf.traverseBFS() ) {
          int nextCol = pf.optimalBFS.get(0).x;
          int nextRow = pf.optimalBFS.get(0).y;
          
          setDirection(getOptimalDirection(nextCol, nextRow));
        }
        else {
          randomEfficientMove();
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
  
  
  // Checks if any dots within 10 tiles of pacman
  boolean dotsInRange() {
    
    for ( int r = this.row - 5; r < this.row + 5; r++ ) {
      for ( int c = this.col - 5; c < this.col + 5; c++ ) {
        if ( this.map.checkMove(c, r) && this.map.checkDot(c, r) ) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  
  // Returns random-ish dot on map
  Node getRandomDot() {
    
    Node n = new Node(-1, -1);
    
    for ( int r = 0; r < this.map.map.length; r++ ) {
      for ( int c = 0; c < this.map.map[0].length; c++ ) {
        if ( this.map.checkDot(c, r) ) {
          n.x = c;
          n.y = r;
          return n;
        }
      }
    }
    
    return n;
  }
  
  
  // Sets a random direction for Entity to move towards
  void randomEfficientMove() {
    if ( checkCollision(this.direction) ) {
      changeDirection(this.direction);
    } else if ( perpendicularValid(this.direction) ) {
      if ( !dotsAhead() ) {
        changeDirection(this.direction); // Only change direction if no dots ahead of pacman
      }
    }
  }
  
  
  // Check if there are dots ahead of pacman
  boolean dotsAhead() {
    
    int tempRow = this.row;
    int tempCol = this.col;
    
    switch ( this.direction ) {
      
      case UP:
        while ( this.map.checkMove(tempCol, tempRow) ) {
          if ( this.map.checkDot(tempCol, tempRow) ) {
            return true;
          }
          tempRow -= 1;
        }
        return false;
        
      case RIGHT:
        while ( this.map.checkMove(tempCol, tempRow) ) {
          if ( this.map.checkDot(tempCol, tempRow) ) {
            return true;
          }
          tempCol += 1;
        }
        return false;
      
      case DOWN:
        while ( this.map.checkMove(tempCol, tempRow) ) {
          if ( this.map.checkDot(tempCol, tempRow) ) {
            return true;
          }
          tempCol += 1;
        }
        return false;
      
      default:
        while ( this.map.checkMove(tempCol, tempRow) ) {
          if ( this.map.checkDot(tempCol, tempRow) ) {
            return true;
          }
          tempCol -= 1;
        }
        return false;     
    }
  }
  
}
