import javax.swing.JOptionPane;

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
  background(0);
  gameMap.drawMap();
  myPacman.draw();
  ghost1.draw();
  //ghost2.draw();
  
  if (ghost1.caughtTarget()) {
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
