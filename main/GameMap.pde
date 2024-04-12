final int dot = 3;
final int eat_dot = 0;
final int empty_grid = 0;
final int wall = 1;
int tmp_wall = 2;
final int basic_score = 10;
final int bigScore = 300;
final int wallstack_deep = 3;
boolean pause = false;
int block_type = 1;
int map_choice = 0;
int PORTAL = 7;
int BIG_DOT = 5;
int GHOST_HOME = 6;

class GameMap {
    Ghost ghost;
    int cellSize; // Cell size
    int dotSize;
    int distance;
    
    int[][] map = deepCopy2D(map1);
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
    
    void setMap() {
        final int[][][] mapList = {map1, map2, map3, map4, map5};
        map = deepCopy2D(mapList[map_choice]);
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
            if (map_choice == 0) {
                stroke(33, 33, 222); // Wall color 
            }  
            else if (map_choice == 1) {
                stroke(69, 60, 182); // Wall color 
            }  
            else if (map_choice == 2) {
                stroke(48, 117, 141); // Wall color 
            }
            else if (map_choice == 3) {
                stroke(47, 130, 76); // Wall color 
            }
            else {
                stroke(158, 74, 124); // Wall color 
            }
            strokeWeight(10);
            // check up
            if (map[max(0,i-1)][j] == 3 || map[max(0, i-1)][j] == 0 || map[max(0, i-1)][j] == 2 || map[max(0, i-1)][j] == 4 || map[max(0, i-1)][j] == 6 || map[max(0, i-1)][j] == 5) {
                if (map[i][max(0,j-1)] == 3 || map[i][max(0,j-1)] == 0 || map[i][max(0,j-1)] == 2 || map[i][max(0,j-1)] == 4 || map[i][max(0,j-1)] == 6 || map[i][max(0,j-1)] == 5) {
                line(j * cellSize+10, i * cellSize+10, (j+1) * cellSize, i * cellSize+10);
                }
                else if (map[i][min(j+1, map[0].length-1)] == 3 || map[i][min(j+1, map[0].length-1)] == 0  || map[i][min(j+1, map[0].length-1)] == 2 || map[i][min(j+1, map[0].length-1)] == 4 || map[i][min(j+1, map[0].length-1)] == 6 || map[i][min(j+1, map[0].length-1)] == 5) {
                line(j * cellSize, i * cellSize+10, (j+1) * cellSize-10, i * cellSize+10);
                }  
                else {
                if (map[max(0,i-1)][j-1] == 1) {
                    line(j * cellSize-10, i * cellSize+10, (j+1) * cellSize, i * cellSize+10);
                }
                else if (map[max(0,i-1)][j+1] == 1) {
                    line(j * cellSize, i * cellSize+10, (j+1) * cellSize+10, i * cellSize+10);
                }
                else {
                    line(j * cellSize, i * cellSize+10, (j+1) * cellSize, i * cellSize+10);
                }  
                }
            }
            
            // check down
            if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
                if (map[i][max(0,j-1)] == 3 || map[i][max(0,j-1)] == 0 || map[i][max(0,j-1)] == 2 || map[i][max(0,j-1)] == 4 || map[i][max(0,j-1)] == 6 || map[i][max(0,j-1)] == 5) {
                line(j * cellSize+10, (i+1) * cellSize-10, (j+1) * cellSize+10, (i+1) * cellSize-10);
                }
                else if (map[i][min(j+1, map[0].length-1)] == 3 || map[i][min(j+1, map[0].length-1)] == 0 || map[i][min(j+1, map[0].length-1)] == 2 || map[i][min(j+1, map[0].length-1)] == 4 || map[i][min(j+1, map[0].length-1)] == 6 || map[i][min(j+1, map[0].length-1)] == 5) {
                line(j * cellSize-10, (i+1) * cellSize-10, (j+1) * cellSize-10, (i+1) * cellSize-10);
                }  
                else {
                if (map[min(i+1, map.length-1)][j-1] == 1) {
                    line(j * cellSize-10, (i+1) * cellSize-10, (j+1) * cellSize, (i+1) * cellSize-10);
                }  
                else if (map[min(i+1, map.length-1)][j+1] == 1) {
                    line(j * cellSize, (i+1) * cellSize-10, (j+1) * cellSize+10, (i+1) * cellSize-10);
                }
                else {
                    line(j * cellSize, (i+1) * cellSize-10, (j+1) * cellSize, (i+1) * cellSize-10);
                }
                }
            }
            
            // check left
            if (map[i][max(0,j-1)] == 3 || map[i][max(0,j-1)] == 0 || map[i][max(0,j-1)] == 2 || map[i][max(0,j-1)] == 4 || map[i][max(0,j-1)] == 6 || map[i][max(0,j-1)] == 5) {
                if (map[max(0,i-1)][j] == 3 || map[max(0, i-1)][j] == 0 || map[max(0, i-1)][j] == 2 || map[max(0, i-1)][j] == 4 || map[max(0, i-1)][j] == 6 || map[max(0, i-1)][j] == 5) {
                line(j * cellSize+10, i * cellSize+10, j * cellSize+10, (i+1) * cellSize);
                }
                else if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
                line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize-10);
                }  
                else {
                if (map[i-1][max(0,j-1)] == 1) {
                    line(j * cellSize+10, i * cellSize-10, j * cellSize+10, (i+1) * cellSize+10);
                }  
                else if (map[i+1][max(0,j-1)] == 1) {
                    line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize+10);
                }
                else {
                    line(j * cellSize+10, i * cellSize, j * cellSize+10, (i+1) * cellSize+10);
                }
              }
            }
            
            //check right
            if (map[i][min(j+1, map[0].length-1)] == 3 || map[i][min(j+1, map[0].length-1)] == 0 || map[i][min(j+1, map[0].length-1)] == 2 || map[i][min(j+1, map[0].length-1)] == 4 || map[i][min(j+1, map[0].length-1)] == 6 || map[i][min(j+1, map[0].length-1)] == 5) {
                if (map[max(0,i-1)][j] == 3 || map[max(0, i-1)][j] == 0 || map[max(0, i-1)][j] == 2 || map[max(0, i-1)][j] == 4 || map[max(0, i-1)][j] == 6 || map[max(0, i-1)][j] == 5) {
                line((j+1) * cellSize-10, i * cellSize+10, (j+1) * cellSize-10, (i+1) * cellSize);
                }
                else if (map[min(i+1, map.length-1)][j] == 3 || map[min(i+1, map.length-1)][j] == 0 || map[min(i+1, map.length-1)][j] == 2 || map[min(i+1, map.length-1)][j] == 4 || map[min(i+1, map.length-1)][j] == 6 || map[min(i+1, map.length-1)][j] == 5) {
                line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize-10);
                }  
                else {
                if (map[i-1][min(j+1, map[0].length-1)] == 1) {
                    line((j+1) * cellSize-10, i * cellSize-10, (j+1) * cellSize-10, (i+1) * cellSize+10);
                }  
                else if (map[i+1][min(j+1, map[0].length-1)] == 1) {
                    line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize+10);
                }
                else {
                line((j+1) * cellSize-10, i * cellSize, (j+1) * cellSize-10, (i+1) * cellSize+10);
                }  
                }
            }
            noStroke();
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
        // draw edges
        if (map_choice == 0) {
            stroke(33, 33, 222); // Wall color 
        }  
        else if (map_choice == 1) {
            stroke(154, 205, 50); // Wall color 
        }  
        else if (map_choice == 2) {
            stroke(0, 250, 0); // Wall color 
        }
        else if (map_choice == 3) {
            stroke(255, 192, 203); // Wall color 
        }
        else {
            stroke(250, 0, 0); // Wall color 
        }
        strokeWeight(10);
        line(1, 1, 1000, 1);
        noStroke();
        for (int i = 0; i < map.length; i++) {
        fill(33, 33, 222); // Wall color
        rect(28 * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }  
        for (int i = 0; i < map.length; i++) {
        if (i == 0 || i == 3 || i == 4 || i == 5 || i == 8 || i == 11 || i == 15 || i == 18 || i == map.length-1) {
            for (int j = 29; j < 1640/cellSize; j++) {
            fill(33, 33, 222); // Wall color
            rect(j * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
            }  
        }
        else if (i == 1 || i == 2) {
            fill(135, 206, 250); // Pause button color
            rect((1640/cellSize-2) * cellSize, i * cellSize, cellSize, cellSize);
            rect((1640/cellSize-3) * cellSize, i * cellSize, cellSize, cellSize); // Draw pause button
            fill(33, 33, 222); // Wall color
            rect((1640/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
            rect((1640/cellSize-4) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }  
        else {
            fill(33, 33, 222); // Wall color
            rect((1640/cellSize-1) * cellSize, i * cellSize, cellSize, cellSize); // Draw walls
        }  
        }  
        // Show score
        textAlign(LEFT, BASELINE);
        fill(255); // White
        textSize(20); 
        text("SCORE: " + score, 1180, 95);
        // Show money
        fill(255, 255, 0); // Yellow
        text("MONEY: $ " + money, 1180, 300);
        // Draw pause button
        drawPauseButton();
        // Show current block type
        fill(135, 206, 250);
        text("BLOCK TYPE: ", 1180, 420);
        if (block_type == 1) {
        fill(22, 22, 148);
        }
        else if (block_type == 2) {
        fill(135, 206, 250);
        }
        else {
        fill(255);
        }  
        rect(1490, 370, 1.5*cellSize, 1.5*cellSize);
        // Show block shop
        fill(135, 206, 250);
        textSize(40); 
        text("BLOCK SHOP", 1160, 200);
        textSize(10); 
        text("V    V    V    V    V    V    V    V    V    V    V", 1170, 230);
        fill(33, 33, 222); // Wall color
        rect(32 * cellSize, 12 * cellSize, cellSize, cellSize);
        rect(32 * cellSize, 13 * cellSize, cellSize, cellSize);
        rect(32 * cellSize, 14 * cellSize, cellSize, cellSize);
        rect(36 * cellSize, 12 * cellSize, cellSize, cellSize);
        rect(36 * cellSize, 13 * cellSize, cellSize, cellSize);
        rect(36 * cellSize, 14 * cellSize, cellSize, cellSize);
        fill(22, 22, 148);
        rect(29.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
        fill(135, 206, 250);
        rect(33.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
        fill(255);
        rect(37.75 * cellSize, 12.75 * cellSize, 1.5*cellSize, 1.5*cellSize);
        // Show block information
        fill(135, 206, 250);
        textSize(20); 
        text("BLOCK PRICE: ", 1180, 700);
        fill(255, 255, 0);
        text("$ "+ String.valueOf(10*block_type), 1490, 700);
        fill(135, 206, 250); 
        text("BLOCK FUNCTION: ", 1180, 820);
        if (block_type == 1) {
        text("Block both pacman", 1180, 900);
        text("and the ghosts", 1180, 980);
        text("when it exists.", 1180, 1060);
        }
        else if (block_type == 2) {
        text("Block both pacman", 1180, 900);
        text("and the ghosts,", 1180, 980);
        text("slow the ghosts", 1180, 1060);
        text("when it exists.", 1180, 1140);
        }
        else {
        text("Block both pacman", 1180, 900);
        text("and the ghosts,", 1180, 980);
        text("stop all the ghosts", 1180, 1060);
        text("when it exists.", 1180, 1140);
        }
    }  
    
    void drawPauseButton() {
        if (pause == false) {
        fill(255);
        rect(38.4 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
        rect(38.4 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
        rect(38.4 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
        rect(39.2 * cellSize, 1.4 * cellSize, cellSize/5*2, cellSize/5*2);
        rect(39.2 * cellSize, 1.8 * cellSize, cellSize/5*2, cellSize/5*2);
        rect(39.2 * cellSize, 2.2 * cellSize, cellSize/5*2, cellSize/5*2);
        }
        else {
        fill(255);
        triangle(38.55 * cellSize, 1.4 * cellSize, 38.55 * cellSize, 2.6 * cellSize,39.6 * cellSize, 2 * cellSize);
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
        score += bigScore;
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
    
    
    // Sets a dot at given location on map
    void setDot(int col, int row) {
        this.map[row][col] = dot;
    }
    
    
    // Returns how many dots are remaining on map
    int dotsRemaining() {
        
        int dots = 0;
        
        for ( int row = 0; row < map.length; row++ ) {
        for ( int col = 0; col < map[0].length; col++ ) {
            if ( map[row][col] == dot || map[row][col] == BIG_DOT ) {
            dots++;
            }
        }
        }
        
        return dots;
    }
}
