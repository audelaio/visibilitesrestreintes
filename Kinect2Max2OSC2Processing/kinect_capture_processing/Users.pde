class Users {

  User[]  users ;

  Users() {

    users = new User[6];
    for ( int i=0; i < 6; i++ ) {
      users[i] = new User();
    }
  }

  public User getUser(int id) {
    return users[id];
  }

  public void updateFromOsc(OscMessage theOscMessage) {
    if ( theOscMessage.addrPattern().equals("user")  ) {
      int id = theOscMessage.get(0).intValue()-1; 
      users[id].x =  theOscMessage.get(1).floatValue(); 
      users[id].y =  theOscMessage.get(1).floatValue(); 
      users[id].z =  theOscMessage.get(1).floatValue(); 
      users[id].detected = true;
    } else if ( theOscMessage.addrPattern().equals("new_user ")  ) {
      int id = theOscMessage.get(0).intValue()-1; 
      users[id].detected = true;
    } else if ( theOscMessage.addrPattern().equals("lost_user")  ) {
      int id = theOscMessage.get(0).intValue()-1; 
      users[id].detected = false;
      
      
    } else if ( theOscMessage.addrPattern().equals("face")  ) {
      int id = theOscMessage.get(0).intValue()-1; 
      String faceInfo =  theOscMessage.get(1).stringValue(); 
      if ( faceInfo.equals("points2d") ) {
        
        // face id points2d x1 y1 x2 y2 x3 y3 x4 y4 x5 y5
        
        
        users[id].facePoints[0].x = theOscMessage.get(2).intValue(); 
        users[id].facePoints[0].y = theOscMessage.get(3).intValue(); 
        
        users[id].facePoints[1].x = theOscMessage.get(4).intValue(); 
        users[id].facePoints[1].y = theOscMessage.get(5).intValue(); 
        users[id].facePoints[2].x = theOscMessage.get(6).intValue(); 
        users[id].facePoints[2].y = theOscMessage.get(7).intValue(); 
        users[id].facePoints[3].x = theOscMessage.get(8).intValue(); 
        users[id].facePoints[3].y = theOscMessage.get(9).intValue(); 
        users[id].facePoints[4].x = theOscMessage.get(10).intValue(); 
        users[id].facePoints[4].y = theOscMessage.get(11).intValue();
        
      } else if ( faceInfo.equals("bounds") ) {
        
        // face id points2d x1 y1 x2 y2 x3 y3 x4 y4 x5 y5
        
        users[id].faceBounds.left = theOscMessage.get(2).intValue(); 
        users[id].faceBounds.top = theOscMessage.get(3).intValue(); 
        users[id].faceBounds.right = theOscMessage.get(4).intValue(); 
        users[id].faceBounds.bottom = theOscMessage.get(5).intValue(); 
        
        
      } else if ( faceInfo.equals("pose") ) {
        

        users[id].facePose.scale = theOscMessage.get(2).floatValue(); 
        
        PVector rotation = new PVector();
        rotation.x = theOscMessage.get(3).floatValue(); 
        rotation.y = theOscMessage.get(4).floatValue(); 
        rotation.z = theOscMessage.get(5).floatValue(); 
         users[id].facePose.rotation = rotation;
         
        PVector translation = new PVector();
        translation.x = theOscMessage.get(6).floatValue(); 
        translation.y = theOscMessage.get(7).floatValue(); 
        translation.z = theOscMessage.get(8).floatValue();
        users[id].facePose.translation = translation;
        
        
      }
    } 
    
    
  }
}