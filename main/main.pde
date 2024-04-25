Pacman myPacman;
GameMap gameMap;
PImage sprites;

Blinky ghost1;
Inky ghost2;
Pinky ghost3;
Clyde ghost4;
Ghost[] ghosts;

Pathfinder pf;
GameRecordManager GRM;

final int cellSize = 40;

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

Button pauseContinueButton;
Button pauseCancelButton;

final int gamewidth = 1640;
final int gameheight = 1240;
final int button_w = 300;
final int button_h = 100;
final int button_textSize = 50;
final int startButton_Y = (gameheight-button_h)/2 - 100;
final int button_gap = 120;
PFont font;
PImage heart;
PImage coin;

boolean gameended = true;

// Animations
AnimationPacman animPacman;
AnimationGhosts animGhosts;

void setup() {
  // TODO Make pacman smarter
  size(1640, 1240);
  frameRate(60);
  font = createFont("assets/ka1.ttf", 48);
  textFont(font);
  heart = loadImage("assets/Heart.png");
  heart.resize(44, 44);
  coin = loadImage("assets/Coin.png");
  coin.resize(44, 44);
  gamemod = StartScreen;
  level = map_choice;
  startButton = new Button((gamewidth-button_w)/2, startButton_Y+140, button_w, button_h, "Start", button_textSize);
  levelButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 1+140, button_w, button_h, "Level", button_textSize);
  recordButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 2+140, button_w, button_h, "Ranking", button_textSize);
  helpButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 3+140, button_w, button_h, "Help", button_textSize);
  exitButton = new Button((gamewidth-button_w)/2, startButton_Y + button_gap * 4+140, button_w, button_h, "Exit", button_textSize);
  endButton = new Button((gamewidth-button_w)/2*0.3-10, (gameheight-button_h-200)/2+240, button_w*2.5, button_h, "Return to main menu", button_textSize);

  leveldownButton = new Button((gamewidth-button_w)/2 - 200, startButton_Y + button_gap * 2, button_w, button_h, "PREV", button_textSize);
  levelupButton = new Button((gamewidth-button_w)/2 + 200, startButton_Y + button_gap * 2, button_w, button_h, "NEXT", button_textSize);
  levelenterButton = new Button(gamewidth - 400, gameheight - 200, button_w, button_h, "Confirm", button_textSize);

  cancelButton = new Button(gamewidth * 0.8, gameheight - 120, button_w, button_h, "Back", button_textSize);

  pauseContinueButton = new Button((gamewidth-button_w)/2*0.4 - 100, startButton_Y + button_gap * 2, button_w*1.2, button_h, "Continue", button_textSize);
  pauseCancelButton = new Button((gamewidth-button_w)/2*0.8 + 60, startButton_Y + button_gap * 2, button_w*1.2, button_h, "End Game", button_textSize);

  GRM = new GameRecordManager("game_records.txt");
  sprites = loadImage("src/spriteSheet.png");
  loadSounds();

  animPacman = new AnimationPacman(160, 750, 400);
  animGhosts = new AnimationGhosts(1050, 650, 101);
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
  switch (gamemod) {
    case StartScreen:
      if (key == ESC) {
        key = 0; // Prevent exit
      }
      break;
    
    case gameInProgress:
        if (key >= '1' && key <= '4') {
          int blockType = key - '0';
          gameMap.changeBlock(blockType);
        }
        if (keyCode == 32 || key == ESC) {
          gameMap.pause();
          key = 0; // Prevent exit
        }
        break;
  
    case gameLevel:
        if (key >= '1' && key < '1' + max_level) {
          level = key - '1';
        }
        if (key == ESC) {
          key = 0; // Prevent exit
          gamemod = StartScreen;
        }
        break;
        
    case gameRecord:
        if (key == ESC) {
          key = 0; // Prevent exit
          gamemod = StartScreen;
        }
        break;
        
    case gameHelp:
        if (key == ESC) {
          key = 0; // Prevent exit
          gamemod = StartScreen;
        }
        break;
  }
}

void mouseClicked() {
  if (gamemod == StartScreen) {
    if (startButton.clicked()) {
      GAME_RUNNING = true;
      gamemod = gameInProgress;
      gameMap = new GameMap(cellSize); // Assuming each cell is 40 pixels
      gameMap.setMap();
      pf = new Pathfinder(gameMap);
      myPacman = new Pacman(PACMAN_HOME[0], PACMAN_HOME[1], pf, gameMap); // Pacman starts at grid position (1, 1) and knows about the game map
      ghost1 = new Blinky(12, 14, pf, gameMap, myPacman);
      ghost2 = new Inky(13, 14, pf, gameMap, myPacman);
      ghost3 = new Pinky(14, 14, pf, gameMap, myPacman);
      ghost4 = new Clyde(15, 14, pf, gameMap, myPacman);
      ghosts = new Ghost[] {ghost1, ghost2, ghost3, ghost4};

      initGame();
      
      pause = false;
      gameended = false;
      current_speed = 2;
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
      if (gameMap.block_type == 4) {
        if ((gameMap.map[gridY][gridX] == 3 || gameMap.map[gridY][gridX] == 0) && gameMap.money > 40) {
          gameMap.transport(gridX, gridY);
        }
      } else {
        gameMap.setWall(gridX, gridY);
      }
    }
    if (mouseX >= 1550 && mouseX < 1630 && mouseY >= 10 && mouseY < 90) {
      gameMap.pause();
    }
    if (mouseX >= 1120 && mouseX < 1240 && mouseY >= 574 && mouseY < 700) {
      gameMap.changeBlock(1);
    }
    if (mouseX >= 1250 && mouseX < 1370 && mouseY >= 574 && mouseY < 700) {
      gameMap.changeBlock(2);
    }
    if (mouseX >= 1380 && mouseX < 1500 && mouseY >= 574 && mouseY < 700) {
      gameMap.changeBlock(3);
    }
    if (mouseX >= 1510 && mouseX < 1630 && mouseY >= 574 && mouseY < 700) {
      gameMap.changeBlock(4);
    }
    if (pause == true) {
      if (pauseContinueButton.clicked()) {
        pause = false;
        return;
      }
      if (pauseCancelButton.clicked()) {
        endgame();
        gamemod = StartScreen;
        return;
      }
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
