import java.util.*;

class Connection {

  PVector vector1;
  PVector vector2;
  float distance;

  Connection(PVector vector1, PVector vector2, float distance) {
    this.vector1 = vector1;
    this.vector2 = vector2;
    this.distance = distance;
  }
}

void isoSkeletoniser( ArrayList pVectorList, float maxDistance) {

 // Create iso-skeleton
  skeleton = new IsoSkeleton(this);
  
  for (int i=0; i<pVectorList.size() ; i++) {
    PVector iV = (PVector) pVectorList.get(i);
    for (int j=i+1; j<pVectorList.size() ; j++) {
        PVector jV = (PVector) pVectorList.get(j);
      if (iV.dist( jV ) < maxDistance) {
        skeleton.addEdge(iV, jV);
      }
    }
  }
  
   noStroke();
  //skeleton.plot(2 , 0.5);  // Thickness as parameter
  translate(width*0.5,height*0.5);
  rotateY(frameCount*0.01);
  translate(-width*0.5,-height*0.5);
  skeleton.plot(1.4, 0.009375);  // Thickness as parameter

}