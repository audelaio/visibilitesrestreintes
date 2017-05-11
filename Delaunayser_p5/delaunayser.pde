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

void delaunayser( ArrayList pVectorList) {

  float[][] points = new float[pVectorList.size()][2];
  for ( int i =0; i < pVectorList.size(); i++ ) {
    PVector v = (PVector) pVectorList.get(i);
    points[i][0] = v.x;
    points[i][1] = v.y;
  }

  Delaunay myDelaunay = new Delaunay( points );
  float[][] myEdges = myDelaunay.getEdges();

  for (int i=0; i<myEdges.length; i++)
  {
    float startX = myEdges[i][0];
    float startY = myEdges[i][1];
    float endX = myEdges[i][2];
    float endY = myEdges[i][3];
    line( startX, startY, endX, endY );
  }

  
}