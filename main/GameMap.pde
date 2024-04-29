final int dot = 3;
final int eat_dot = 0;
final int empty_grid = 0;
final int wall = 1;
int tmp_wall = 2;
final int basic_score = 10;
final int bigScore = 300;
final int wallstack_deep = 3;
boolean pause = false;

int map_choice = 0;
int PORTAL = 7;
int BIG_DOT = 5;
int GHOST_HOME = 6;
final int[] blockwall = {2, 4, 6};
final int[] price = {10, 50, 150, 50};

final int[] pathList = {empty_grid, dot, BIG_DOT, blockwall[0], blockwall[1], blockwall[2]};

class GameMap {
  int cellSize; // Cell size
  int dotSize;
  int distance;
  int block_type = 1;

  int[][] map = deepCopy2D(map1);
  // player can build 3 walls
  int[][] wallstack={
    {-1, -1},
    {-1, -1},
    {-1, -1},
  };
  int wallindex;
  int score = 0;
  int money = 100;

  final int COLUMNS = 28;  // x
  final int RAWS = 31; // y

  Block block1;
  Block block2;
  Block block3;
  Block block4;
  PauseButton pauseButton;
  SpeedUpButton doubleSpeedButton;

  // Constructor
  GameMap(int cellSize) {
    this.cellSize = cellSize;
    this.dotSize = cellSize / 4;
    this.distance = (cellSize - dotSize) / 2;
    this.wallindex = 0;

    int[] rgb1 = {22, 22, 148};
    block1 = new Block(1121, 580, 120, 120, rgb1);
    int[] rgb2 = {135, 206, 250};
    block2 = new Block(1251, 580, 120, 120, rgb2);
    int[] rgb3 = {255, 255, 255};
    block3 = new Block(1381, 580, 120, 120, rgb3);
    int[] rgb4 = {255, 255, 0};
    block4 = new Block(1511, 580, 120, 120, rgb4);

    pauseButton = new PauseButton(1550, 10, cellSize*2, cellSize*2);
    doubleSpeedButton = new SpeedUpButton(gamewidth*0.75, gameheight*0.92, 1.2 * button_w, button_h, "Speed up", button_textSize);
  }

  boolean setMap() {
    final int[][][] mapList = {map1, map2, map3, map4, map5};
    this.map = deepCopy2D(mapList[map_choice]);
    if (map[0].length != this.COLUMNS || map.length != this.RAWS) {
      println("ERROR: Incorrect map size. Expected columns: " + this.COLUMNS 
              + ", received: " + map[0].length 
              + ". Expected rows: " + this.RAWS 
              + ", received: " + map.length + ".");
      return false;
    }
    return true;
  }

  void clearGrid(int x, int y) {
    map[y][x] = empty_grid;
  }

  // Method to check if a move to a new position is possible
  boolean checkMove(int x, int y) {
    // Ensure the move is within the bounds of the map
    if (x < 1 || x >= map[0].length || y < 1 || y >= map.length) {
      return false;
    }
    return map[y][x] != wall && map[y][x] != 2 && map[y][x] != 4 && map[y][x] != 6; // make sure next move won't go into a wall
  }

  // Method to draw the map
  void drawMap() {
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (map[i][j] == wall) {
          if (map_choice == 0) {
            stroke(33, 33, 222); // Wall color
          } else if (map_choice == 1) {
            stroke(69, 60, 182); // Wall color
          } else if (map_choice == 2) {
            stroke(48, 117, 141); // Wall color
          } else if (map_choice == 3) {
            stroke(47, 130, 76); // Wall color
          } else {
            stroke(158, 74, 124); // Wall color
          }
          strokeWeight(10);

          final int margin = cellSize/4;
          int x1, x2, y1, y2;

          // check up
          if (containsElement(pathList, map[max(0, i-1)][j])) { // Up is pathway
            x1 = j * cellSize;
            y1 = i * cellSize + margin; // Move the upper horizontal line down a few pixels
            x2 = x1 + cellSize;
            y2 = y1;      // Align y1, y2
            
            if (containsElement(pathList, map[i][max(0, j-1)])){ // Left is pathway
              x1 += margin; // Shorten the left end
            } else if (containsElement(pathList, map[i][min(j+1, this.COLUMNS-1)])) { // Right is pathway
              x2 -= margin; // Shorten the right end
            } else { // Both sides are walls
              x1 -= margin * int(map[max(0, i-1)][j-1] == wall); // Stretch the left end if upper left is wall
              x2 += margin * int(map[max(0, i-1)][j+1] == wall); // Stretch the right end if upper right is wal
            }
            
            line(x1, y1, x2, y2);
          }

          // check down
          if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
            if (map[i][max(0, j-1)] == 3 || map[i][max(0, j-1)] == 0 || map[i][max(0, j-1)] == 2 || map[i][max(0, j-1)] == 4 || map[i][max(0, j-1)] == 6 || map[i][max(0, j-1)] == 5) {
              line(j * cellSize+10, (i+1) * cellSize-10, (j+1) * cellSize+10, (i+1) * cellSize-10);
            } else if (map[i][min(j+1, map[0].length-1)] == 3 || map[i][min(j+1, map[0].length-1)] == 0 || map[i][min(j+1, map[0].length-1)] == 2 || map[i][min(j+1, map[0].length-1)] == 4 || map[i][min(j+1, map[0].length-1)] == 6 || map[i][min(j+1, map[0].length-1)] == 5) {
              line(j * cellSize-10, (i+1) * cellSize-10, (j+1) * cellSize-10, (i+1) * cellSize-10);
            } else {
              if (map[min(i+1, map.length-1)][j-1] == 1) {
                line(j * cellSize-10, (i+1) * cellSize-10, (j+1) * cellSize, (i+1) * cellSize-10);
              } else if (map[min(i+1, map.length-1)][j+1] == 1) {
                line(j * cellSize, (i+1) * cellSize-10, (j+1) * cellSize+10, (i+1) * cellSize-10);
              } else {
                line(j * cellSize, (i+1) * cellSize-10, (j+1) * cellSize, (i+1) * cellSize-10);
              }
            }
          }

          // check left
          if (map[i][max(0, j-1)] == 3 || map[i][max(0, j-1)] == 0 || map[i][max(0, j-1)] == 2 || map[i][max(0, j-1)] == 4 || map[i][max(0, j-1)] == 6 || map[i][max(0, j-1)] == 5) {
            if (map[max(0, i-1)][j] == 3 || map[max(0, i-1)][j] == 0 || map[max(0, i-1)][j] == 2 || map[max(0, i-1)][j] == 4 || map[max(0, i-1)][j] == 6 || map[max(0, i-1)][j] == 5) {
              line(j * cellSize+10, i * cellSize+10, j * cellSize+10, (i+1) * cellSize);
            } else if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
              line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize-10);
            } else {
              if (map[i-1][max(0, j-1)] == 1) {
                line(j * cellSize+10, i * cellSize-10, j * cellSize+10, (i+1) * cellSize+10);
              } else if (map[i+1][max(0, j-1)] == 1) {
                line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize+10);
              } else {
                line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize+10);
              }
            }
          }

          //check right
          if (map[i][min(j+1, map[0].length-1)] == 3 || map[i][min(j+1, map[0].length-1)] == 0 || map[i][min(j+1, map[0].length-1)] == 2 || map[i][min(j+1, map[0].length-1)] == 4 || map[i][min(j+1, map[0].length-1)] == 6 || map[i][min(j+1, map[0].length-1)] == 5) {
            if (map[max(0, i-1)][j] == 3 || map[max(0, i-1)][j] == 0 || map[max(0, i-1)][j] == 2 || map[max(0, i-1)][j] == 4 || map[max(0, i-1)][j] == 6 || map[max(0, i-1)][j] == 5) {
              line((j+1) * cellSize-10, i * cellSize+10, (j+1) * cellSize-10, (i+1) * cellSize);
            } else if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
              line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize-10);
            } else {
              if (map[i-1][min(j+1, map[0].length-1)] == 1) {
                line((j+1) * cellSize-10, i * cellSize-10, (j+1) * cellSize-10, (i+1) * cellSize+10);
              } else if (map[i+1][min(j+1, map[0].length-1)] == 1) {
                line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize+10);
              } else {
                line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize+10);
              }
            }
          }
          noStroke();
        }
        if (map[i][j] == blockwall[0]) {
          fill(22, 22, 148);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == blockwall[1]) {
          fill(135, 206, 250);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == blockwall[2]) {
          fill(255);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == dot) {
          fill(245, 191, 147); // Dot color
          rect(j * cellSize + distance, i * cellSize + distance, dotSize, dotSize); // Draw dots
        }
        if (map[i][j] == PORTAL) {
          fill(135, 206, 250); // Dot color
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, 50, 50);
          fill(22, 22, 148);
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, 37, 37);
          fill(135, 206, 250); // Dot color
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, 24, 24);
          fill(22, 22, 148);
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, 11, 11);
        }
        if (map[i][j] == BIG_DOT) {
          fill(245, 191, 147); // Dot color
          ellipse(j * cellSize + cellSize / 2, i * cellSize + cellSize / 2, 20, 20);
        }
      }
    }

    // Hover
    int gridX = mouseX / cellSize;
    int gridY = mouseY / cellSize;

    if (gridX >= 0 && gridX < 1120/cellSize && gridY >= 0 && gridY < 1240/cellSize) {
      if (map[gridY][gridX] == dot || map[gridY][gridX] == empty_grid) {
        if (block_type == 1) {
          fill(22, 22, 148);
        } else if (block_type == 2) {
          fill(135, 206, 250);
        } else if (block_type == 3) {
          fill(255);
        } else {
          fill(255, 255, 0);
        }
        rect(gridX * cellSize+5, gridY * cellSize+5, cellSize*0.75, cellSize*0.75);
      }
    }

    // draw edges
    if (map_choice == 0) {
      stroke(33, 33, 222); // Wall color
    } else if (map_choice == 1) {
      stroke(69, 60, 182); // Wall color
    } else if (map_choice == 2) {
      stroke(48, 117, 141); // Wall color
    } else if (map_choice == 3) {
      stroke(47, 130, 76); // Wall color
    } else {
      stroke(158, 74, 124); // Wall color
    }
    strokeWeight(10);
    line(0, 5, 1640, 5);
    line(5, 0, 5, 1240);
    line(0, 1235, 1640, 1235);
    line(1635, 0, 1635, 1240);
    line(1115, 0, 1115, 1240);
    line(1115, 95, 1640, 95);
    line(1545, 0, 1545, 95);
    line(1115, 185, 1640, 185);
    line(1115, 275, 1640, 275);
    line(1115, 300, 1640, 300);
    line(1115, 440, 1115 + 175, 440);
    line(1115 + 175*2, 440, 1640, 440);
    line(1115, 465, 1115 + 175, 465);
    line(1115 + 175*2, 465, 1640, 465);
    line(1115 + 175, 440, 1115 + 175, 465);
    line(1115 + 175*2, 440, 1115 + 175*2, 465);
    line(1115 + 175, 452, 1115 + 175*2, 452);
    line(1115, 574, 1640, 574);
    line(1115, 704, 1640, 704);
    line(1246, 574, 1246, 700);
    line(1376, 574, 1376, 700);
    line(1506, 574, 1506, 700);
    line(1115, 792, 1640, 792);

    noStroke();

    // Pause button background color
    pauseButton.display();
    // if (mouseX >= 1550 && mouseX < 1630 && mouseY >= 10 && mouseY < 90) {
    //   fill(105, 196, 250);
    // } else {
    //   fill(135, 206, 250);
    // }
    // rect(1640-90, 10, cellSize, cellSize);
    // rect(1640-50, 10, cellSize, cellSize);
    // rect(1640-90, 10+cellSize, cellSize, cellSize);
    // rect(1640-50, 10+cellSize, cellSize, cellSize);
    // // Draw pause button
    // drawPauseButton();

    // Show score
    textAlign(LEFT, BASELINE);
    fill(255); // White
    textSize(40);
    text("SCORE    " + score, 1140, 62);

    // Show lives
    fill(237, 44, 44);
    textSize(40);
    text("HEALTH", 1140, 154);
    image(heart, 1380, 120);
    text("X  " + myPacman.lives, 1450, 154);

    // Show money
    fill(246, 209, 7); // Yellow
    text("MONEY", 1140, 242);
    image(coin, 1380, 208);
    text("X  " + money, 1450, 242);

    // Show block shop
    fill(135, 206, 250);
    textSize(55);
    text("BLOCK", 1140, 370);
    text("SHOP", 1414, 370);
    textSize(20);
    text("V    V    V    V    V    V    V    V    V    V    V    V", 1146, 410);
    // Show current block type
    fill(135, 206, 250);
    textSize(40);
    text("BLOCK   TYPE: ", 1140, 530);
    if (block_type == 1) {
      fill(22, 22, 148);
    } else if (block_type == 2) {
      fill(135, 206, 250);
    } else if (block_type == 3) {
      fill(255);
    } else {
      fill(255, 255, 0);
    }
    rect(1535, 490, 1.5*cellSize, 1.5*cellSize);
    // choose block
    // if (mouseX >= 1120 && mouseX < 1240 && mouseY >= 574 && mouseY < 700) {
    //   fill(200);
    //   rect(1121, 580, 120, 120);
    // }
    // if (mouseX >= 1250 && mouseX < 1370 && mouseY >= 574 && mouseY < 700) {
    //   fill(200);
    //   rect(1251, 580, 120, 120);
    // }
    // if (mouseX >= 1380 && mouseX < 1500 && mouseY >= 574 && mouseY < 700) {
    //   fill(200);
    //   rect(1381, 580, 120, 120);
    // }
    // if (mouseX >= 1510 && mouseX < 1630 && mouseY >= 574 && mouseY < 700) {
    //   fill(200);
    //   rect(1511, 580, 120, 120);
    // }
    // fill(22, 22, 148);
    // rect(1150, 610, 1.5*cellSize, 1.5*cellSize);
    // fill(135, 206, 250);
    // rect(1282, 610, 1.5*cellSize, 1.5*cellSize);
    // fill(255);
    // rect(1412, 610, 1.5*cellSize, 1.5*cellSize);
    // fill(255, 255, 0);
    // rect(1542, 610, 1.5*cellSize, 1.5*cellSize);
    block1.display();
    block2.display();
    block3.display();
    block4.display();
    // Show block information
    fill(246, 209, 7); // Yellow
    textSize(40);
    text("PRICE: ", 1140, 760);
    image(coin, 1380, 726);
    text("X  " + price[block_type-1], 1450, 760);
    fill(135, 206, 250);
    text("BLOCK   FUNCTION: ", 1140, 850);
    textSize(40);
    text("V    V    V    V    V", 1196, 910);
    if (block_type == 1) {
      text("Block path", 1140, 990);
      text("when it exists.", 1140, 1070);
    } else if (block_type == 2) {
      text("Block path and", 1140, 990);
      text("slow the ghosts", 1140, 1070);
      text("when it exists.", 1140, 1150);
    } else if (block_type == 3) {
      text("Block path and", 1140, 990);
      text("stop all ghosts", 1140, 1070);
      text("when it exists.", 1140, 1150);
    } else {
      text("Transport Pac-", 1140, 990);
      text("man to the", 1140, 1070);
      text("select place.", 1140, 1150);
    }
    // doubleSpeedButton.display();
  }

  // void drawPauseButton() {
  //   if (pause == false) {
  //     fill(255);
  //     rect(1566, 25, 16, 16);
  //     rect(1566, 41, 16, 16);
  //     rect(1566, 57, 16, 16);
  //     rect(1598, 25, 16, 16);
  //     rect(1598, 41, 16, 16);
  //     rect(1598, 57, 16, 16);
  //   } else {
  //     fill(255);
  //     triangle(1572, 25, 1572, 73, 1612, 49);
  //   }
  // }

  //  Method to check if a move to a new position has a dot
  boolean checkDot(int x, int y) {
    if (map[y][x] == dot) {
      return true;
    } else {
      return false;
    }
  }

  void eatDot(int x, int y) {
    map[y][x] = eat_dot; // Eat dot
    eatSmallDotSound.play();
    score += basic_score;
    money++;
  }


  // Check if new tile contians big dot
  boolean checkBigDot(int row, int col) {
    if ( map[row][col] == BIG_DOT ) {
      return true;
    }
    return false;
  }


  // Eat bigDot and remove from map
  void eatBigDot(int row, int col) {
    map[row][col] = eat_dot;
    eatBigDotSound.play();
    score += bigScore;
    money += 10;
  }


  boolean setWall(int x, int y) {
    if (map[y][x] == 2 || map[y][x] == 4 || map[y][x] == 6 ) {
      map[y][x] = empty_grid;
      // Clear tmp wall in the stack
      wallindex=(wallindex+wallstack_deep-1)%wallstack_deep;
      int i;
      for (i=0; i<wallstack_deep; i++) {
        if (wallstack[i][0] == x && wallstack[i][1] == y) {
          wallstack[i][0] = wallstack[wallindex][0];
          wallstack[i][1] = wallstack[wallindex][1];
          break;
        }
      }
      if (i==wallstack_deep) {
        println("ERROR: Can not find this tmp wall int wallstack", x, y);
      }
      return true;
    }
    if (map[y][x] != wall && money >= price[block_type-1]) {
      if (wallstack[wallindex][0] != -1) {
        map[wallstack[wallindex][1]][wallstack[wallindex][0]] = empty_grid;
      }
      wallstack[wallindex][0] = x;
      wallstack[wallindex][1] = y;
      wallindex++;
      wallindex%=wallstack_deep;
      map[y][x] = 2 * block_type;
      money -= price[block_type-1];
      return true;
    }
    return false;
  }

  void transport(int gridx, int gridy) {
    teleportSound.play();
    myPacman.setPosition(gridx, gridy);
    // myPacman.x = gridx * cellSize;
    // myPacman.y = gridy * cellSize;
    money -= price[block_type-1];
  }

  int getScore() {
    return score;
  }

  void pause() {
    pause = !pause;
  }

  boolean checkPause() {
    return pause;
  }

  boolean checkSlow() {
    for ( int row = 0; row < map.length; row++ ) {
      for ( int col = 0; col < map[0].length; col++ ) {
        if ( map[row][col] == 4 ) {
          return true;
        }
      }
    }
    return false;
  }

  boolean checkStop() {
    for ( int row = 0; row < map.length; row++ ) {
      for ( int col = 0; col < map[0].length; col++ ) {
        if ( map[row][col] == 6 ) {
          return true;
        }
      }
    }
    return false;
  }

  void changeBlock(int type) {
    block_type = type;
    tmp_wall = 2 * type;
  }


  // Sets a dot at given location on map
  void setDot(int col, int row) {
    this.map[row][col] = dot;
  }


  // Returns if there is dot remains on map
  boolean dotsRemaining() {

    for ( int row = 0; row < map.length; row++ ) {
      for ( int col = 0; col < map[0].length; col++ ) {
        if ( map[row][col] == dot || map[row][col] == BIG_DOT ) {
          return true;
        }
      }
    }

    return false;
  }

  void clicked() {
    int gridX = mouseX / cellSize;
    int gridY = mouseY / cellSize;

    if (gridX >= 0 && gridX < this.COLUMNS && gridY >= 0 && gridY < this.RAWS) {
      println("Cliked : ", gridX, gridY);
      if (gameMap.block_type == 4) {
        if ((gameMap.map[gridY][gridX] == 3 || gameMap.map[gridY][gridX] == 0) && gameMap.money > 50) {
          gameMap.transport(gridX, gridY);
        }
      } else {
        gameMap.setWall(gridX, gridY);
      }
    }
    if (pauseButton.clicked()) {
      gameMap.pause();
    }
    if (block1.clicked()) {
      gameMap.changeBlock(1);
    }
    if (block2.clicked()) {
      gameMap.changeBlock(2);
    }
    if (block3.clicked()) {
      gameMap.changeBlock(3);
    }
    if (block4.clicked()) {
      gameMap.changeBlock(4);
    }
    if (doubleSpeedButton.clicked()) {
      if(doubleSpeedButton.isOn) {
        current_speed *= 2;
      } else {
        current_speed /= 2;
      }
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
  }
}
