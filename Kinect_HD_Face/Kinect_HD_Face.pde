/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/
 
 KinectPV2, Kinect for Windows v2 library for processing
 
 HD Face tracking.
 Vertex Face positions are mapped to the Color Frame or to the Infrared Frame
 */
import KinectPV2.*;

KinectPV2 kinect;

int vizMode = 0;

float scale = 0.5;
ArrayList<FacePoint> facePoints = new ArrayList();

boolean faceBeingTracked = false;

void setup() {
  //size(1920/2, 1080/2);
  size(960, 540);

  kinect = new KinectPV2(this);

  //enable HD Face detection
  kinect.enableHDFaceDetection(true);
  kinect.enableColorImg(true); //to draw the color image
  kinect.init();

  for (int i = 0; i < KinectPV2.HDFaceVertexCount ; i++) {
    facePoints.add( new FacePoint());
  }
}

void draw() {
  background(0);



  // Draw the color Image
  if ( vizMode == 0) {

    scale(scale);

    image(kinect.getColorImage(), 0, 0);

    //Obtain the Vertex Face Points
    // 1347 Vertex Points for each user.
    ArrayList<HDFaceData> hdFaceData = kinect.getHDFaceVertex();

    for (int j = 0; j < hdFaceData.size(); j++) {
      //obtain a the HDFace object with all the vertex data
      HDFaceData HDfaceData = (HDFaceData)hdFaceData.get(j);

      if (HDfaceData.isTracked()) {

        //draw the vertex points
        stroke(0, 255, 0);
        beginShape(POINTS);
        for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
          float x = HDfaceData.getX(i);
          float y = HDfaceData.getY(i);
          vertex(x, y);
        }
        endShape();
      }
    }
  } else {
    //Obtain the Vertex Face Points
    // 1347 Vertex Points for each user.
    ArrayList<HDFaceData> hdFaceData = kinect.getHDFaceVertex();

    // IF A FACE
    if ( hdFaceData.size() > 0 ) {
      faceBeingTracked = true;

      // GET FIRST FACE
      HDFaceData HDfaceData = (HDFaceData)hdFaceData.get(0);

      //if (HDfaceData.isTracked()) {

      // CALCULATE BOUNDS  
      Bounds bounds = new Bounds();
      for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
        bounds.addPoint(HDfaceData.getX(i), HDfaceData.getY(i));
      }

      float centerX = bounds.getCenterX();
      float centerY = bounds.getCenterY();
      float faceScaleX = (width)/(bounds.right - bounds.left);
      float faceScaleY = (height)/(bounds.bottom - bounds.top);
      float faceScale =  faceScaleX < faceScaleY ?  faceScaleX : faceScaleY;   

      // COPY TRANSLATED TARGETS
      for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
        FacePoint fp = facePoints.get(i);
        fp.target.x = (HDfaceData.getX(i) - centerX )*faceScale;
        fp.target.y = (HDfaceData.getY(i) - centerY)*faceScale;
      }
    } else {
/*
      if ( faceBeingTracked == true) {
        for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
          facePoints[i].target = new PVector(random(-width*0.5, width*0.5), random(-height*0.5, height*0.5), 0);
        }
        faceBeingTracked = false;
      }
      */
      for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
        FacePoint fp = facePoints.get(i);
          fp.wander(0.001);
        }
      
    }
    // DRAW POINTS
    translate( width*0.5, height*0.5);

    stroke(255);
    //beginShape(POINTS);

    for (int i = 0; i < KinectPV2.HDFaceVertexCount; i++) {
      FacePoint fp = facePoints.get(i);
      fp.moveTowardTarget(0.1);
      float x = fp.x; //HDfaceData.getX(i) - centerX;
      float y = fp.y; //HDfaceData.getY(i)- centerY;
      ellipse(x, y,3,3);
    }
    
    delaunayser(facePoints,50);
   // endShape();
  }
}

void keyPressed() {

  vizMode = (vizMode + 1) % 2;
}