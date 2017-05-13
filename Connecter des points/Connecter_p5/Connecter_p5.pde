

ArrayList<PVector> vectorList = new ArrayList();

int vizMode = 0;

void setup() {
  size(1280, 800,P3D);
  smooth();

  
  for ( int i =0; i < 100; i++ ) {    
    PVector v = new PVector( random(width), random(height), random(150));
    vectorList.add(v);
  }
  
}

void draw() {
   background(127); 
  
 
  strokeWeight(5);
  stroke(127);
  fill(255);
  if ( vizMode == 0 ) {
    crystaliser( vectorList, 500, 4);
  } else  if ( vizMode == 1 ) {
     delaunayser( vectorList,200);
  }  else  if ( vizMode == 2 ) {
    voronoiser( vectorList, true);
  }   else  if ( vizMode == 3 ) {
    lights();  
     isoSkeletoniser( vectorList,300);
  }
  
   for ( int i =0; i < vectorList.size(); i++ ) {    
    PVector v = vectorList.get(i);
    fill(127);
    ellipse( v.x, v.y, 5,5);
  }
  
}

void mousePressed() {
  vectorList = new ArrayList();
  for ( int i =0; i < 100; i++ ) {    
    PVector v = new PVector( random(width), random(height), random(150));
    vectorList.add(v);
  }
  
}

void keyPressed() {
  vizMode = ( vizMode + 1 ) % 4;
}