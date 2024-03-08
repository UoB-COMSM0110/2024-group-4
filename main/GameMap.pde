class GameMap {
  int cellSize; // Cell size
  int dotSize;
  int distance;
  int[][] map = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 1, 1, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 1, 0, 1},
    {1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  };
  int [][] dotMap = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 0, 0, 1, 1, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 1, 0, 1},
    {1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  };
  // player can build 3 walls
  int[][] wallstack={
  {-1,-1},
  {-1,-1},
  {-1,-1},
  };
  int wallindex;
  
  // Constructor
  GameMap(int cellSize) {
    this.cellSize = cellSize;
    this.dotSize = cellSize / 4;
    this.distance = (cellSize - dotSize) / 2;
    this.wallindex = 0;
  }
  
  // Method to check if a move to a new position is possible
  boolean checkMove(int x, int y) {
    // Ensure the move is within the bounds of the map
    if (x < 0 || x >= map[0].length || y < 0 || y >= map.length) {
      return false;
    }
    return map[y][x] == 0; // 0 represents a road, which is movable
  }
  
  // Method to draw the map
  void drawMap() {
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j < map[i].length; j++) {
        if (map[i][j] == 1) {
          fill(33, 33, 222); // Wall color
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (map[i][j] == 2) {
          fill(22, 22, 148);
          rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }
        if (dotMap[i][j] == 0) {
          fill(255, 255, 0); // Dot color
          rect(j * cellSize + distance, i * cellSize + distance, dotSize, dotSize); // Draw dots
        }
      }
    }
  }
  
  //  Method to check if a move to a new position has a dot
  boolean checkDot(int x, int y) {
    if (dotMap[y][x] == 0) {
      return true;
    }
    else {
      return false;
    }  
  }  
  
  void eatDot(int x, int y) {
    dotMap[y][x] = 1; // Eat dot
    drawMap();
  }  
  
  boolean setWall(int x, int y){
    if (map[y][x] == 0) {
      if (wallstack[wallindex][0] != -1){
        map[wallstack[wallindex][1]][wallstack[wallindex][0]] = 0;
      }
      wallstack[wallindex][0] = x;
      wallstack[wallindex][1] = y;
      wallindex++;
      wallindex%=3;
      map[y][x] = 2;
      return true;
    }
    if (map[y][x] == 2) {
      map[y][x] = 0;
      return true;
    }
    return false;
  }
}
