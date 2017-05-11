import ComputationalGeometry.*;
IsoSkeleton skeleton;

ArrayList<PVector> vectorList = new ArrayList();

void setup() {
  size(1280, 800,P3D);
  smooth();
  
   

  
  for ( int i =0; i < 50; i++ ) {    
    PVector v = new PVector( random(width), random(height),  random(-100,100));
    vectorList.add(v);
  }
  
}

void draw() {
   background(0); 
    
  lights();  
  float zm = 150;
  float sp = 0.001 * frameCount;
  //camera(zm * cos(sp), zm * sin(sp), zm, 0, 0, 0, 0, 0, -1);
  
  for ( int i =0; i < vectorList.size(); i++ ) {    
    PVector v = vectorList.get(i);
    ellipse( v.x, v.y, 5,5);
  }
  
  isoSkeletoniser( vectorList,250);
}