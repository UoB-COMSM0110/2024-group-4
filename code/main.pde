void setup() {
  size(400, 240); // Set the size of the window
}

void draw() {
  background(0); // Set the background color to black
  drawMap(); // Call the function to draw the map
  drawPacman(); // Call the function to draw Pacman
}

void keyPressed() {
  switch(keyCode) {
    case UP:
      direction = 0; // Update direction to up
      if (checkMove(pacmanX, pacmanY - 1)) {
        pacmanY--; // Move Pacman up
      }
      break;
    case DOWN:
      direction = 2; // Update direction to down
      if (checkMove(pacmanX, pacmanY + 1)) {
        pacmanY++; // Move Pacman down
      }
      break;
    case LEFT:
      direction = 3; // Update direction to left
      if (checkMove(pacmanX - 1, pacmanY)) {
        pacmanX--; // Move Pacman left
      }
      break;
    case RIGHT:
      direction = 1; // Update direction to right
      if (checkMove(pacmanX + 1, pacmanY)) {
        pacmanX++; // Move Pacman right
      }
      break;
  }
}
