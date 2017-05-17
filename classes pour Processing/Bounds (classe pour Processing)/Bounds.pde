  public class Bounds {
    
    

    private float centerAccX = 0;
    private float centerAccY = 0;
    private int centerAccCount = 0;
    private boolean receivedAtLeastOnePoint = false;
    
    float left;
    float top;
    float right;
    float bottom;
    
  
    void addPoint(float x, float y) {
      
      if ( receivedAtLeastOnePoint == false ) {
        left = right = x;
        bottom = top = y;
        receivedAtLeastOnePoint = true;
      } else {
        centerAccX += x;
        centerAccY += y;
        if ( x < left ) left = x;
        if ( x > right ) right = x;
        if ( y < top ) top = y;
        if ( y > bottom ) bottom = y;
      }
      
      centerAccCount++;
      
    }
    
    float getCenterX() {
      
      return centerAccX/centerAccCount;
    }
    
     float getCenterY() {
      
      return centerAccY/centerAccCount;
    }

  }