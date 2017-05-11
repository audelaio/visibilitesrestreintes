import megamu.mesh.*;
// INSTALLER : http://leebyron.com/mesh/

ArrayList<PVector> vectorList = new ArrayList();

void setup() {
  size(1280, 800,P3D);
  smooth();

  
  for ( int i =0; i < 50; i++ ) {    
    PVector v = new PVector( random(width), random(height), 0);
    vectorList.add(v);
  }
  
}

void draw() {
   background(255); 
  
  for ( int i =0; i < vectorList.size(); i++ ) {    
    PVector v = vectorList.get(i);
    ellipse( v.x, v.y, 5,5);
  }
  
  crystalDelaunayser( vectorList,200);
  
}