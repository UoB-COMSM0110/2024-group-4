class Node {
  // Holds information used for calculating A* best path
  
  int x;
  int y;
  
  int gCost;
  int hCost;
  int fCost;
  
  boolean isWall;
  boolean open;
  boolean visited;
  
  Node parent;
  
 
  // Constructor
  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
}
