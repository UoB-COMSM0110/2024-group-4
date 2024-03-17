class Pacman {
  int x, y; // Pacman's grid position
  int money = 0; // Initial money for buying block
  GameMap map; // Reference to the game map for checking
  int cellSize; // Assuming a fixed cell size for simplicity
  int direction = 1; // Initial direction (0 up, 1 right, 2 down, 3 left)
  int[] movement = {0, 0}; // movement[0] is dx, movement[1] is dy
  int state = 0; // Pacman's state: 0 for mouth closed, 1 for mouth open
  long lastSwitchTime = 0; // Time of the last state switch
  boolean isComputer = true; // Pacman's controller: true for computer, false for player

  // Constructor
  Pacman(int startX, int startY, GameMap map) {
    this.x = startX;
    this.y = startY;
    this.map = map;
    cellSize = map.cellSize;
    map.clearGrid(x, y);
  }

  // Method to draw Pacman
  void drawPacman() {
    togglePacmanState();
    fill(255, 255, 0); // Yellow color
    float centerX = x * cellSize + cellSize / 2;
    float centerY = y * cellSize + cellSize / 2;
    
    // Adjust the opening direction based on Pacman's direction
    if (state == 0) { // Mouth closed state
      ellipse(centerX, centerY, cellSize, cellSize);
    } else { // Mouth open state
      float startAngle = 0;
      float endAngle = 0;
      switch(direction) {
        case 0: // Up
          startAngle = -PI / 4;
          endAngle = 5 * PI / 4;
          break;
        case 1: // Right
          startAngle = PI / 4;
          endAngle = 7 * PI / 4;
          break;
        case 2: // Down
          startAngle = -5 * PI / 4;
          endAngle = PI / 4;
          break;
        case 3: // Left
          startAngle = -3 * PI / 4;
          endAngle = 3 * PI / 4;
          break;
      }
      arc(centerX, centerY, cellSize, cellSize, startAngle, endAngle);
    }
  }

  // Method to toggle Pacman's state
  void togglePacmanState() {
    if (millis() - lastSwitchTime > 500) { // Check if 500 milliseconds have passed
      if (isComputer) {
        update();
      }  
      state = (state + 1) % 2; // Toggle state
      lastSwitchTime = millis(); // Update switch time
    }
  }

  // Attempt to move Pacman in the specified direction
  void move(int dx, int dy) {
    int newX = x + dx;
    int newY = y + dy;

    // Check if the move is valid
    if (map.checkMove(newX, newY)) {
      x = newX;
      y = newY;
      if (map.checkDot(x, y)) {
        map.eatDot(x, y);
        money++;
      }  
    }
    // Optionally, update the direction based on dx, dy here for drawing purposes
    if (dx == 1) direction = 1; // Right
    else if (dx == -1) direction = 3; // Left
    else if (dy == 1) direction = 2; // Down
    else if (dy == -1) direction = 0; // Up
  }
  
  // Update the pacman's position
  void update() {
    chooseDirection();
    autoMove();
  }
  
  void chooseDirection() {
    int[] temp = {0, 0};
    int flag = 0;
    for (int i = 0; i < 4; i++) {
      switch (i) {
        // temp[0] = (2-i)*(i%2);
        // temp[1] = (1-i)*(i%2-1);
        case 0: temp[0] = 0; // Up
                temp[1] = -1; 
                break; 
        case 1: temp[0] = 1; // Right
                temp[1] = 0;
                break;  
        case 2: temp[0] = 0; // Down
                temp[1] = 1; 
                break; 
        case 3: temp[0] = -1; // Left
                temp[1] = 0;
                break; 
        default: break; // No movement
      }
      if (map.checkDot(x + temp[0], y + temp[1])) {
        direction = i;
        flag = 1;
      }  
    }  
    getMovement();
    while (!map.checkMove(x + movement[0], y + movement[1])) { 
      direction = (int)random(4);
      getMovement();
    }  
  }  

  // Attempt to move the pacman based on the current direction, return true if successful, otherwise false
  void autoMove() {
    getMovement();
    if (map.checkMove(x + movement[0], y + movement[1])) {
      x += movement[0];
      y += movement[1];
      if (map.checkDot(x, y)) {
        map.eatDot(x, y);
        money++;
      }
    } 
  }
  
  void getMovement() {
    switch (direction) {
      case 0: movement[0] = 0; // Up
              movement[1] = -1; 
              break; 
      case 1: movement[0] = 1; // Right
              movement[1] = 0;
              break;  
      case 2: movement[0] = 0; // Down
              movement[1] = 1; 
              break; 
      case 3: movement[0] = -1; // Left
              movement[1] = 0;
              break; 
      default: break; // No movement
    }
  }
  
  
  // Get Pacman's current position
  int[] getCurrentNode() {
    int[] node = {x, y};
    return node;
  }
  
  
  // Get Pacman's current direction
  int getCurrentDirection() {
    return direction;
  }
  
}
