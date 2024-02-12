int direction = 1; // Pacman's direction: 0 up, 1 right, 2 down, 3 left
int state = 0; // Pacman's state: 0 for mouth closed, 1 for mouth open
long lastSwitchTime = 0; // Time of the last state switch

void drawPacman() {
  togglePacmanState();
  fill(255, 255, 0); // Yellow color
  float x = pacmanX * cellSize + cellSize / 2;
  float y = pacmanY * cellSize + cellSize / 2;
  
  // Adjust the opening direction based on Pacman's direction
  if (state == 0) { // Mouth closed state
    ellipse(x, y, cellSize, cellSize);
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
    arc(x, y, cellSize, cellSize, startAngle, endAngle);
  }
}

void togglePacmanState() {
  if (millis() - lastSwitchTime > 500) { // Check if 500 milliseconds have passed
    state = (state + 1) % 2; // Toggle state
    lastSwitchTime = millis(); // Update switch time
  }
}
