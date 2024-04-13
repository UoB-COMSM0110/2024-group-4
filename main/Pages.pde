import javax.swing.JOptionPane;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;

boolean GAME_RUNNING = true;
int GHOST_STATE = SCATTER;
int GHOSTS_RELEASED = 0;
int lastWave = 20000;
final int TOTAL_WAVES = 5;
final int TOTAL_DOTS = 244;
PImage bg;
PImage img1;
PImage img2;
PImage img3;
PImage img4;

void menu() {
  background(0);
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

  // Initialise ghosts
  if ( GHOSTS_RELEASED == 0 ) {
    ghost1.freeze(true);
    ghost2.freeze(true);
    ghost3.freeze(true);
    ghost4.freeze(true);
  }

  int waveTime = millis();
  int wave = 0;

  if ( GAME_RUNNING ) {

    // Check game over
    if ( myPacman.lives == 0 ) {
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
    ghost1.freeze(false);
    if ( GHOSTS_RELEASED == 0 ) {
      GHOSTS_RELEASED++;
    }
    if ( GHOSTS_RELEASED == 1 && myPacman.currentDotsEaten >= (int) (0.25 * TOTAL_DOTS) ) {
      ghost2.freeze(false);
      if ( myPacman.speed == 2 ) {
        increaseSpeed(myPacman, 2);
      }
      if ( ghost1.speed == 2 ) {
        increaseSpeed(ghost1, 2);
      }
      if ( ghost2.speed == 2 ) {
        increaseSpeed(ghost2, 2);
      }
      if ( ghost3.speed == 2 ) {
        increaseSpeed(ghost3, 2);
      }
      if ( ghost4.speed == 2 ) {
        increaseSpeed(ghost4, 2);
      }
      updateGhostsReleased(4);
    } else if ( GHOSTS_RELEASED == 2 && myPacman.currentDotsEaten >= (int) (0.5 * TOTAL_DOTS) ) {
      ghost3.freeze(false);
      if ( myPacman.speed == 4 ) {
        increaseSpeed(myPacman, 1);
      }
      if ( ghost1.speed == 4 ) {
        increaseSpeed(ghost1, 1);
      }
      if ( ghost2.speed == 4 ) {
        increaseSpeed(ghost2, 1);
      }
      if ( ghost3.speed == 4 ) {
        increaseSpeed(ghost3, 1);
      }
      if ( ghost4.speed == 4 ) {
        increaseSpeed(ghost4, 1);
      }
      updateGhostsReleased(5);
    } if ( GHOSTS_RELEASED == 3 && myPacman.currentDotsEaten >= (int) (0.75 * TOTAL_DOTS) ) {
      ghost4.freeze(false);
      if ( myPacman.speed == 5 ) {
        increaseSpeed(myPacman, 3);
      }
      if ( ghost1.speed == 5 ) {
        increaseSpeed(ghost1, 3);
      }
      if ( ghost2.speed == 5 ) {
        increaseSpeed(ghost2, 3);
      }
      if ( ghost3.speed == 5 ) {
        increaseSpeed(ghost3, 3);
      }
      if ( ghost4.speed == 5 ) {
        increaseSpeed(ghost4, 3);
      }
      updateGhostsReleased(8);
    }

    // Draw map
    background(0);
    gameMap.drawMap();
    myPacman.draw();
    ghost1.draw();
    ghost2.draw();
    ghost3.draw();
    ghost4.draw();
    if (pause) {
      pauseMenu();
    }

    // Reset pacman
    if ( ghost1.caughtTarget() || ghost2.caughtTarget() || ghost3.caughtTarget() || ghost4.caughtTarget() ) {
      myPacman.lives--;
      myPacman.setDirection(LEFT);
      myPacman.setState(EVADE);
      myPacman.setPosition(PACMAN_HOME[0], PACMAN_HOME[1]);
    }
  }

  if ( !GAME_RUNNING ) {
    gamemod = gameOver;
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    textSize(100);
    text("GAME OVER", gamewidth/2 - 250, gameheight/2 - 400);
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
  }
}

void chooselevel() {
  background(0);
  // LEVEL
  textAlign(CENTER, CENTER);
  fill(200, 100, 200);
  textSize(100);
  text("L E V E L", (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2-200);
  // Level number
  fill(0, 100, 200);
  textSize(100);
  text(level + 1, (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2);
  // Buttons
  levelupButton.display();
  leveldownButton.display();
  levelenterButton.display();
  // Hint
  fill(80, 80, 80);
  textSize(30);
  String hinttext = "Click PREV or NEXT  or  Enter a number from 1 to 5 to select level";
  text(hinttext, (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2+340);
  text("Higher level means higher difficulty and higher score", (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2+380);
  return;
}

void recordmenu() {
  background(0);
  // Help
  List<String> records = GRM.loadRecords();
  drawLeaderboard(records, gamewidth*0.2, gameheight*0.1);

  // Buttons
  cancelButton.display();
  return;
}

void helpmenu() {
  background(0);
  // Help
  textAlign(CENTER, CENTER);
  fill(200, 100, 200);
  textSize(100);
  text("Help // TODO", (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2-200);
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


// Increases speed for all Entities
void increaseSpeed(Entity e, int speedIncrease) {

  if ( ( e.x == e.col * gameMap.cellSize ) && ( e.y == e.row * gameMap.cellSize ) ) {
    e.speed += speedIncrease;
  }
}


// Update GHOSTS_RELEASED only after all Entities speed has been updated
void updateGhostsReleased(int speed) {
  
  if ( myPacman.speed == speed && ghost1.speed == speed && ghost2.speed == speed && ghost3.speed == speed && ghost4.speed == speed ) {
    GHOSTS_RELEASED++;
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
