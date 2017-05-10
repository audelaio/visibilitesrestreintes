/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;


Users users = new Users();

void setup() {
  size(700, 400,P3D);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 7878);
}


void draw() {
  background(0);  

  for ( int i=0; i < 6; i++ ) {
    User user = users.getUser(i);
    if ( user.detected) 
      text( "User "+i+" "+user.x+" "+user.y+" "+user.z, 10, i*20+20);
  }


  for ( int i=0; i < 6; i++ ) {
    User user = users.getUser(i);
    if ( user.detected) {
      
      noFill();
      stroke(255);
      User.Bounds b = user.getFaceBoundsNormalized();
      
      rectMode(CORNERS);
      rect(b.left* width,b.top* height,b.right* width,b.bottom*height);
      
      fill(255);
      for ( int j=0; j < 5; j++) {
        PVector v = user.getFacePointNormalized(j);
        
        float x =  v.x * width;
        float y =  v.y * height;
        ellipse(x, y, 10, 10);
      }
    }
  }
  
 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* new_user {playerID}
   lost_user {playerID} */

  users.updateFromOsc(theOscMessage);
}