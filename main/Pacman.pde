class Pacman {
  int x, y; // Pacman's grid position
  GameMap map; // Reference to the game map for checking valid moves
  int cellSize; // Assuming a fixed cell size for simplicity
  int direction = 1; // Initial direction (0 up, 1 right, 2 down, 3 left)
  int state = 0; // Pacman's state: 0 for mouth closed, 1 for mouth open
  long lastSwitchTime = 0; // Time of the last state switch

  // Constructor
  Pacman(int startX, int startY, GameMap map) {
    this.x = startX;
    this.y = startY;
    this.map = map;
    cellSize = map.cellSize;
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
    }
    // Optionally, update the direction based on dx, dy here for drawing purposes
    if (dx == 1) direction = 1; // Right
    else if (dx == -1) direction = 3; // Left
    else if (dy == 1) direction = 2; // Down
    else if (dy == -1) direction = 0; // Up
  }
}