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

final int StartScreen = 0;
final int gameInProgress = 1;
final int gameOver = 2;
int gamemod;
Button startButton;
Button endButton;

final int gamewidth = 1640;
final int gameheight = 1240;
final int button_w = 300;
final int button_h = 150;
final int button_textSize = 50;

void setup() {
  size(1640, 1240);
  gamemod = StartScreen;
  startButton = new Button((gamewidth-button_w)/2, (gameheight-button_h)/2, button_w, button_h, "Start Game", button_textSize);
  endButton = new Button((gamewidth-button_w)/2, (gameheight-button_h-200)/2, button_w*2, button_h, "Return to main menu", button_textSize);

}

void draw() {
  switch (gamemod) {
    case StartScreen:
      menu();
      break;
    case gameInProgress:
      maingame();
      break;
    case gameOver:
      endgame();
      break;
    // default:
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
  if (gamemod == StartScreen) {
    if (startButton.clicked(mouseX, mouseY)) {
      gamemod = gameInProgress;
      gameMap = new GameMap(cellSize); // Assuming each cell is 40 pixels
      myPacman = new Pacman(1, 1, gameMap); // Pacman starts at grid position (1, 1) and knows about the game map
      pf = new Pathfinder(gameMap);
      ghost1 = new Blinky(26, 29, myPacman, gameMap, pf);
      ghost2 = new Pinky(1, 29, myPacman, gameMap, pf);
    }
    return;
  }
  if (gamemod == gameInProgress) {
    int gridX = mouseX / cellSize;
    int gridY = mouseY / cellSize;
    
    if (gridX >= 0 && gridX < 1120/cellSize && gridY >= 0 && gridY < 1240/cellSize) {
      println(gridX, gridY);
      gameMap.setWall(gridX, gridY); 
    }
    if (gridX >= 38 && gridX < 40 && gridY >= 1 && gridY < 4) {
      gameMap.pause(); 
    }
    if (gridX >= 29 && gridX < 32 && gridY >= 12 && gridY < 15) {
      gameMap.changeBlock(1); 
    }
    if (gridX >= 33 && gridX < 36 && gridY >= 12 && gridY < 15) {
      gameMap.changeBlock(2); 
    }
    if (gridX >= 37 && gridX < 40 && gridY >= 12 && gridY < 15) {
      gameMap.changeBlock(3); 
    }
    return;
  }
  if (gamemod == gameOver) {
    if (endButton.clicked(mouseX, mouseY)) {
      gamemod = StartScreen;
      background(0);
    }
    return;
  }
}

void menu() {
  background(0);
  startButton.display();
}

void maingame() {
  background(0);
  gameMap.setMap();
  gameMap.drawMap();
  myPacman.drawPacman();
  ghost1.drawBlinky();
  ghost2.drawPinky();
  
  //println(ghost2.caughtPacman);
  if ( ghost1.caughtPacman || ghost2.caughtPacman ) {
    gamemod = gameOver;
  }
}

void endgame() {
  textAlign(CENTER, CENTER);
  fill(255, 0, 0);
  textSize(100);
  text("GAME OVER" , gamewidth/2 -200, gameheight/2 - 400);
  endButton.display();
}
