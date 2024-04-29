import javax.swing.JOptionPane;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;

boolean GAME_RUNNING = true;
int GHOST_STATE = SCATTER;
int lastWave = 20000;
float current_speed = 2;
final int TOTAL_WAVES = 5;
final int TOTAL_DOTS = 244;
PImage bg;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage help;

void menu() {
  background(0);
  if (!startMenuSound.isPlaying()) {
    startMenuSound.play();
  }
  bg = loadImage("assets/Background.png");
  bg.resize(1400, 1240);
  image(bg, 120, 0);
  // Animations
  animPacman.display();
  animGhosts.display();

  // Pictures
  img1 = loadImage("assets/PacmanTitle.png");
  img1.resize(1250, 300);
  image(img1, (1640-1250)/2, 100);
  img2 = loadImage("assets/SaviorTitle.png");
  img2.resize(672, 130);
  image(img2, (1640-672)/2, 380);
  // img3 = loadImage("assets/Pacman.png");
  // img3.resize(300, 300);
  // image(img3, 160, 750);
  // img4 = loadImage("src/ghosts1.png");
  // img4.resize(500, 600);
  // image(img4, 1050, 600);
  // Buttons
  startButton.display();
  levelButton.display();
  recordButton.display();
  helpButton.display();
  exitButton.display();
}

void maingame() {
  // Update the status of each role
  //statusUpdate();
  // Draw
  if (!startMenuSound.isPlaying()) {
    startMenuSound.play();
  }
  // Initialise ghosts
  ghost1.freeze(true);
  ghost2.freeze(true);
  ghost3.freeze(true);
  ghost4.freeze(true);

  int waveTime = millis();
  int wave = 0;

  if ( GAME_RUNNING ) {

    // Check game over
    if ( myPacman.lives == 0 || !gameMap.dotsRemaining()) {
      println("DEBUG: here");
      GAME_RUNNING = false;
    }

    // Set wave
    if ( wave < TOTAL_WAVES ) {
      if ( waveTime - lastWave > 15000 && GHOST_STATE == SCATTER ) {
        ghost1.setState(CHASE);
        ghost2.setState(CHASE);
        ghost3.setState(CHASE);
        ghost4.setState(CHASE);
        lastWave += 15000;
        GHOST_STATE = CHASE;
      } else if ( waveTime - lastWave > 20000 && GHOST_STATE == CHASE ) {
        ghost1.setState(SCATTER);
        ghost2.setState(SCATTER);
        ghost3.setState(SCATTER);
        ghost4.setState(SCATTER);
        lastWave += 20000;
        GHOST_STATE = SCATTER;
      }
      wave++;
    }

    // Release ghosts
    releaseNextGhost();
    if ( myPacman.currentDotsEaten >= (10 * (5 - level) * 1) ) {
      releaseNextGhost();
      myPacman.changeSpeed(3);
      current_speed = 3;
    }
    if ( myPacman.currentDotsEaten >= (10 * (5 - level) * 2) ) {
      releaseNextGhost();
      myPacman.setState(EFFICIENT_EVADE);
      myPacman.changeSpeed(4);
      current_speed = 4;
    }
    if ( myPacman.currentDotsEaten >= (10 * (5 - level) * 3) ) {
      releaseNextGhost();
      myPacman.setState(CHASE_DOT);
      myPacman.changeSpeed(5);
      current_speed = 5;
    }

    // Draw map
    background(0);
    gameMap.drawMap();
    myPacman.draw();

    ghost1.changeSpeed(current_speed);
    ghost2.changeSpeed(current_speed);
    ghost3.changeSpeed(current_speed);
    ghost4.changeSpeed(current_speed);
    if (gameMap.checkSlow() && !gameMap.checkStop()) {
      ghost1.changeSpeed(ghost1.speed / 2);
      ghost2.changeSpeed(ghost2.speed / 2);
      ghost3.changeSpeed(ghost3.speed / 2);
      ghost4.changeSpeed(ghost4.speed / 2);
    }
    if (gameMap.checkStop()) {
      ghost1.changeSpeed(0);
      ghost2.changeSpeed(0);
      ghost3.changeSpeed(0);
      ghost4.changeSpeed(0);
    }
    ghost1.draw();
    ghost2.draw();
    ghost3.draw();
    ghost4.draw();
    if (pause) {
      pauseMenu();
    }

    // Reset pacman
    if ( ghost1.caughtTarget() || ghost2.caughtTarget() || ghost3.caughtTarget() || ghost4.caughtTarget() ) {
      caughtSound.play();
      myPacman.lives--;
      myPacman.setDirection(LEFT);
      myPacman.setState(EVADE);
      myPacman.setPosition(PACMAN_HOME[0], PACMAN_HOME[1]);
      
      // Set ghost state to SCATTER to avoid spawn camping
      ghost1.setState(SCATTER);
      ghost2.setState(SCATTER);
      ghost3.setState(SCATTER);
      ghost4.setState(SCATTER);
    }
  }

  if ( !GAME_RUNNING ) {
    gamemod = gameOver;
    textAlign(CENTER, CENTER);
    textSize(100);
    if (gameMap.dotsRemaining()) {
      fill(255, 0, 0);
      gameOverSound.play();
      text("GAME OVER", gamewidth/2 - 260, gameheight/2 - 400);
    } else {
      fill(255, 255, 0);
      youWinSound.play();
      text("YOU WIN", gamewidth/2 - 260, gameheight/2 - 400);

      // if(level<4) {
      //   level += 1;
      // }
      // initGame();
    }
    int finalScore = (gameMap.score + gameMap.money * 10) * (1 + level / 10);
    fill(255);
    textSize(80);
    text("FINAL SCORE  " + finalScore, gamewidth/2 - 260, gameheight/2 - 240);
    endButton.display();
  }
}

void statusUpdate() {
  //myPacman.togglePacmanState();
  //ghost1.toggleGhostState();
  //ghost2.toggleGhostState();
}

void endgame() {
  if (!gameended) {
    gameended = true;
    String playerName = "Player";
    playerName = JOptionPane.showInputDialog(null, "Please enter your name:", playerName);
    if (playerName == null) {
      return;
    } else if (playerName.trim().isEmpty()) {
      playerName = "Player";
    }
    playerName = playerName.replace(",", "").replace("\n", "");
    GRM.saveRecord(playerName);
    return;
  } else {
    endButton.display();
  }
}

void chooselevel() {
  background(0);
  if (!startMenuSound.isPlaying()) {
    startMenuSound.play();
  }
  // LEVEL
  textAlign(CENTER, CENTER);
  fill(200, 100, 200);
  textSize(button_textSize*2);
  text("L E V E L", (gamewidth-button_w)/2 + gamewidth/10, (gameheight-button_h)/2-gameheight/4);
  // Level number
  if (level == 0) {
    fill(33, 33, 222);
  } else if (level == 1) {
    fill(69, 60, 182);
  } else if (level == 2) {
    fill(48, 117, 141);
  } else if (level == 3) {
    fill(47, 130, 76);
  } else {
    fill(158, 74, 124);
  }
  textSize(button_textSize*2);
  text(level + 1, (gamewidth-button_w)/2 + gamewidth/10, (gameheight-button_h)/2-gameheight/10);
  textSize(button_textSize/5*6);
  text("Final score x 1." + level, (gamewidth-button_w)/2+ + gamewidth/10, (gameheight-button_h)/2+gameheight/60);
  // Buttons
  levelupButton.display();
  leveldownButton.display();
  levelenterButton.display();
  // Hint
  fill(80, 80, 80);
  textSize(button_textSize*3/5);
  String hinttext = "Click PREV or NEXT  or  Enter a number from 1 to 5 to select level";
  text(hinttext, (gamewidth-button_w)/2+ gamewidth/10, (gameheight-button_h)/2+gameheight*340/1200);
  text("Higher level means higher difficulty and higher score", (gamewidth-button_w)/2+ gamewidth/10, (gameheight-button_h)/2+gameheight*380/1200);
  return;
}

void recordmenu() {
  background(0);
  if (!startMenuSound.isPlaying()) {
    startMenuSound.play();
  }
  // Help
  List<String> records = GRM.loadRecords();
  drawLeaderboard(records, gamewidth*0.2, gameheight*0.1);

  // Buttons
  cancelButton.display();
  return;
}

void helpmenu() {
  background(0);
  if (!startMenuSound.isPlaying()) {
    startMenuSound.play();
  }
  // Help
  help = loadImage("assets/Help.png");
  help.resize(1640, 1240);
  image(help, 0, 0);
  // Buttons
  cancelButton.display();
  return;
}

void pauseMenu() {
  fill(20, 20, 20);
  rect(375, 540, 460, 80);
  fill(255);
  textSize(80);
  text("GAME PAUSE", 230, 605);
  pauseContinueButton.display();
  pauseCancelButton.display();
  // textAlign(LEFT, BASELINE);
}


// ---------------------------------------------------------------------------------------------------------------------


// Initialise game settings
void initGame() {
  GAME_RUNNING = true;
  gamemod = gameInProgress;
  gameMap = new GameMap(cellSize); // Assuming each cell is 40 pixels
  gameMap.setMap();
  map_choice = level;
  if (!gameMap.setMap()) {
    gamemod = StartScreen;
    println("An error occurred while initializing the map");
    return;
  }
  pf = new Pathfinder(gameMap);
  myPacman = new Pacman(PACMAN_HOME[0], PACMAN_HOME[1], pf, gameMap); // Pacman starts at grid position (1, 1) and knows about the game map
  ghost1 = new Blinky(12, 14, pf, gameMap, myPacman);
  ghost2 = new Inky(13, 14, pf, gameMap, myPacman);
  ghost3 = new Pinky(14, 14, pf, gameMap, myPacman);
  ghost4 = new Clyde(15, 14, pf, gameMap, myPacman);
  ghosts = new Ghost[] {ghost1, ghost2, ghost3, ghost4};

  myPacman.setDirection(LEFT);
  myPacman.setState(EVADE);

  for ( int i = 0; i < ghosts.length; i++ ) {
    ghosts[i].setDirection(UP);
    ghosts[i].setState(SCATTER);
    ghosts[i].setTarget(myPacman);
    ghosts[i].setScatterCorner(i);
    ghosts[i].setScatterPath(scatterPaths1);
    ghosts[i].initialiseScatter();

    if ( ghosts[i] instanceof Inky ) {
      ghosts[i].setGhost(ghosts[0]);
    }
  }

  pause = false;
  gameended = false;
  current_speed = 2;
}


// Allow next ghost to move
void releaseNextGhost() {

  for ( int i = 0; i < ghosts.length; i++ ) {
    if ( ghosts[i].freeze == true ) {
      ghosts[i].freeze(false);
      return;
    }
  }
}


void drawLeaderboard(List<String> records, float x, float y) {
  textAlign(LEFT, TOP);
  // textAlign(CENTER, CENTER);

  fill(200, 255, 200);
  textSize(button_textSize*2);
  text("Leaderboard", x + gamewidth*0.05-80, y-60);
  y += button_textSize*2.5;

  fill(100, 150, 200);
  textSize(button_textSize*1.2);
  text("No", x - gamewidth * 0.15, y);
  text("Name", x + gamewidth * 0.0, y);
  text("Score", x + gamewidth * 0.3, y);
  text("Date", x + gamewidth * 0.6, y);

  textSize(button_textSize*1.2);
  y += button_textSize*2.5;

  if (records.size() == 0) {
    text(" -\\-", x - gamewidth * 0.15, y);
    text(" -\\-", x + gamewidth * 0.0, y);
    text("  -\\-", x + gamewidth * 0.3, y);
    text(" -\\-", x + gamewidth * 0.6, y);
    return;
  }
  for (int i = 0; i < records.size(); i++) {
    if (i == 0) {
      fill(255, 215, 0);
    } else if (i == 1) {
      fill(192, 192, 192);
    } else if (i == 2) {
      fill(184, 115, 51);
    } else {
      fill(100, 150, 200);
    }
    String[] parts = records.get(i).split(",");
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat outputFormat = new SimpleDateFormat("MM-dd");
    String formattedDate = "  -  ";
    try {
      Date date = inputFormat.parse(parts[2].trim());
      formattedDate = outputFormat.format(date);
    }
    catch (ParseException e) {
      e.printStackTrace();
      text("Invalid date", x + 700, y);
    }

    text((i + 1) + ".", x - gamewidth * 0.15, y);
    text(truncateString(parts[0].trim(), 11), x + gamewidth * 0.0, y);
    text(parts[1].trim(), x + gamewidth * 0.3, y);
    text(formattedDate, x + gamewidth * 0.6, y);

    y += button_textSize*3;
  }
}
