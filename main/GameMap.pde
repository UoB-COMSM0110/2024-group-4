//<<<<<<< main
final int dot = 3;
//=======
//final int dot = 16;
//>>>>>>> main
final int eat_dot = 17;
final int empty_grid = 0;
final int wall = 1;
final int tmp_wall = 2;
final int basic_score = 10;
final int wallstack_deep = 3;
boolean pause = false;

class GameMap {
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
  int money;
  
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
        if (map[i][j] == tmp_wall) {
          fill(22, 22, 148);
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
      if (i == 0 || i == 3 || i == map.length-1) {
        for (int j = 28; j < 1560/cellSize; j++) {
          fill(33, 33, 222); // Wall color
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }  
      }
      else if (i == 1 || i == 2) {
        fill(135, 206, 250); // Pause button color
        rect((1560/cellSize-2) * cellSize, i * cellSize, cellSize, cellSize);
        rect((1560/cellSize-3) * cellSize, i * cellSize, cellSize, cellSize); // Draw pause button
        fill(33, 33, 222); // Wall color
        rect((1560/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
      }  
      else {
        fill(33, 33, 222); // Wall color
        rect((1560/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
      }  
    }  
    // Show score
    fill(255); // White
    textSize(52); 
    text("SCORE: " + score, 1140, 95);
    // Show money
    fill(255, 255, 0); // Yellow
    textSize(52);
    text("MONEY: $ " + money, 1140, 220);
    // Draw pause button
    drawPauseButton();
  }
  
  void drawPauseButton() {
    if (pause == false) {
      fill(255);
      rect(36.4 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(36.4 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(36.4 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(37.2 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(37.2 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
      rect(37.2 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
    }
    else {
      fill(255);
      triangle(36.55 * cellSize, 1.4 * cellSize, 36.55 * cellSize, 2.6 * cellSize,37.6 * cellSize, 2 * cellSize);
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
    if (map[y][x] == tmp_wall) {
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
    if (map[y][x] != wall) {
      if (wallstack[wallindex][0] != -1){
        map[wallstack[wallindex][1]][wallstack[wallindex][0]] = empty_grid;
      }
      wallstack[wallindex][0] = x;
      wallstack[wallindex][1] = y;
      wallindex++;
      wallindex%=wallstack_deep;
      map[y][x] = tmp_wall;
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
}
