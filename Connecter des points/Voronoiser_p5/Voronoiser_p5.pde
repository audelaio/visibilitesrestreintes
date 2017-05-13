import megamu.mesh.*;
// INSTALLER : http://leebyron.com/mesh/

ArrayList<PVector> vectorList = new ArrayList();

void setup() {
  size(1280, 800,P3D);
  smooth();

  
  for ( int i =0; i < 100; i++ ) {    
    PVector v = new PVector( random(width), random(height), 0);
    vectorList.add(v);
  }
  
}

void draw() {
   background(127); 
  
 
  strokeWeight(5);
  stroke(127);
  fill(255);
  voronoiser( vectorList, true);
  
   for ( int i =0; i < vectorList.size(); i++ ) {    
    PVector v = vectorList.get(i);
    fill(127);
    //ellipse( v.x, v.y, 5,5);
  }
  
}

void mousePressed() {
  vectorList = new ArrayList();
  for ( int i =0; i < 100; i++ ) {    
    PVector v = new PVector( random(width), random(height), 0);
    vectorList.add(v);
  }
  
}