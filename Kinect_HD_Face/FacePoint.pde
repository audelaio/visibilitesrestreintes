class FacePoint extends PVector  {
  
  //PVector current = new PVector();
  PVector target = new PVector();
  float noiseOffsetX = random(0,1000);
  float noiseOffsetY = random(0,1000);
  
  void moveTowardTarget(float speed) {
    
    x = (target.x-x)* speed + x;
    y = (target.y-y)* speed + y;
  }
  
  void wander(float speed) {
    target.x = (noise(frameCount*speed+noiseOffsetX)-0.5)* width;
    target.y = (noise(frameCount*speed+noiseOffsetY)-0.5) * height;
    
  }
  
  
  
}