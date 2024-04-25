class Ghost extends Entity {

  Pacman pacman;

  int currentFrame;
  int totalFrames;
  int frameCell;
  int hold;
  int delay;

  int scatterCorner;
  int scatterTile;
  int[][][] scatterPaths;

  final int cellSize = 40;

  Ghost targetGhost;
  // Constructor
  Ghost(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map);

    this.pacman = pacman;

    this.currentFrame = 0;
    this.totalFrames = 2;
    this.hold = 0;
    this.delay = 4;
    this.animInterval = 60;
    this.lastAnimTime = 0;

    this.onScatterPath = false;

    final int frameCount = 8;
    this.frames = new PImage[frameCount];

    int baseoffsetX = 16;
    int offsetY = 530;
    for (int i=0; i<frameCount; i++) {
      this.frames[i] = createImage(WIDTH, HEIGHT, ARGB);
      this.frames[i].copy(sprites, baseoffsetX + cellSize*i, offsetY, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
  }


  // Set scatter path
  void setScatterPath(int[][][] path) {

    this.scatterPaths = path;
  }


  // Set scatter corner
  void setScatterCorner(int corner) {

    this.scatterCorner = corner;
  }


  // Set scatter target
  void setScatterParameters() {

    this.targetRow = this.scatterPaths[this.scatterCorner][this.scatterTile][0];
    this.targetCol = this.scatterPaths[this.scatterCorner][this.scatterTile][1];

    this.scatterTile++;
    if ( this.scatterTile == this.scatterPaths[this.scatterCorner].length ) {
      this.scatterTile = 0;
    }
  }


  // Set initial scatter parameters
  void initialiseScatter() {

    this.scatterTile = 0;
    this.onScatterPath = true;

    this.targetRow = this.scatterPaths[this.scatterCorner][this.scatterTile][0];
    this.targetCol = this.scatterPaths[this.scatterCorner][this.scatterTile][1];
  }


  // Set relative ghost
  void setGhost(Ghost ghost) {

    this.targetGhost = ghost;
  }


  // Draw Ghost
  void draw() {
    // Animate sprite
    int currentTime = millis();
    if (currentTime > lastAnimTime + animInterval) {
      currentFrame = ( currentFrame + 1 ) % totalFrames;
      lastAnimTime = currentTime;
    }

    // Draw sprite
    int i = direction-2+5*(direction%2) + currentFrame;
    fill(0, 0, 0, 0);
    rect(x, y, WIDTH, HEIGHT);
    copy(frames[i], 0, 0, WIDTH, HEIGHT, x, y, WIDTH, HEIGHT);

    // Move sprite
    if ( state == SCATTER ) {
      if ( this.onScatterPath == false ) {
        initialiseScatter();
      }
      if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) && reachedTargetTile() ) {
        setScatterParameters();
      }
    } else {
      setTargetTile();
    }

    if ( !map.checkPause() ) {
      update();
    }
  }

  // Set target tile
  void setTargetTile() {
    this.targetCol = this.target.getCurrentNode()[0];
    this.targetRow = this.target.getCurrentNode()[1];
  }

  // Return Euclidian distance from target entity
  int getDistance() {

    int dX = abs(this.col - this.target.getCurrentNode()[0]);
    int dY = abs(this.row - this.target.getCurrentNode()[1]);

    return (int) sqrt( pow(dX, 2) + pow(dY, 2) );
  }
}


class Blinky extends Ghost {
  // Constructor
  Blinky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
  }
}


class Inky extends Ghost {

  Ghost targetGhost; // Uses relative position of a given ghost to calculate target tile


  // Constructor
  Inky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    final int frameCount = 8;
    int baseoffsetX = 16;
    int offsetY = 402;
    for (int i=0; i<frameCount; i++) {
      this.frames[i].copy(sprites, baseoffsetX + cellSize*i, offsetY, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
  }


  // Set relative ghost
  void setGhost(Ghost ghost) {

    this.targetGhost = ghost;
  }


  // Set target tile
  @Override
  void setTargetTile() {

    int tempCol = target.getCurrentNode()[0] + 2 * (3-target.direction)%2;
    int tempRow = target.getCurrentNode()[1] + 2 * (target.direction-2)%2;
    int totalDist;

    // 1 <= tempCol <= 26   1 <= tempRow <= 29
    targetCol = min(max(targetCol, 1), 26);
    targetRow = min(max(targetRow, 1), 29);

    int d = getDistance(tempCol, tempRow);
    int edgeDist = getShortestEdge(tempCol, tempRow);
    if ( d < edgeDist ) {
      totalDist = 2 * d;
    } else {
      totalDist = 2 * edgeDist;
    }

    int targetCol = targetGhost.getCurrentNode()[0] + ( (tempCol - targetGhost.getCurrentNode()[0] ) / d ) * totalDist;
    int targetRow = targetGhost.getCurrentNode()[1] + ( (tempRow - targetGhost.getCurrentNode()[1] ) / d ) * totalDist;

    this.targetCol = targetCol;
    this.targetRow = targetRow;
  }


  // Return the shortest distance to an edge
  int getShortestEdge(int tempCol, int tempRow) {

    int north = abs(tempRow - 1);
    int east = abs(tempCol - 26);
    int south = abs(tempRow - 29);
    int west = abs(tempCol - 1);

    int tempMin = min(north, south, east); // function only takes 3 values :/
    tempMin = min(tempMin, west);

    if ( tempMin == 0 ) {
      return 1;
    }
    return tempMin;
  }


  // Return Euclidian distance from target ghost
  int getDistance(int tempCol, int tempRow) {

    int dX = abs(tempCol - this.targetGhost.getCurrentNode()[0]);
    int dY = abs(tempRow - this.targetGhost.getCurrentNode()[1]);

    int d = (int) sqrt( pow(dX, 2) + pow(dY, 2) );

    if ( d == 0 ) {
      return 1;
    }
    return d;
  }
}


class Pinky extends Ghost {
  // Constructor
  Pinky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    final int frameCount = 8;
    int baseoffsetX = 16;
    int offsetY = 657;
    for (int i=0; i<frameCount; i++) {
      this.frames[i].copy(sprites, baseoffsetX + cellSize*i, offsetY, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
  }


  // Set target tile
  @Override
  void setTargetTile() {
    int targetCol = target.getCurrentNode()[0] + 4 * (3-target.direction)%2;
    int targetRow = target.getCurrentNode()[1] + 4 * (target.direction-2)%2;

    // 1 <= targetCol <= 26   1 <= targetRow <= 29
    this.targetCol = min(max(targetCol, 1), 26);
    this.targetRow = min(max(targetRow, 1), 29);
  }
}


class Clyde extends Ghost {
  // Constructor
  Clyde(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    final int frameCount = 8;
    int baseoffsetX = 16;
    int offsetY = 784;
    for (int i=0; i<frameCount; i++) {
      this.frames[i].copy(sprites, baseoffsetX + cellSize*i, offsetY, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
  }
}


class Sue extends Ghost {
  // Constructor
  Sue(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    final int frameCount = 8;
    int baseoffsetX = 732;
    int offsetY = 285;
    for (int i=0; i<frameCount; i++) {
      this.frames[i].copy(sprites, baseoffsetX + cellSize*i, offsetY, WIDTH, HEIGHT, 0, 0, WIDTH, HEIGHT);
    }
  }
}


class Funky extends Ghost {

  int offsetX;
  int offsetY;
  int offsetTele;
  int teleportCell;
  int teleportFrames;
  int teleHold;
  int teleDelay;


  // Constructor
  Funky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    this.offsetY = 365;
    this.teleportFrames = 4;
    this.teleDelay = 3;

    resetTeleport();
  }


  // Draw Ghost
  void draw() {

    this.frameCell = currentFrame * cellSize;

    if (this.state == TELEPORT) {

      this.teleHold = ( this.teleHold + 1 ) % this.teleDelay;
      if ( teleHold == 0 ) {
        this.teleportCell = ( this.teleportCell + 1 ) % this.teleportFrames;
      }
      this.offsetTele = 1065 + teleportCell * cellSize;

      fill(0, 0, 0, 0);
      rect(x, y, WIDTH, HEIGHT);
      copy(sprites, offsetTele, offsetY, WIDTH, HEIGHT, x, y, WIDTH, HEIGHT);

      if ( teleportCell == teleportFrames - 1 ) {
        teleport();
        //teleportSound.play();
        this.teleHold = 0;
        setState(REAPPEAR);
      }
    } else if ( this.state == REAPPEAR ) {

      this.teleHold = ( this.teleHold + 1 ) % this.teleDelay;
      if ( teleHold == 0 ) {
        this.teleportCell = ( this.teleportCell - 1 ) % this.teleportFrames;
      }
      this.offsetTele = 1065 + teleportCell * cellSize;

      fill(0, 0, 0, 0);
      rect(x, y, WIDTH, HEIGHT);
      copy(sprites, offsetTele, offsetY, WIDTH, HEIGHT, x, y, WIDTH, HEIGHT);

      if ( teleportCell == 0 ) {
        resetTeleport();
        setState(CHASE);
      }
    } else {
      switch ( this.direction ) {
      case UP:
        this.offsetX = 892 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 732 + frameCell;
        break;
      case DOWN:
        this.offsetX = 972 + frameCell;
        break;
      case LEFT:
        this.offsetX = 812 + frameCell;
        break;
      default:
        println("Error in Inky.draw()");
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

      // Move sprite
      if ( state == SCATTER ) {
        if ( this.onScatterPath == false ) {
          initialiseScatter();
        }
        if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) && reachedTargetTile() ) {
          setScatterParameters();
        }
      } else {
        setTargetTile();
      }

      if ( !map.checkPause() ) {
        update();
      }

      // 1 in 40 chance of teleporting
      if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) ) {
        int teleport = (int) random(1, 41);
        if ( teleport % 40 == 0 ) {
          setState(TELEPORT);
        }
      }
    }
  }


  // Set target tile
  void setTargetTile() {

    switch ( this.target.direction ) {

    case UP:
      if ( this.target.getCurrentNode()[1] <= 2 ) {
        this.targetRow = 1;
      } else {
        this.targetRow = this.target.getCurrentNode()[1] - 2;
      }
      this.targetCol = this.target.getCurrentNode()[0];
      break;

    case RIGHT:
      if ( this.target.getCurrentNode()[0] >= 25 ) {
        this.targetCol = 26;
      } else {
        this.targetCol = this.target.getCurrentNode()[0] + 2;
      }
      this.targetRow = this.target.getCurrentNode()[1];
      break;

    case DOWN:
      if ( this.target.getCurrentNode()[1] >= 28 ) {
        this.targetRow = 29;
      } else {
        this.targetRow = this.target.getCurrentNode()[1] + 2;
      }
      this.targetCol = this.target.getCurrentNode()[0];
      break;

    case LEFT:
      if ( this.target.getCurrentNode()[0] <= 2 ) {
        this.targetCol = 1;
      } else {
        this.targetCol = this.target.getCurrentNode()[0] - 2;
      }
      this.targetRow = this.target.getCurrentNode()[1];
      break;

    default:
      println("Error in Pinky.setTargetTile()");
      break;
    }
  }


  // Teleport ghost
  void teleport() {

    int randomCol;
    int randomRow;

    do {
      randomCol = (int) random(1, 27);
      randomRow = (int) random(1, 29);
    } while ( !map.checkMove(randomCol, randomRow) && map.map[randomRow][randomCol] == wall );

    this.col = randomCol;
    this.row = randomRow;
    this.x = this.col * cellSize;
    this.y = this.row * cellSize;
  }


  // Set parameters required to animate teleport
  void resetTeleport() {

    this.teleportCell = 0;
    this.teleHold = 0;
  }
}


class Orson extends Ghost {

  int offsetX;
  int offsetY;


  // Constructor
  Orson(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    this.offsetY = 446;
  }


  // Draw Ghost
  void draw() {

    this.frameCell = currentFrame * cellSize;

    switch ( this.direction ) {
    case UP:
      this.offsetX = 892 + frameCell;
      break;
    case RIGHT:
      this.offsetX = 732 + frameCell;
      break;
    case DOWN:
      this.offsetX = 972 + frameCell;
      break;
    case LEFT:
      this.offsetX = 812 + frameCell;
      break;
    default:
      println("Error in Orson.draw()");
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

    // Move sprite
    if ( state == SCATTER ) {
      if ( this.onScatterPath == false ) {
        initialiseScatter();
      }
      if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) && reachedTargetTile() ) {
        setScatterParameters();
      }
    } else if ( getDistance() >= 16 ) {
      setState(CHASE);
      setTargetTile();
    } else {
      setState(EVADE);
    }

    if ( !map.checkPause() ) {
      update();
    }

    // Place dots
    if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) ) {
      if ( this.pacman.currentDotsEaten >= 100 && this.pacman.currentDotsEaten <= 175 && this.map.map[this.row][this.col] == 0 ) {
        this.map.setDot(this.col, this.row);
      }
    }
  }


  // Set target tile
  void setTargetTile() {

    this.targetCol = this.target.getCurrentNode()[0];
    this.targetRow = this.target.getCurrentNode()[1];
  }


  // Return Euclidian distance from target entity
  int getDistance() {

    int dX = abs(this.col - this.target.getCurrentNode()[0]);
    int dY = abs(this.row - this.target.getCurrentNode()[1]);

    return (int) sqrt( pow(dX, 2) + pow(dY, 2) );
  }
}


class Spunky extends Ghost {

  int offsetX;
  int offsetY;

  int offsetSleep;
  int sleepCell;
  int sleepFrames;
  int sleepHold;
  int sleepDelay;


  // Constructor
  Spunky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);

    this.offsetY = 124;
    this.sleepCell = 0;
    this.sleepFrames = 2;
    this.sleepHold = 2;
    this.sleepDelay = 5;
  }


  // Draw Ghost
  void draw() {

    this.frameCell = currentFrame * cellSize;

    if ( this.freeze ) {

      this.sleepHold = ( this.sleepHold + 1 ) % this.sleepDelay;
      if ( sleepHold == 0 ) {
        this.sleepCell = ( this.sleepCell + 1 ) % this.sleepFrames;
      }
      this.offsetSleep = 1091 + sleepCell * cellSize;

      fill(0, 0, 0, 0);
      rect(x, y, WIDTH, HEIGHT);
      copy(sprites, offsetSleep, offsetY, WIDTH, HEIGHT, x, y, WIDTH, HEIGHT);
    } else {
      switch ( this.direction ) {
      case UP:
        this.offsetX = 931 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 771 + frameCell;
        break;
      case DOWN:
        this.offsetX = 1011 + frameCell;
        break;
      case LEFT:
        this.offsetX = 851 + frameCell;
        break;
      default:
        println("Error in Clyde.draw()");
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
    }

    // Move sprite
    if ( state == SCATTER ) {
      if ( this.onScatterPath == false ) {
        initialiseScatter();
      }
      if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) && reachedTargetTile() ) {
        setScatterParameters();
      }
    } else if ( getDistance() <= 6 ) {
      freeze(false);
      setState(CHASE);
      setTargetTile();
    } else {
      setState(EVADE);
      if ( millis() > 10000 ) {
        freeze(true);
      }
    }

    if ( !map.checkPause() ) {
      update();
    }
  }


  // Set target tile
  void setTargetTile() {

    this.targetCol = this.target.getCurrentNode()[0];
    this.targetRow = this.target.getCurrentNode()[1];
  }


  // Return Euclidian distance from target entity
  int getDistance() {

    int dX = abs(this.col - this.target.getCurrentNode()[0]);
    int dY = abs(this.row - this.target.getCurrentNode()[1]);

    return (int) sqrt( pow(dX, 2) + pow(dY, 2) );
  }
}
