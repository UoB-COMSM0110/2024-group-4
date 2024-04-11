Pacman myPacman;
GameMap gameMap;
PImage sprites;



Blinky ghost1;
Inky ghost2;
Pinky ghost3;
Clyde ghost4;

Pathfinder pf;
GameRecordManager GRM;
final int cellSize = 40;
final int eazy = 4;
final int middle = 3;
final int hard = 2;
final int difficulty = eazy;

final int StartScreen = 0;
final int gameInProgress = 1;
final int gameOver = 2;
final int gameLevel = 3;
final int gameRecord = 4;
final int gameHelp = 5;
int gamemod;
int level;
final int max_level = 5;
Button startButton;
Button endButton;
Button levelButton;
Button recordButton;
Button helpButton;
Button exitButton;

Button levelupButton;
Button leveldownButton;
Button levelenterButton;

Button cancelButton;

final int gamewidth = 1640;
final int gameheight = 1240;
final int button_w = 300;
final int button_h = 100;
final int button_textSize = 50;
final int startButton_Y = (gameheight-button_h)/2 - 100;
final int button_gap = 120;

boolean gameended = true;
int finalscore = 0;

void setup() {
  // TODO Make pacman smarter
  size(1640, 1240);
  gamemod = StartScreen;
  level = map_choice;
  startButton = new Button((gamewidth-button_w)/2, startButton_Y, button_w, button_h, "Start", button_textSize);
  levelButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 1, button_w, button_h, "Level", button_textSize);
  recordButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 2, button_w, button_h, "Ranking List", button_textSize);
  helpButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 3, button_w, button_h, "Help", button_textSize);
  exitButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 4, button_w, button_h, "Exit", button_textSize);
  endButton = new Button((gamewidth-button_w)/2, (gameheight-button_h-200)/2, button_w*2, button_h, "Return to main menu", button_textSize);

  leveldownButton = new Button((gamewidth-button_w)/2 - 200, startButton_Y + button_gap * 2, button_w, button_h, "<-", button_textSize);
  levelupButton = new Button((gamewidth-button_w)/2 + 200, startButton_Y + button_gap * 2, button_w, button_h, "->", button_textSize);
  levelenterButton = new Button(gamewidth - 400, gameheight - 200, button_w, button_h, "Confirm", button_textSize);

  cancelButton = new Button(gamewidth - 400, gameheight - 200, button_w, button_h, "Cancel", button_textSize);

  GRM = new GameRecordManager("game_records.txt", gameMap);
  sprites = loadImage("data/spriteSheet.png");
  loadSounds();
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
    case gameLevel:
      chooselevel();
      break;
    case gameRecord:
      recordmenu();
      break;
    case gameHelp:
      helpmenu();
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
  // TODO: Add hint;
  if (gamemod == gameLevel) {
    if (key >= '1' && key < '1' + max_level) {
      level = key - '1';
    }
  }
}  

void mouseClicked() {
  if (gamemod == StartScreen) {
    if (startButton.clicked()) {
      gamemod = gameInProgress;
      gameMap = new GameMap(cellSize); // Assuming each cell is 40 pixels
      gameMap.setMap();
      myPacman = new Pacman(PACMAN_HOME[0], PACMAN_HOME[1], pf, gameMap); // Pacman starts at grid position (1, 1) and knows about the game map
      myPacman.setDirection(LEFT);
      myPacman.setState(EVADE);
      pf = new Pathfinder(gameMap);
      ghost1 = new Blinky(12, 14, pf, gameMap, myPacman);
      ghost2 = new Inky(13, 14, pf, gameMap, myPacman);
      ghost3 = new Pinky(14, 14, pf, gameMap, myPacman);
      ghost4 = new Clyde(15, 14, pf, gameMap, myPacman);

      // Initialise ghosts
      ghost1.setDirection(UP);
      ghost1.setState(SCATTER);
      ghost1.setTarget(myPacman);
      ghost1.freeze(false);

      ghost2.setDirection(UP);
      ghost2.setState(SCATTER);
      ghost2.setTarget(myPacman);
      ghost2.freeze(true);

      ghost3.setDirection(UP);
      ghost3.setState(SCATTER);
      ghost3.setTarget(myPacman);
      ghost3.freeze(true);

      ghost4.setDirection(UP);
      ghost4.setState(SCATTER);
      ghost4.setTarget(myPacman);
      ghost4.freeze(true);

      gameended = false;
      finalscore = 0;
      return;
    }
    if (levelButton.clicked()) {
      gamemod = gameLevel;
      return;
    }
    if (recordButton.clicked()) {
      gamemod = gameRecord;
      return;
    }
    if (helpButton.clicked()) {
      gamemod = gameHelp;
      return;
    }
    if (exitButton.clicked()) {
      exit();
      return;
    }
  }
  if (gamemod == gameLevel) {
    if (levelupButton.clicked()) {
      level = (level+1)%max_level;
      return;
    }
    if (leveldownButton.clicked()) {
      level = (level-1+max_level)%max_level;
      return;
    }
    if (levelenterButton.clicked()) {
      map_choice = level;
      gamemod = StartScreen;
      return;
    }
  }
  if (gamemod == gameRecord) {
    if (cancelButton.clicked()) {
      gamemod = StartScreen;
      return;
    }
  }
  if (gamemod == gameHelp) {
    if (cancelButton.clicked()) {
      gamemod = StartScreen;
      return;
    }
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
    if (endButton.clicked()) {
      gamemod = StartScreen;
      background(0);
    }
    return;
  }
}
