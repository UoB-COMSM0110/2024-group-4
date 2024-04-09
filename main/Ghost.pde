class Ghost extends Entity {
  
  Pacman pacman;
  
  int currentFrame;
  int totalFrames;
  int frameCell;
  int hold;
  int delay;
 
 
  // Constructor
  Ghost(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map);
    
    this.pacman = pacman;
    
    this.currentFrame = 0;
    this.totalFrames = 2;
    this.hold = 0;
    this.delay = 6;
  }
  
}


class Blinky extends Ghost {
  
  int offsetX;
  int offsetY;

  
  // Constructor
  Blinky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
    
    this.offsetY = 530;
  }
  
  
  // Draw Ghost
  void draw() {
    
    this.frameCell = currentFrame * cellSize;
    
    switch ( this.direction ) {
      case UP:
        this.offsetX = 176 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 16 + frameCell;
        break;
      case DOWN:
        this.offsetX = 256 + frameCell;
        break;
      case LEFT:
        this.offsetX = 96 + frameCell;
        break;
      default:
        println("Error in Blinky.draw()");
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
    setTargetTile();
    update();
  }
  
  
  // Set target tile
  void setTargetTile() {
    
    this.targetCol = this.target.getCurrentNode()[0];
    this.targetRow = this.target.getCurrentNode()[1]; 
  }

}


class Inky extends Ghost {
  
  int offsetX;
  int offsetY;
  
  Ghost targetGhost; // Uses relative position of a given ghost to calculate target tile

  
  // Constructor
  Inky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
    
    this.offsetY = 402;
  }
  
  
  // Draw Ghost
  void draw() {
    
    this.frameCell = currentFrame * cellSize;
    
    switch ( this.direction ) {
      case UP:
        this.offsetX = 176 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 16 + frameCell;
        break;
      case DOWN:
        this.offsetX = 256 + frameCell;
        break;
      case LEFT:
        this.offsetX = 96 + frameCell;
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
    setTargetTile();
    update();
  }
  
  
  // Set relative ghost
  void setGhost(Ghost ghost) {
    
    this.targetGhost = ghost;
  }
  
  
  // Set target tile
  void setTargetTile() {
    
    int tempCol = -1;
    int tempRow = -1;
    int totalDist;
    
    switch ( this.target.direction ) {
      
      case UP:
        if ( this.target.getCurrentNode()[1] <= 2 ) {
          tempRow = 1;
        }
        else {
          tempRow = this.target.getCurrentNode()[1] - 2;
        }
        tempCol = this.target.getCurrentNode()[0];
        break;
      
      case RIGHT:
        if ( this.target.getCurrentNode()[0] >= 25 ) {
          tempCol = 26;
        }
        else {
          tempCol = this.target.getCurrentNode()[0] + 2;
        }
        tempRow = this.target.getCurrentNode()[1];
        break;
      
      case DOWN:
        if ( this.target.getCurrentNode()[1] >= 28 ) {
          tempRow = 29;
        }
        else {
          tempRow = this.target.getCurrentNode()[1] + 2;
        }
        tempCol = this.target.getCurrentNode()[0];
        break;
      
      case LEFT:
        if ( this.target.getCurrentNode()[0] <= 2 ) {
          tempCol = 1;
        }
        else {
          tempCol = this.target.getCurrentNode()[0] - 2;
        }
        tempRow = this.target.getCurrentNode()[1];
        break;
      
      default:
        println("Error in Pinky.setTargetTile()");
        break;
    }
    
    int d = getDistance(tempCol, tempRow);
    int edgeDist = getShortestEdge(tempCol, tempRow);
    if ( d < edgeDist ) {
      totalDist = 2 * d;
    }
    else {
      totalDist = 2 * edgeDist;
    } 
    
    int targetCol = this.targetGhost.getCurrentNode()[0] + ( (tempCol - this.targetGhost.getCurrentNode()[0] ) / d ) * totalDist;
    int targetRow = this.targetGhost.getCurrentNode()[1] + ( (tempRow - this.targetGhost.getCurrentNode()[1] ) / d ) * totalDist;
    
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
    return min(tempMin, west);
  }
    
    
  // Return Euclidian distance from target ghost
  int getDistance(int tempCol, int tempRow) {
    
    int dX = abs(tempCol - this.targetGhost.getCurrentNode()[0]);
    int dY = abs(tempRow - this.targetGhost.getCurrentNode()[1]);
    
    return (int) sqrt( pow(dX, 2) + pow(dY, 2) );
  }

}


class Pinky extends Ghost {
  
  int offsetX;
  int offsetY;

  
  // Constructor
  Pinky(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
    
    this.offsetY = 657;
  }
  
  
  // Draw Ghost
  void draw() {
    
    this.frameCell = currentFrame * cellSize;
    
    switch ( this.direction ) {
      case UP:
        this.offsetX = 176 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 16 + frameCell;
        break;
      case DOWN:
        this.offsetX = 256 + frameCell;
        break;
      case LEFT:
        this.offsetX = 96 + frameCell;
        break;
      default:
        println("Error in Pinky.draw()");
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
    setTargetTile();
    update();
  }
  
  
  // Set target tile
  void setTargetTile() {
    
    switch ( this.target.direction ) {
      
      case UP:
        if ( this.target.getCurrentNode()[1] <= 4 ) {
          this.targetRow = 1;
        }
        else {
          this.targetRow = this.target.getCurrentNode()[1] - 4;
        }
        this.targetCol = this.target.getCurrentNode()[0];
        break;
      
      case RIGHT:
        if ( this.target.getCurrentNode()[0] >= 23 ) {
          this.targetCol = 26;
        }
        else {
          this.targetCol = this.target.getCurrentNode()[0] + 4;
        }
        this.targetRow = this.target.getCurrentNode()[1];
        break;
      
      case DOWN:
        if ( this.target.getCurrentNode()[1] >= 26 ) {
          this.targetRow = 29;
        }
        else {
          this.targetRow = this.target.getCurrentNode()[1] + 4;
        }
        this.targetCol = this.target.getCurrentNode()[0];
        break;
      
      case LEFT:
        if ( this.target.getCurrentNode()[0] <= 4 ) {
          this.targetCol = 1;
        }
        else {
          this.targetCol = this.target.getCurrentNode()[0] - 4;
        }
        this.targetRow = this.target.getCurrentNode()[1];
        break;
      
      default:
        println("Error in Pinky.setTargetTile()");
        break;
    }
  }

}


class Clyde extends Ghost {
  
  int offsetX;
  int offsetY;

  
  // Constructor
  Clyde(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
    
    this.offsetY = 784;
  }
  
  
  // Draw Ghost
  void draw() {
    
    this.frameCell = currentFrame * cellSize;
    
    switch ( this.direction ) {
      case UP:
        this.offsetX = 176 + frameCell;
        break;
      case RIGHT:
        this.offsetX = 16 + frameCell;
        break;
      case DOWN:
        this.offsetX = 256 + frameCell;
        break;
      case LEFT:
        this.offsetX = 96 + frameCell;
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
    
    // Move sprite
    if ( getDistance() >= 8 ) {
      setState(CHASE);
      setTargetTile();
    }
    else {
      setState(EVADE);
    }
    update();
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


class Sue extends Ghost {
  
  int offsetX;
  int offsetY;

  
  // Constructor
  Sue(int startCol, int startRow, Pathfinder pf, GameMap map, Pacman pacman) {
    super(startCol, startRow, pf, map, pacman);
    
    this.offsetY = 285;
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
    
    // Move sprite
    if ( getDistance() >= 4 ) {
      setState(CHASE);
      setTargetTile();
    }
    else {
      setState(EVADE);
    }
    update();
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
        this.teleHold = 0;
        setState(REAPPEAR);
      }
    }
    else if ( this.state == REAPPEAR ) {
      
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
      
    }
    else {
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
      setTargetTile();
      update();
      
      // 1 in 40 chance of teleporting
      if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) ) {
        int teleport = (int) random(1, 41);
        if ( teleport % 20 == 0 ) {
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
        }
        else {
          this.targetRow = this.target.getCurrentNode()[1] - 2;
        }
        this.targetCol = this.target.getCurrentNode()[0];
        break;
      
      case RIGHT:
        if ( this.target.getCurrentNode()[0] >= 25 ) {
          this.targetCol = 26;
        }
        else {
          this.targetCol = this.target.getCurrentNode()[0] + 2;
        }
        this.targetRow = this.target.getCurrentNode()[1];
        break;
      
      case DOWN:
        if ( this.target.getCurrentNode()[1] >= 28 ) {
          this.targetRow = 29;
        }
        else {
          this.targetRow = this.target.getCurrentNode()[1] + 2;
        }
        this.targetCol = this.target.getCurrentNode()[0];
        break;
      
      case LEFT:
        if ( this.target.getCurrentNode()[0] <= 2 ) {
          this.targetCol = 1;
        }
        else {
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


/*
//<<<<<<< main
final int UP = 1;
final int RIGHT = 2;
final int DOWN = 3;
final int LEFT = 4;


abstract class Ghost {
  int x, y; // Ghost's position
  int direction; // Ghost's movement direction
  int speed;
  GameMap map; // Reference to the game map
  Pacman pacman; // Reference to the player
  Pathfinder pf;
  long lastSwitchTime = 0; // Time of the last state switch
  int cellSize;
  boolean caughtPacman;

  int targetRow;
  int targetCol;
  int[] colour = {255, 0, 0};
    
  // Constructor
  Ghost(int startX, int startY, Pacman pacman, GameMap map, Pathfinder pf) {
    this.x = startX;
    this.y = startY;
    this.pacman = pacman;
    this.map = map;
    this.pf = pf;
    this.direction = (int)random(8); // Randomly initialize movement direction
    this.lastSwitchTime = 0;
    this.cellSize = map.cellSize;
    this.caughtPacman = false;
    this.speed = 100 * difficulty;
  }
  
  
  // Draw ghost methods
  // abstract void drawBlinky();
  // abstract void drawPinky();
  // abstract void drawInky();
  // abstract void drawClyde();


  // Update the ghost's position
  void update() {
    boolean speed_slow = false;
    boolean speed_stop = false;
    for (int i = 0; i < map.map.length; i++) {
      for (int j = 0; j < map.map[i].length; j++) {
        if (map.map[i][j] == 4) {
          speed_slow = true;
          speed = 100 * difficulty * 2;
        }
        if (map.map[i][j] == 6) {
          speed_stop = true;
        }
      }
    }
    if (!speed_slow) {
      speed = 100 * difficulty;
    }  
    direction = (int)random(8); // Randomly change direction
    if (!speed_stop) {
      move();  
    }
  }
  
  // Method to draw the ghost
  void drawGhost() {
    int baseX = x * cellSize + cellSize / 2;
    int baseY = y * cellSize + cellSize / 2;
    fill(colour[0], colour[1], colour[2]); // Set color

    noStroke();

    // Draw the body
    beginShape();
    // Semi-circular top
    arc(baseX, baseY, cellSize, cellSize, PI, TWO_PI);
    rect(baseX-cellSize/2, baseY, cellSize, cellSize/4);
    // Wavy bottom
    int wavySectionWidth = cellSize / 4;
    for (int i = 0; i < 4; i++) {
      int startX = baseX - cellSize / 2 + i * wavySectionWidth;
      int endX = startX + wavySectionWidth;
      arc((startX + endX)/2, baseY + cellSize/4, wavySectionWidth*0.75, wavySectionWidth*1.9, 0, PI);
    }
    endShape(CLOSE);

    // Draw the eyes
    fill(255); // White eyes
    ellipse(baseX - cellSize / 4, baseY - cellSize / 4, cellSize / 4, cellSize / 4);
    ellipse(baseX + cellSize / 4, baseY - cellSize / 4, cellSize / 4, cellSize / 4);
    
    // Draw the pupils
    fill(0); // Black pupils
    ellipse(baseX - cellSize / 4, baseY - cellSize / 4, cellSize / 8, cellSize / 8);
    ellipse(baseX + cellSize / 4, baseY - cellSize / 4, cellSize / 8, cellSize / 8);
  }


  // Toggle Ghost's state based on time
  void toggleGhostState() {
    targetMethod();
    if ( reachedTarget() ) {
      caughtPacman = true;
    }
    
    if (millis() - lastSwitchTime > speed) { // Check if X milliseconds have passed to update direction more frequently
      if (!map.checkPause()) {
        update();
      }
      lastSwitchTime = millis(); // Update switch time
    }
  }
  
  
  // Move ghost
  void move() {
    pf.setGrid(x, y, targetCol, targetRow);

    if ( pf.traverse() ) {
      
      x = pf.optimalPath.get(0).x;
      y = pf.optimalPath.get(0).y;
    }
    else { // Ghost is completely blocked off -> move randomly until able to reach target again
      randomMove();
    }
  }
  
  
  // If ghost blocked and cannot find target -> move randomly
  void randomMove() {
    
    int newX = -1;
    int newY = -1;
    
    // Get valid move
    while ( !map.checkMove(newX, newY) ) {
      
      int direction = (int) random(1, 5);
    
      switch (direction) {
      
      case UP:
        newX = this.x;
        newY = this.y - 1;
        break;
      case RIGHT:
        newX = this.x + 1;
        newY = this.y;
        break;
      case DOWN:
        newX = this.x;
        newY = this.y + 1;
        break;
      case LEFT:
        newX = this.x - 1;
        newY = this.y;
        break;
      default:
        break;
      }
      
    }
    
    // Update position
    this.x = newX;
    this.y = newY;
    
  }
  
  
  // Check if a ghost has caught pacman -> game over
  boolean reachedTarget() {
    // TODO
    // println("#######################");
    // println(x, y);
    // println(pacman.getCurrentNode());
    if ( this.x == pacman.getCurrentNode()[0] && this.y == pacman.getCurrentNode()[1] ) {
      return true;
    }
    
    return false;
  }
  
  void targetMethod() {
    targetRow = pacman.y;
    targetCol = pacman.x;
  }
}


class Blinky extends Ghost {
  // Constructor
  Blinky(int startX, int startY, Pacman pacman, GameMap map, Pathfinder pf) {
    super(startX, startY, pacman, map, pf);
    this.colour = new int[]{255, 0, 0};
  }
}


class Pinky extends Ghost {
  // Constructor
  Pinky(int startX, int startY, Pacman pacman, GameMap map, Pathfinder pf) {
    super(startX, startY, pacman, map, pf);
    this.colour = new int[]{245, 151, 198};
  }

  // Get Pinky's target node
  @Override
  void targetMethod() {
    int[] target = {x, y};
    switch(pacman.getCurrentDirection() + 1) {
      case UP:
        target[0] = pacman.x;
        target[1] = pacman.y - 2;
        break;
      case RIGHT:
        target[0] = pacman.x + 2;
        target[1] = pacman.y;
        break;
      case DOWN:
        target[0] = pacman.x;
        target[1] = pacman.y + 2;
        break;
      case LEFT:
        target[0] = pacman.x - 2;
        target[1] = pacman.y;
        break;
      default:
        break;
    }
    
    if (map.checkMove(target[0], target[1])) {
    }
    else {
      target[0] = x;
      target[1] = y;
    }
    targetRow = target[1];
    targetCol = target[0];
  }
}
*/
