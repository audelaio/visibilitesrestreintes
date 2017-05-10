class User {
  
  public float x,y,z;
  public boolean detected = false;
  public PVector[] facePoints;
  
  public class Bounds {
    float left;
    float top;
    float right;
    float bottom;

  }
  
   public class Pose {
     PVector rotation = new PVector();
     float scale;
     PVector translation = new PVector();

  }
  
  public Bounds faceBounds = new Bounds();
  public Pose facePose = new Pose();
 
  
 User() {
   facePoints = new PVector[5];
   for ( int i=0; i < 5;i++) {
     
     facePoints[i] = new PVector();
   }
   
 }
 
 PVector getFacePoint(int index) {
   return facePoints[index]; 
 }
 
  PVector getFacePointNormalized(int index) {
   PVector v = new PVector();
   v.x = facePoints[index].x / 1980.0;
   v.y = facePoints[index].y / 1080.0;
   return v; 
 }
 
  Bounds getFaceBounds() {
   return faceBounds; 
 }
 
   Bounds getFaceBoundsNormalized() {
     Bounds b = new Bounds();
     b.left = faceBounds.left / 1980.0;
     b.top = faceBounds.top / 1080.0;
     b.right = faceBounds.right / 1980.0;
     b.bottom = faceBounds.bottom / 1080.0;
   return b; 
 }
 
 Pose getFacePose() {
   
   return facePose;
 }
  
  
}