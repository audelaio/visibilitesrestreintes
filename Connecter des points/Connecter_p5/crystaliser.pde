import java.util.*;


void crystaliser( ArrayList pVectorList, float maxDistance, int maxConnections ) {

  // FOR EACH VECTOR
  for (int j=0; j<pVectorList.size(); j++) {
    PVector jVector = (PVector) pVectorList.get(j);

    // LIST OF POSSIBLE CONNECTIONS
    ArrayList<Connection> connections = new ArrayList();

    // FOR EACH OTHER VECTOR
    for (int k=0; k<pVectorList.size(); k++) {
      if ( j != k ) {
        PVector kVector = (PVector) pVectorList.get(k);
        float distance = PVector.dist(jVector, kVector);
        // ADD CONNECTION IF THE DISTANCE IS SHORTER THAN MAXDISTANCE
        if ( distance <= maxDistance ) {
          connections.add( new Connection(jVector, kVector, distance));
        }
      }
    }

    // SORT CONNECTIONS
    Collections.sort(connections, new Comparator<Connection>() {
      @Override
        public int compare(Connection c1, Connection c2)
      {

        return  c1.distance < c2.distance ? -1 : 1;
      }
    }
    );


    // FOR EACH CONNECTION
    for ( int c = 0; c < connections.size() && c < maxConnections; c++ ) {

      Connection connection = connections.get(c);
     

      stroke(255);
      strokeWeight(1);

      line(connection.vector1.x, connection.vector1.y, connection.vector2.x, connection.vector2.y);
    }
  }
}