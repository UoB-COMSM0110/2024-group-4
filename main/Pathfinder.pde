final int MAX_COLS = 28;
final int MAX_ROWS = 31;

final int WALL = 1;
final int TMP_WALL = 2;
final int BIG_NUMBER = 1000;


class Pathfinder {
  // Handles logic for A* algorithm
  
  Node[][] grid;
  GameMap map;
  
  ArrayList<Node> openList = new ArrayList<>();
  ArrayList<Node> optimalPath = new ArrayList<>();
  
  Node startNode;
  Node targetNode;
  Node currentNode;
  
  boolean isTarget = false;
  
  
  // Constructor
  Pathfinder(GameMap map) {
    this.map = map;
    createGrid();
  }
  
  
  // Initialise grid of nodes equivalent to GameMap
  void createGrid() {
    grid = new Node[MAX_ROWS][MAX_COLS];
    
    for (int row = 0; row < MAX_ROWS; row++) {
      for (int col = 0; col < MAX_COLS; col++) {
        grid[row][col] = new Node(col, row);
      }
    }
    
  }
  
  
  // Set information needed for A* algorithm
  void setGrid(int startCol, int startRow, int targetCol, int targetRow) {
    
    resetGrid();
    resetPathfinder();
    
    startNode = grid[startRow][startCol];
    targetNode = grid[targetRow][targetCol];

    currentNode = startNode;
    openList.add(currentNode);
    
    setWalls();
    setCosts();
    
  }
  
  
  // Set non-traversable nodes in grid
  void setWalls() {
    
    for (int row = 0; row < MAX_ROWS; row++) {
      for (int col = 0; col < MAX_COLS; col++) {
        if ( map.map[row][col] == WALL ) {
          grid[row][col].isWall = true;
        }
        else if ( map.map[row][col] == TMP_WALL ) {
          grid[row][col].isWall = true;
        }
        else;
      }
    }
    
  }
  
  
  // Set costs for each node
  void setCosts() {
    
    for (int row = 0; row < MAX_ROWS; row++) {
      for (int col = 0; col < MAX_COLS; col++) {
        Node n = grid[row][col];
        setGCost(n);
        setHCost(n);
        setFCost(n);
      }
    }
    
  }
  
  
  // Set G cost
  void setGCost(Node node) {
    int xDist = Math.abs(node.x - startNode.x);
    int yDist = Math.abs(node.y - startNode.y);
    node.gCost = xDist + yDist;
  }
  
  
  // Set H cost
  void setHCost(Node node) {
    int xDist = Math.abs(node.x - targetNode.x);
    int yDist = Math.abs(node.y - targetNode.y);
    node.hCost = xDist + yDist;
  }
  
  
  // Set F cost
  void setFCost(Node node) {
    node.fCost = node.gCost + node.hCost;
  }
  
  
  //
  boolean traverse() {
    
    while ( !isTarget && !openList.isEmpty() ) {
      
      int col = currentNode.x;
      int row = currentNode.y;
      
      int lowestFCost = BIG_NUMBER;
      int bestNodeIndex = 0;
      
      currentNode.visited = true;
      openList.remove(currentNode);
      
      // Open orthogonal neighbours
      if ( row - 1 >= 0 ) { // Up
        openNode(grid[row - 1][col]);
      }
      if ( col + 1 <= MAX_COLS ) { // Right
        openNode(grid[row][col + 1]);
      }
      if ( row + 1 <= MAX_ROWS ) { //Down
        openNode(grid[row + 1][col]);
      }
      if ( col - 1 >= 0 ) { // Left
        openNode(grid[row][col - 1]);
      }
      
      // Find the most optimal node from openList
      for (int i = 0; i < openList.size(); i++) {
        if ( openList.get(i).fCost < lowestFCost ) {
          bestNodeIndex = i;
          lowestFCost = openList.get(i).fCost;
        }
        else if ( openList.get(i).fCost == lowestFCost ) {
          if ( openList.get(i).gCost < openList.get(bestNodeIndex).gCost ) {
            bestNodeIndex = i;
          }
        }
        else;
      }
      
      if ( openList.isEmpty() ) {
        // If openList is empty at this point, ghost is completely blocked off
        // and cannot find targetNode. Ghost class switches movement logic to 
        // random until blocks are removed.
        return false;
      }
      
      // Update currentNode
      currentNode = openList.get(bestNodeIndex);
      if ( currentNode == targetNode ) {
        isTarget = true;
        backtrack();
      }
      
    }
    
    return isTarget;
  }
  
  
  // Add node to openList if it's a valid path node
  void openNode(Node node) {
    
    if ( !node.open && !node.visited && map.checkMove(node.x, node.y) ) {
      node.open = true;
      node.parent = currentNode;
      openList.add(node);
    }
  
  }
  
  
  // Add all nodes on optimal path to optimalPath
  void backtrack() {
   
    Node current = targetNode;
    
    while ( current != startNode ) {
      optimalPath.add(0, current);
      current = current.parent;
    }
    
  }
  
  
  // Reset grid when update() method is called
  void resetGrid() {
    
    for (int row = 0; row < MAX_ROWS; row++) {
      for (int col = 0; col < MAX_COLS; col++) {
        grid[row][col].isWall = false;
        grid[row][col].open = false;
        grid[row][col].visited = false;
      }
    }
    
  }
  
  
  // Reset Pathfinder state
  void resetPathfinder() {
    
    openList.clear();
    optimalPath.clear();
    
    isTarget = false;
    
  }
  
   
}
