final int UP = 1;
final int RIGHT = 2;
final int DOWN = 3;
final int LEFT = 4;


abstract class Ghost {
  
  int x, y; // Ghost's position
  int direction; // Ghost's movement direction
  GameMap map; // Reference to the game map
  Pacman pacman; // Reference to the player
  Pathfinder pf;
  long lastSwitchTime = 0; // Time of the last state switch
  int cellSize;
  boolean caughtPacman;
    
    
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
  }
  
  
  // Draw ghost methods
  abstract void drawBlinky();
  abstract void drawPinky();
  abstract void drawInky();
  abstract void drawClyde();


  // Update the ghost's position
  void update(int targetRow, int targetCol) {
    //direction = (int)random(8); // Randomly change direction
    move(targetRow, targetCol);
    
    if ( reachedTarget() ) {
      caughtPacman = true;
    }
    
  }
  
  
  // Method to draw the ghost
  void drawGhost(int targetRow, int targetCol, int[] colour) {
    toggleGhostState(targetRow, targetCol);
    int baseX = x * cellSize + cellSize / 2;
    int baseY = y * cellSize + cellSize / 2;
    fill(colour[0], colour[1], colour[2]); // Set to red color
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
  void toggleGhostState(int targetRow, int targetCol) {
    if (millis() - lastSwitchTime > 500) { // Check if X milliseconds have passed to update direction more frequently
      update(targetRow, targetCol);
      lastSwitchTime = millis(); // Update switch time
    }
  }
  
  
  // Move ghost
  void move(int targetRow, int targetCol) {

    pf.setGrid(this.x, this.y, targetCol, targetRow);

    if ( pf.traverse() ) {
      
      this.x = pf.optimalPath.get(0).x;
      this.y = pf.optimalPath.get(0).y;
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
    
    if ( this.x == pacman.getCurrentNode()[0] && this.y == pacman.getCurrentNode()[1] ) {
      return true;
    }
    
    return false;
  }

}


class Blinky extends Ghost {
  
  // Constructor
  Blinky(int startX, int startY, Pacman pacman, GameMap map, Pathfinder pf) {
    super(startX, startY, pacman, map, pf);
  }
  
  
  // Method to draw red ghost
  void drawBlinky() {
    
    int targetRow = getTargetNode()[1];
    int targetCol = getTargetNode()[0];
    int[] colour = {255, 0, 0};
    
    drawGhost(targetRow, targetCol, colour);
  }
  
  
  // Useless methods
  void drawPinky() {
    return;
  }
  void drawInky() {
    return;
  }
  void drawClyde() {
    return;
  }  
  
  
  // Get Blinky's target node
  int[] getTargetNode() {
    int[] target = {pacman.x, pacman.y};
    return target;
  }
  
}


class Pinky extends Ghost {
  
  // Constructor
  Pinky(int startX, int startY, Pacman pacman, GameMap map, Pathfinder pf) {
    super(startX, startY, pacman, map, pf);
  }
  
  
  // Method to draw pink ghost
  void drawPinky() {
    
    int targetRow = getTargetNode()[1];
    int targetCol = getTargetNode()[0];
    int[] colour = {245, 151, 198};
   
    drawGhost(targetRow, targetCol, colour);
  }
  
  
  // Useless methods
  void drawBlinky() {
    return;
  }
  void drawInky() {
    return;
  }
  void drawClyde() {
    return;
  }
  
  
  // Get Pinky's target node
  int[] getTargetNode() {
    
    int[] target = {0, 0};
    
    switch(pacman.getCurrentDirection() + 1) {
      case UP:
        target[0] = pacman.getCurrentNode()[0];
        target[1] = pacman.getCurrentNode()[1] - 2;
        break;
      case RIGHT:
        target[0] = pacman.getCurrentNode()[0] + 2;
        target[1] = pacman.getCurrentNode()[1];
        break;
      case DOWN:
        target[0] = pacman.getCurrentNode()[0];
        target[1] = pacman.getCurrentNode()[1] + 2;
        break;
      case LEFT:
        target[0] = pacman.getCurrentNode()[0] - 2;
        target[1] = pacman.getCurrentNode()[1];
        break;
      default:
        break;
    }
    
    if ( map.checkMove(target[0], target[1]) ) {
      return target;
    }
    else {
      target[0] = this.x;
      target[1] = this.y;
      return target;
    }
    
  }
  
}
