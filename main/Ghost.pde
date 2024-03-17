class Ghost {
  
  int x, y; // Ghost's position
  int direction; // Ghost's movement direction
  GameMap map; // Reference to the game map
  Pacman pacman; // Reference to the player
  Pathfinder pf;
  long lastSwitchTime = 0; // Time of the last state switch
  int cellSize;
    
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
  }

  // Update the ghost's position
  void update() {
    //direction = (int)random(8); // Randomly change direction
    move();
  }

/*
  // Attempt to move the ghost based on the current direction, return true if successful, otherwise false
  boolean move() {
    int dx = 0, dy = 0;
    switch (direction) {
      case 0: dy = -1; break; // Up
      case 1: dx = 1; break;  // Right
      case 2: dy = 1; break;  // Down
      case 3: dx = -1; break; // Left
      default: break; // No movement
    }
    //if (map.checkMove(x + dx, y + dy)) {
    //  x += dx;
    //  y += dy;
    //  return true;
    //}
    return false;
  }
*/

  // Method to draw the ghost
  void drawGhost() {
    toggleGhostState();
    int baseX = x * cellSize + cellSize / 2;
    int baseY = y * cellSize + cellSize / 2;
    fill(255, 0, 0); // Set to red color
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
    if (millis() - lastSwitchTime > 500) { // Check if X milliseconds have passed to update direction more frequently
      update();
      lastSwitchTime = millis(); // Update switch time
    }
  }
  
  /*
  // Move Ghosts according to A* algorithm
  void move() {
   
    ArrayList<int[]> closed = new ArrayList<int[]>();
    ArrayList<int[]> open = new ArrayList<int[]>();
    
    open.add(this.getCurrentNode());
    int[] targetNode = pacman.getCurrentNode();
    
    while (open.size() > 0) {
      
      
      
    }
       
     
  }
  */
  
 
  void move() {
    
    int targetRow = getTargetNode()[1];
    int targetCol = getTargetNode()[0];
    
    //print("row = " + targetRow + "\n");
    //print("col = " + targetCol + "\n");
    
    pf.setGrid(this.x, this.y, targetCol, targetRow);
    //print(this.x);
    //print(this.y);
    println("Ghost pos : " + this.x + " " + this.y);
    println("Pacman pos : " + targetCol + " " + targetRow);
    
    if ( pf.traverse() ) {
      
      for (int i = 0; i < pf.optimalPath.size(); i++) {
        print("row = " + pf.optimalPath.get(i).x + ", col = " + pf.optimalPath.get(i).y + "  ->  ");
      }
      println();
      println();
      
      this.x = pf.optimalPath.get(0).x;
      this.y = pf.optimalPath.get(0).y;
    }
  
  }

 
  // Get ghost's target node
  int[] getTargetNode() {
    int[] target = {pacman.x, pacman.y};
    return target;
  }
  

}
