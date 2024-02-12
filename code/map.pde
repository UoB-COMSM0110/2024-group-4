int[][] map = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 1},
  {1, 0, 1, 0, 0, 0, 0, 1, 0, 1},
  {1, 0, 1, 0, 1, 1, 0, 1, 0, 1},
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
};

int cellSize = 40; // Cell size
int pacmanX = 1; // Pacman's X position, in map cells
int pacmanY = 1; // Pacman's Y position, in map cells

// Check if Pacman can move to a new position
boolean checkMove(int x, int y) {
  return map[y][x] == 0; // 0 represents a road, which is movable
}

void drawMap() {
  for (int i = 0; i < map.length; i++) {
    for (int j = 0; j < map[i].length; j++) {
      if (map[i][j] == 1) {
        fill(33, 33, 222); // Wall color
        rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
      }
    }
  }
}
