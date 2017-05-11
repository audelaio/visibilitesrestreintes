import ComputationalGeometry.*;
IsoSkeleton skeleton;

ArrayList<PVector> vectorList = new ArrayList();

void setup() {
  size(1280, 800,P3D);
  smooth();
  
   

  
  for ( int i =0; i < 50; i++ ) {    
    PVector v = new PVector( random(width), random(height),  random(-width*0.25,width*0.25));
    vectorList.add(v);
  }
  
}

void draw() {
   background(0); 
    
  lights();  

  
  for ( int i =0; i < vectorList.size(); i++ ) {    
    PVector v = vectorList.get(i);
    ellipse( v.x, v.y, 5,5);
  }
  
  isoSkeletoniser( vectorList,300);
}

void mousePressed() {
  vectorList = new ArrayList();
   for ( int i =0; i < 50; i++ ) {    
    PVector v = new PVector( random(width), random(height),  random(-width*0.25,width*0.25));
    vectorList.add(v);
  }
  
}