final int UP = 1;
final int RIGHT = 2;
final int DOWN = 3;
final int LEFT = 4;

final int WIDTH = 40;
final int HEIGHT = 40;

final int EVADE = 0;
final int CHASE = 1;
final int SCATTER = 2;
final int TELEPORT = 3;
final int REAPPEAR = 4;
final int RETURN = 5;


class Entity {
  
  // Properties
  int x;
  int y;
  int col;
  int row;
  int targetCol;
  int targetRow;
  
  int direction;
  int speed;
  int state;
  
  Pathfinder pf;
  GameMap map;
  Entity target;
  
  
  // Constructor
  Entity(int startCol, int startRow, Pathfinder pf, GameMap map) {
    
    this.col = startCol;
    this.row = startRow;
    this.x = (startCol * map.cellSize);
    this.y = (startRow * map.cellSize);
    this.speed = 2;
    this.pf = pf;
    this.map = map;
  
  }
  
  
  void drawEntity() {
    
    fill(10, 245, 72);
    rect(x, y, WIDTH, HEIGHT);
    
    update();
  }
  
  
  // Getter for this.x and this.y
  int[] getPosition() {
    int[] pos = {this.x, this.y};
    return pos;
  }
  
  
  // Current position getter
  // Returns Node to be passed to Pathfinder
  int[] getCurrentNode() {
    int[] node = {this.col, this.row};
    return node;
  }
  
  
  // Current direction getter
  int getCurrentDirection() {
    return direction;
  }
  
  
  // this.direction setter
  void setDirection(int direction) {
    
    this.direction = direction;
  }
  
  
  // this.state setter
  void setState(int state) {
    
    this.state = state;
  }
  
  
  // this.target setter
  void setTarget(Entity target) {
    
    this.target = target;
  }
  
  
  // Update position on screen
  void update() {
  
    if ( ( x == col * map.cellSize ) && ( y == row * map.cellSize ) ) {
      
      if ( state == EVADE ) {
      
        if ( isPortal() ) { // Assuming all non-temporary portals teleport to opposite side of map, but same row
          if ( this.col == 1 ) {
            this.col = 26;
            this.x = (26 * map.cellSize);
          }
          else if ( this.col == 26 ) {
            this.col = 1;
            this.x = (1 * map.cellSize);
          }
        }
        randomMove();
      }
      
      if ( state == CHASE ) {
        
        int nextCol;
        int nextRow;
        
        pf.setGrid(col, row, this.targetCol, this.targetRow);
        
        if ( pf.traverse() ) {
          nextCol = pf.optimalPath.get(0).x;
          nextRow = pf.optimalPath.get(0).y;
          
          setDirection(getOptimalDirection(nextCol, nextRow));
        }
        else {
          randomMove();
        }
       
      }  
    }
    
    switch ( direction ) {
      
      case UP:
        y -= speed;
        break;
      case RIGHT:
        x += speed;
        break;
      case DOWN:
        y += speed;
        break;
      case LEFT:
        x -= speed;
        break;
      default:
        println("ERROR: invalid direction code in Entity.update() - " + direction);
        break;
    }
    
    updateTile();

  }
  
  
  // Return true if Entity is on new tile and update attributes
  void updateTile() {
    
    int currentCol = (int) ( x / map.cellSize );
    int currentRow = (int) ( y / map.cellSize );
    
    if ( currentCol != col || currentRow != row ) {
      col = currentCol;
      row = currentRow;
    }
  }
  
  
  // Return true if next cell is non-traversable
  boolean checkCollision(int direction) {
    
    int nextCol = col;
    int nextRow = row;
    
    switch ( direction ) {
      
      case UP:
        nextRow -= 1;
        break;
      case RIGHT:
        nextCol += 1;
        break;
      case DOWN:
        nextRow += 1;
        break;
      case LEFT:
        nextCol -= 1;
        break;
      default:
        println("ERROR: invalid direction code in Entity.update() - " + direction);
        break;
    }
    
    if ( map.checkMove(nextCol, nextRow) ) {
      return false;
    }
    
    return true;
  }
  
  
  // Change Entity direction
  void changeDirection(int direction) {
    
    int dir;
    
    if ( onlyBackValid(direction) ) {
      switch ( direction ) {
        case UP:
          dir = DOWN;
          break;
        case RIGHT:
          dir = LEFT;
          break;
        case DOWN:
          dir = UP;
          break;
        default:
          dir = RIGHT;
          break;
      }
    }
    else {
      do {
          dir = (int) random(1, 5);
      } while ( checkCollision(dir) || abs(dir - direction) == 2 ); // i.e. cannot move into non-traversable tile or cannot go back the same way it came
    }
    
    this.direction = dir;
  }
  
  
  // Checks if only valid move is to go back
  boolean onlyBackValid(int direction) {
    
    switch ( direction ) {
        case UP:
          return ( checkCollision(UP) && checkCollision(LEFT) && checkCollision(RIGHT) );
        case RIGHT:
          return ( checkCollision(UP) && checkCollision(DOWN) && checkCollision(RIGHT) );          
        case DOWN:
          return ( checkCollision(DOWN) && checkCollision(LEFT) && checkCollision(RIGHT) );
        default:
          return ( checkCollision(UP) && checkCollision(LEFT) && checkCollision(DOWN) );
    }
  }
  
  
  // Checks if perpendicular move is valid
  boolean perpendicularValid(int direction) {
    
    switch ( direction ) {
        case UP:
          return ( checkCollision(LEFT) || checkCollision(RIGHT) );
        case RIGHT:
          return ( checkCollision(UP) || checkCollision(DOWN) );          
        case DOWN:
          return ( checkCollision(LEFT) || checkCollision(RIGHT) );
        default:
          return ( checkCollision(UP) || checkCollision(DOWN) );
    }
  }
  
  
  // Check if current tile is a portal
  boolean isPortal() {
    
    if ( map.map[this.row][this.col] == PORTAL ) {
      return true;
    }
    
    return false;
  }
  
  
  // Sets a random direction for Entity to move towards
  void randomMove() {
    if ( checkCollision(this.direction) ) {
      changeDirection(this.direction);
    }
    else if ( perpendicularValid(this.direction) ) {
      changeDirection(this.direction); // Translates to roughly 50% or 66% chance of switching directions
    }
  }
  
  
  // Returns which direction Entity should move according to A* algorithm
  int getOptimalDirection(int nextCol, int nextRow) {
    
    if ( nextCol == this.col + 1 ) {
      return RIGHT;
    }
    else if ( nextCol == this.col - 1 ) {
      return LEFT;
    }
    else if ( nextRow == this.row + 1 ) {
      return DOWN;
    }
    else if ( nextRow == this.row - 1 ) {
      return UP;
    }
    else {
      println("Error in Entity.getOptimalDirection()");
      return -1;
    }
    
  }
  
  
  // Check if Entity has reached target
  boolean caughtTarget() {
    
    int targetX = this.target.getPosition()[0];
    int targetY = this.target.getPosition()[1];
    
    if ( abs(this.x - targetX) < cellSize * 0.25 && abs(this.y - targetY) < cellSize * 0.25 ) { // Entity caught if within a quarter of a tile
      return true;
    }
    return false;
  }

}