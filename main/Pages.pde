void menu() {
  startButton.display();
  levelButton.display();
  recordButton.display();
  helpButton.display();
  exitButton.display();
}

void maingame() {
  gameMap.drawMap();
  myPacman.drawPacman();
  ghost1.drawBlinky();
  ghost2.drawPinky();
  
  //println(ghost2.caughtPacman);
  if ( ghost1.caughtPacman || ghost2.caughtPacman ) {
    gamemod = gameOver;
    gameMap.drawMap();

    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    textSize(100);
    text("GAME OVER" , gamewidth/2 -200, gameheight/2 - 400);
    endButton.display();

    // finalscore = score + money*10;
  }
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

void helpmenu() {
  background(0);
  // Help
  textAlign(CENTER, CENTER);
  fill(200, 100, 200);
  textSize(100);
  text("Help // TODO", (gamewidth-button_w)/2+ 150, (gameheight-button_h)/2-200);
  // Buttons
  helpcancelButton.display();
  return;
}