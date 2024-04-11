import javax.swing.JOptionPane;

boolean GAME_RUNNING = true;
int GHOST_STATE = SCATTER;
int lastWave = 20000;
final int TOTAL_WAVES = 5;
final int TOTAL_DOTS = 244;

void menu() {
  background(0);
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
  ghost1.freeze(true);
  ghost2.freeze(true);
  ghost3.freeze(true);
  ghost4.freeze(true);
  
  int waveTime = millis();
  int wave = 0;
  
  if ( GAME_RUNNING ) {
    
    println(waveTime);
    println("Wave = " + wave);
    println("Ghost state = " + GHOST_STATE);
    println("Ghost1 state = " + ghost1.state);
    
    // Check game over
    if ( myPacman.lives == 0 ) {
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
        println("CHASE");
      }
      else if ( waveTime - lastWave > 20000 && GHOST_STATE == CHASE ) {
        ghost1.setState(SCATTER);
        ghost2.setState(SCATTER);
        ghost3.setState(SCATTER);
        ghost4.setState(SCATTER);
        lastWave += 20000;
        GHOST_STATE = SCATTER;
        println("SCATTER");
      }
      println("last wave = " + lastWave);
      wave++;
    }
    
    // Release ghosts
    releaseNextGhost();
    if ( myPacman.currentDotsEaten >= (int) (0.25 * TOTAL_DOTS) ) {
      println("EATEN DOTS 1");
      releaseNextGhost();
    }
    else if ( myPacman.currentDotsEaten >= (int) (0.5 * TOTAL_DOTS) ) {
      releaseNextGhost();
      increaseSpeed();
      println("EATEN DOTS 2");
    }
    else if ( myPacman.currentDotsEaten >= (int) (0.75 * TOTAL_DOTS) ) {
      releaseNextGhost();
      println("EATEN DOTS 3");
    }
    
    // Draw map
    background(0);
    gameMap.drawMap();
    myPacman.draw();
    ghost1.draw();
    ghost2.draw();
    ghost3.draw();
    ghost4.draw();
    
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
    text("GAME OVER" , gamewidth/2 -200, gameheight/2 - 400);
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
    String playerName = "Player";
    playerName = JOptionPane.showInputDialog(null, "Please enter your name:", playerName);
    if (playerName == null) {
      playerName = "Player";
    } else if (playerName.trim().isEmpty()) {
      playerName = "Player";
    }
    playerName = playerName.replace(",", "").replace("\n", "");
    GRM.saveRecord(playerName);
    gameended = true;
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
  String hinttext = "Click the left and right arrows or enter the number directly(maximum 5) to select the difficulty.";
  text(hinttext, (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2+400);
  return;
}

void recordmenu() {
  background(0);
  // Help
  textAlign(CENTER, CENTER);
  fill(200, 100, 200);
  textSize(100);
  text("Record // TODO", (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2-200);
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
void increaseSpeed() {
  
   myPacman.speed += 2;
   
   for ( int i = 0; i < ghosts.length; i++ ) {
    ghosts[i].speed += 2;
  }
}
