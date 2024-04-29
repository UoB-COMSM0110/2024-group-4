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
SpeedUpButton speedUpButton;

Button levelupButton;
Button leveldownButton;
Button levelenterButton;

Button cancelButton;

Button pauseContinueButton;
Button pauseCancelButton;

final int gamewidth = 1600;
final int gameheight = 1200;
final int button_w = gamewidth / 16 * 3;
final int button_h = button_w / 3;
final int button_textSize = gamewidth / 32;
final int startButton_X = (gamewidth-button_w)/2+22;
final int startButton_Y = (gameheight-button_h)/2 - gamewidth / 16 + gamewidth * 14 / 160;
final int button_gap = button_h + button_h / 5;
final int levelAdjustButtonY = startButton_Y - gamewidth * 14 / 160 + button_gap * 2;

final int cellSize = gamewidth / 40;

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
  startButton = new Button(startButton_X, startButton_Y, button_w, button_h, "Start", button_textSize);
  levelButton = new Button(startButton_X, startButton_Y + button_gap * 1, button_w, button_h, "Level", button_textSize);
  recordButton = new Button(startButton_X, startButton_Y + button_gap * 2, button_w, button_h, "Ranking", button_textSize);
  helpButton = new Button(startButton_X, startButton_Y + button_gap * 3, button_w, button_h, "Help", button_textSize);
  exitButton = new Button(startButton_X, startButton_Y + button_gap * 4, button_w, button_h, "Exit", button_textSize);
  endButton = new Button(startButton_X*3/10-gamewidth/160, (gameheight-button_h-200)/2, button_w*2.5, button_h, "Return to main menu", button_textSize);
  speedUpButton = new SpeedUpButton(gamewidth*0.8, gameheight*0.9, button_w, button_h, "Double Speed", button_textSize);

  leveldownButton = new Button(startButton_X - button_w * 2 / 3, levelAdjustButtonY, button_w, button_h, "PREV", button_textSize);
  levelupButton = new Button(startButton_X + button_w * 2 / 3, levelAdjustButtonY, button_w, button_h, "NEXT", button_textSize);
  levelenterButton = new Button(gamewidth*0.75, gameheight*5/6, button_w, button_h, "Confirm", button_textSize);

  cancelButton = new Button(gamewidth*0.8+40, gameheight*0.9+40, button_w, button_h, "Back", button_textSize);

  pauseContinueButton = new Button(startButton_X*0.4 - gamewidth/16, startButton_Y + button_gap * 2, button_w*1.2, button_h, "Continue", button_textSize);
  pauseCancelButton = new Button(startButton_X*0.8 + gamewidth*6/160, startButton_Y + button_gap * 2, button_w*1.2, button_h, "End Game", button_textSize);

  GRM = new GameRecordManager("game_records.txt");
  sprites = loadImage("src/spriteSheet.png");
  loadSounds();

  animPacman = new AnimationPacman(gamewidth/10, gameheight*5/8, 400);
  animGhosts = new AnimationGhosts(gamewidth*1050/1600+10, gameheight*650/1200, 101);
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
      initGame();
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
    gameMap.clicked();
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
