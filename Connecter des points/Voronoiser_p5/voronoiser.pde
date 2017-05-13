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

void voronoiser( ArrayList pVectorList, boolean allowEdgeTouching) {

  float[][] points = new float[pVectorList.size()][2];

  for ( int i =0; i < pVectorList.size(); i++ ) {
    PVector v = (PVector) pVectorList.get(i);
    points[i][0] = v.x;
    points[i][1] = v.y;
  }


  Voronoi myVoronoi = new Voronoi( points );

  MPolygon[] myRegions = myVoronoi.getRegions();

  for (int i=0; i<myRegions.length; i++)
  {
    // an array of points
    float[][] regionCoordinates = myRegions[i].getCoords();

    boolean touchesEdge = false;

    for ( int j =0; j < regionCoordinates.length; j++) {
      if ( regionCoordinates[j][0] <= 0 || regionCoordinates[j][0] >= width || regionCoordinates[j][1] <= 0 || regionCoordinates[j][1] >= height) touchesEdge = true;
    }

    if ( touchesEdge == false ) {
      fill(random(30,80), random(200,255), random(30,60));
      beginShape();
      for ( int j =0; j < regionCoordinates.length; j++) {
        vertex(regionCoordinates[j][0], regionCoordinates[j][1]);
      }
      endShape(CLOSE);
    }


    //fill(255, 0, 0);
    //myRegions[i].draw(this); // draw this shape
  }
}