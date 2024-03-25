Pacman myPacman;
GameMap gameMap;

Blinky ghost1;
Pinky ghost2;
Pathfinder pf;
int cellSize = 40;
final int eazy = 4;
final int middle = 3;
final int hard = 2;
final int difficulty = eazy;

void setup() {
  size(1560, 1240);
  gameMap = new GameMap(cellSize); // Assuming each cell is 40 pixels
  myPacman = new Pacman(1, 1, gameMap); // Pacman starts at grid position (1, 1) and knows about the game map
  pf = new Pathfinder(gameMap);
  ghost1 = new Blinky(26, 29, myPacman, gameMap, pf);
  ghost2 = new Pinky(1, 29, myPacman, gameMap, pf);

}

void draw() {
  background(0);
  gameMap.drawMap();
  myPacman.drawPacman();

  ghost1.drawBlinky();
  ghost2.drawPinky();
  
  //println(ghost2.caughtPacman);
  if ( ghost1.caughtPacman || ghost2.caughtPacman ) {
    noLoop();
  }

}

void keyPressed() {
  // Update Pacman's direction and attempt to move
    if (keyCode == UP) {
      myPacman.move(0, -1);
    } else if (keyCode == DOWN) {
      myPacman.move(0, 1);
    } else if (keyCode == LEFT) {
      myPacman.move(-1, 0);
    } else if (keyCode == RIGHT) {
      myPacman.move(1, 0);
    } else if (keyCode == 32) {
      gameMap.pause();
    }
}  

void mouseClicked() {
  int gridX = mouseX / cellSize;
  int gridY = mouseY / cellSize;
  
  if (gridX >= 0 && gridX < 1120/cellSize && gridY >= 0 && gridY < 1240/cellSize) {
    println(gridX, gridY);
    gameMap.setWall(gridX, gridY); 
  }
  if (gridX >= 36 && gridX < 38 && gridY >= 1 && gridY < 4) {
    gameMap.pause(); 
  }
}
