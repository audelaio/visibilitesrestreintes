import java.util.*;
import megamu.mesh.*;
// INSTALLER : http://leebyron.com/mesh/



void delaunayser( ArrayList pVectorList, float maxDistance) {

  float[][] points = new float[pVectorList.size()][2];
  for ( int i =0; i < pVectorList.size(); i++ ) {
    PVector v = (PVector) pVectorList.get(i);
    points[i][0] = v.x;
    points[i][1] = v.y;
  }

  Delaunay myDelaunay = new Delaunay( points );
  float[][] myEdges = myDelaunay.getEdges();
  
  stroke(0);


  for (int i=0; i<myEdges.length; i++)
  {
    float startX = myEdges[i][0];
    float startY = myEdges[i][1];
    float endX = myEdges[i][2];
    float endY = myEdges[i][3];
    if ( dist( startX, startY, endX, endY   ) < maxDistance ) line( startX, startY, endX, endY );
  }

  
}