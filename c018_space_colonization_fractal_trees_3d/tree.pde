import java.util.Stack;
import java.util.Iterator;

class Tree {
  // Fields
  private Branch root;
  private ArrayList<Leaf> leaves;
  private boolean isGrowing;
  
  // Constructor
  public Tree(float rootX, float rootY) {
    root = new Branch(new PVector(rootX, rootY), new PVector(0, -1), 0);
    leaves = new ArrayList();
    isGrowing = true;
  }
  
  // Getters and Setters
  public boolean isGrowing() {
    return isGrowing;
  }
  
  // Methods
  public void show() {
    for (Leaf leaf : leaves) {
      leaf.show();
    }
    
    root.show();
  }
  
  public void generateLeaves() {
    float centerX = width / 2;
    float centerY = height / 5 * 2;
    
    for (int j=0 ; j<600 ; j++) {
      float r = random(width / 3);
      float a = random(TWO_PI);
      float x = centerX + r * sin(a);
      float y = centerY - r * cos(a);
      
      leaves.add(new Leaf(x, y));
    }
  }
  
  public void removeLeaves() {
    leaves = new ArrayList();
  }
  
  public void generateTrunk() {
    boolean leafFound = false;
    Branch current = root;
    
    while (!leafFound) {
      for (Leaf leaf : leaves) {
        if (PVector.dist(leaf.getPosition(), current.getPosition()) < maxDistance) {
          leafFound = true;
        }
      }
      
      if (!leafFound) {
        Branch newBranch = current.generateBranch();
        current = newBranch;
      }
    }
  }
  
  public void grow() {
    pullBranches();
    removeReachedLeaves();
    addNewBranches();
  }
  
  /*
    Branches are "pulled" by the leaves.
    Each leaf will look for the closest branch and will modify its direction
    towards itself.
  */
  private void pullBranches() {
    for (Leaf leaf : leaves) {
      // The closest branch is the one with the least
      // distance between the leaf and itself.
      Branch closestBranch = null;
      float recordDistance = Float.POSITIVE_INFINITY;
      
      // DFS search of the branches
      Stack<Branch> stack = new Stack() {{ push(root); }};
      
      while(!stack.empty()) {
        Branch current = stack.pop();
        
        for (Branch child : current.children) {
          stack.push(child);
        }
        
        // Calculate the distance
        float distance = PVector.dist(current.getPosition(), leaf.getPosition());
        
        // If the distance is less than the minimum, the leaf has
        // fulfilled its purpose and its no longer needed.
        if (distance < minDistance) {
          leaf.markAsReached();
          break;
        }
        // If the distance is greater than the maximum distance,
        // the leaf should have no impact on the branch.
        else if (distance > maxDistance) {
          continue;
        }
        
        // Update record distance
        if (distance < recordDistance) {
          closestBranch = current;
          recordDistance = distance;
        }
      }
      
      // If the leaf has a branch within the valid range
      if (closestBranch != null) {
        // Vector from the branch to the leaf
        PVector newDir = PVector
          .sub(leaf.getPosition(), closestBranch.getPosition())
          .normalize();
        
        // "Pull" the branch towards the leaf and mark that it has been pulled
        closestBranch.dir.add(newDir);
        closestBranch.increaseTimesPulled();
      } 
    }
  }
  
  private void removeReachedLeaves() {
    Iterator<Leaf> itr = leaves.iterator();
    while(itr.hasNext()) {
      Leaf leaf = itr.next();
      
      if (leaf.isReached())
        itr.remove();
    }
  }
  
  private void addNewBranches() {
    boolean newBranches = false;
    
    // DFS search of the branches
    Stack<Branch> stack = new Stack() {{ push(root); }};

    while(!stack.empty()) {
      Branch current = stack.pop();
      
      for (Branch child : current.children) {
        stack.push(child);
      }
      
      // If the branch has been pulled towards a leaf, add a new branch
      if (current.isPulled()) {
        newBranches = true;
        current.generateBranch();
        current.reset();
      }
    }
    
    // The tree stops growing when no new branches are created
    if (!newBranches)
      isGrowing = false;
  }
}
