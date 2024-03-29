//<<<<<<< main
final int dot = 3;
//=======
//final int dot = 16;
//>>>>>>> main
final int eat_dot = 17;
final int empty_grid = 0;
final int wall = 1;
int tmp_wall = 2;
final int basic_score = 10;
final int wallstack_deep = 3;
boolean pause = false;
int block_type = 1;

class GameMap {
  Ghost ghost;
  int cellSize; // Cell size
  int dotSize;
  int distance;
  int[][] map = {
//<<<<<<< main
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 3, 1, 1, 1, 1, 1, 1},
    {1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1},
    {1, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 3, 0, 0, 3, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 1},
    {1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1},
    {1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 1},
    {1, 3, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 1, 1, 3, 3, 3, 3, 3, 3, 1},
    {1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1},
    {1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1},
    {1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    
//=======
//    {wall, wall, wall, wall, wall, wall, wall, wall, wall, wall},
//    {wall, dot, dot, dot, wall, wall, dot, dot, dot, wall},
//    {wall, dot, wall, dot, dot, dot, dot, wall, dot, wall},
//    {wall, dot, wall, dot, wall, wall, dot, wall, dot, wall},
//    {wall, dot, dot, dot, dot, dot, dot, dot, dot, wall},
//    {wall, wall, wall, wall, wall, wall, wall, wall, wall, wall},
//>>>>>>> main
  };
  // player can build 3 walls
  int[][] wallstack={
  {-1,-1},
  {-1,-1},
  {-1,-1},
  };
  int wallindex;
  int score;
  int money = 100;
  
  // Constructor
  GameMap(int cellSize) {
    this.cellSize = cellSize;
    this.dotSize = cellSize / 4;
    this.distance = (cellSize - dotSize) / 2;
    this.wallindex = 0;
  }

  void clearGrid(int x, int y) {
    map[y][x] = empty_grid;
  }
  
  // Method to check if a move to a new position is possible
  boolean checkMove(int x, int y) {
    // Ensure the move is within the bounds of the map
    if (x < 0 || x >= map[0].length || y < 0 || y >= map.length) {
      return false;
    }
    return map[y][x] != wall && map[y][x] != tmp_wall; // 1 represents a wall
  }
  
  // Method to draw the map
  void drawMap() {
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (map[i][j] == wall) {
          fill(33, 33, 222); // Wall color
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == 2) {
          fill(22, 22, 148);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == 4) {
          fill(135, 206, 250);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == 6) {
          fill(255);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == dot) {
          fill(255, 255, 0); // Dot color
          rect(j * cellSize + distance, i * cellSize + distance, dotSize, dotSize); // Draw dots
        }
      }
    }
    // draw edges
    for (int i = 0; i < map.length; i++) {
      if (i == 0 || i == 3 || i == 4 || i == 5 || i == 8 || i == 11 || i == 15 || i == 18 || i == map.length-1) {
        for (int j = 28; j < 1600/cellSize; j++) {
          fill(33, 33, 222); // Wall color
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }  
      }
      else if (i == 1 || i == 2) {
        fill(135, 206, 250); // Pause button color
        rect((1600/cellSize-2) * cellSize, i * cellSize, cellSize, cellSize);
        rect((1600/cellSize-3) * cellSize, i * cellSize, cellSize, cellSize); // Draw pause button
        fill(33, 33, 222); // Wall color
        rect((1600/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        rect((1600/cellSize-4) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
      }  
      else {
        fill(33, 33, 222); // Wall color
        rect((1600/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
      }  
    }  
    // Show score
    fill(255); // White
    textSize(52); 
    text("SCORE: " + score, 1140, 95);
    // Show money
    fill(255, 255, 0); // Yellow
    textSize(52);
    text("MONEY: $ " + money, 1140, 300);
    // Draw pause button
    drawPauseButton();
    if (pause) {
      fill(255);
      textSize(80); 
      text("GAME PAUSE", 345, 605);
    }  
    // Show current block type
    fill(135, 206, 250);
    textSize(52); 
    text("BLOCK TYPE: ", 1140, 420);
    if (block_type == 1) {
      fill(22, 22, 148);
    }
    else if (block_type == 2) {
      fill(135, 206, 250);
    }
    else {
      fill(255);
    }  
    rect(1450, 370, 1.5*cellSize, 1.5*cellSize);
    // Show block shop
    fill(135, 206, 250);
    textSize(80); 
    text("BLOCK SHOP", 1120, 200);
    textSize(30); 
    text("V    V    V    V    V    V    V    V    V    V    V", 1130, 230);
    fill(33, 33, 222); // Wall color
    rect(31 * cellSize, 12 * cellSize, cellSize, cellSize);
    rect(31 * cellSize, 13 * cellSize, cellSize, cellSize);
    rect(31 * cellSize, 14 * cellSize, cellSize, cellSize);
    rect(35 * cellSize, 12 * cellSize, cellSize, cellSize);
    rect(35 * cellSize, 13 * cellSize, cellSize, cellSize);
    rect(35 * cellSize, 14 * cellSize, cellSize, cellSize);
    fill(22, 22, 148);
    rect(28.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
    fill(135, 206, 250);
    rect(32.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
    fill(255);
    rect(36.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
    // Show block information
    fill(135, 206, 250);
    textSize(52); 
    text("BLOCK PRICE: ", 1140, 700);
    fill(255, 255, 0);
    text("$ "+ String.valueOf(10*block_type), 1450, 700);
    fill(135, 206, 250);
    textSize(52); 
    text("BLOCK FUNCTION: ", 1140, 820);
    if (block_type == 1) {
      text("Block both pacman", 1140, 900);
      text("and the ghosts", 1140, 980);
      text("when it exists.", 1140, 1060);
    }
    else if (block_type == 2) {
      text("Block both pacman", 1140, 900);
      text("and the ghosts,", 1140, 980);
      text("slow the ghosts", 1140, 1060);
      text("when it exists.", 1140, 1140);
    }
    else {
      text("Block both pacman", 1140, 900);
      text("and the ghosts,", 1140, 980);
      text("stop all the ghosts", 1140, 1060);
      text("when it exists.", 1140, 1140);
    }
 }
  
  void drawPauseButton() {
    if (pause == false) {
      fill(255);
      rect(37.4 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(37.4 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(37.4 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(38.2 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(38.2 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(38.2 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
    }
    else {
      fill(255);
      triangle(37.55 * cellSize, 1.4 * cellSize, 37.55 * cellSize, 2.6 * cellSize,38.6 * cellSize, 2 * cellSize);
    }  
  }  
  
  //  Method to check if a move to a new position has a dot
  boolean checkDot(int x, int y) {
    if (map[y][x] == dot) {
      return true;
    }
    else {
      return false;
    }  
  }  
  
  void eatDot(int x, int y) {
    map[y][x] = eat_dot; // Eat dot
    score += basic_score;
    money++;
    drawMap();
  }  
  
  boolean setWall(int x, int y){
    if (map[y][x] == 2 || map[y][x] == 4 || map[y][x] == 6 ) {
      map[y][x] = empty_grid;
      // Clear tmp wall in the stack
      wallindex=(wallindex+wallstack_deep-1)%wallstack_deep;
      int i;
      for(i=0; i<wallstack_deep; i++){
        if(wallstack[i][0] == x && wallstack[i][1] == y){
          wallstack[i][0] = wallstack[wallindex][0];
          wallstack[i][1] = wallstack[wallindex][1];
          break;
        }
      }
      if(i==wallstack_deep) {

      println("ERROR: Can not find this tmp wall int wallstack", x, y);

      }
      return true;
    }
    if (map[y][x] != wall && money >= 10 * block_type) {
      if (wallstack[wallindex][0] != -1){
        map[wallstack[wallindex][1]][wallstack[wallindex][0]] = empty_grid;
      }
      wallstack[wallindex][0] = x;
      wallstack[wallindex][1] = y;
      wallindex++;
      wallindex%=wallstack_deep;
      map[y][x] = 2 * block_type;
      money -= 10 * block_type;
      return true;
    }
    return false;
  }

  int getScore() {
    return score;
  }
  
  void pause() {
    if (pause == false) {
      pause = true;
    }  
    else {
      pause = false;
    }  
  }
  
  boolean checkPause() {
    return pause;
  }  
  
  void changeBlock(int type) {
    block_type = type;
    tmp_wall = 2 * type;
  }  
}
