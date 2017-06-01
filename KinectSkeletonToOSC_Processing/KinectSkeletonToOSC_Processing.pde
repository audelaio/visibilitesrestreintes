/*

 
 LIBRARIES : 
 * KinectPV2, Kinect for Windows v2 library for processing
 * OSCP5
 
 BASED ON : Skeleton color map example by Thomas Sanchez Lengeling. http://codigogenerativo.com/
 
 */

import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;


boolean showMonitoring = true;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress remoteAddress = new NetAddress("127.0.0.1", 7878);

boolean[] detected = {false, false, false, false, false, false}; 

void setup() {
  size(960, 540, P3D);

  oscP5 = new OscP5(this, 7979);

  kinect = new KinectPV2(this);

  kinect.enableSkeletonColorMap(true);
  kinect.enableSkeleton3DMap(true);
  kinect.enableColorImg(true);

  kinect.init();
}

void draw() {
  background(0);

  if (  showMonitoring )  image(kinect.getColorImage(), 0, 0, width, height);
  pushMatrix();
  scale(0.5);

  ArrayList<KSkeleton> skeleton3DArray =  kinect.getSkeleton3d();
  boolean[] sendLostUser = {true, true, true, true, true, true}; 
  for (int i = 0; i < skeleton3DArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeleton3DArray.get(i);
    
    //println(skeleton.getIndex()+" "+skeleton.isTracked());
    if (skeleton.isTracked()) {
      sendLostUser[i] = false;
      if ( detected[i] == false ) {
        detected[i] = true;
        OscMessage newUserMessage = new OscMessage("new_user");
        newUserMessage.add(i+1); 
        oscP5.send(newUserMessage, remoteAddress);
      }
      KJoint[] joints = skeleton.getJoints();
      // SEND REFERENCE JOINT (JointType_SpineMid) by OSC

      KJoint referenceJoint = joints[KinectPV2.JointType_SpineMid];
      OscMessage userMessage = new OscMessage("user");
      userMessage.add(i+1); 
      userMessage.add(referenceJoint.getX()); 
      userMessage.add(referenceJoint.getY()); 
      userMessage.add(referenceJoint.getZ()); 

      oscP5.send(userMessage, remoteAddress);
    } 
    
  }
  
   for ( int i =0 ; i < sendLostUser.length; i++){
        if ( sendLostUser[i] == true && detected[i] == true ) {
         detected[i] = false;
        OscMessage lostUserMessage = new OscMessage("lost_user");
        lostUserMessage.add(i+1); 
        oscP5.send(lostUserMessage, remoteAddress);
      }
    }

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();



      // DRAW JOINTS
      if (  showMonitoring ) {
        color col  = skeleton.getIndexColor();
        fill(col);
        stroke(col);
        drawBody(joints);

        //draw different color for each hand state
        drawHandState(joints[KinectPV2.JointType_HandRight]);
        drawHandState(joints[KinectPV2.JointType_HandLeft]);
      }
    }
  }
  popMatrix();


  fill(255);
  rectMode(CENTER);
  rect(width*0.5, height*0.5, 150, 30);
  textSize(12);
  fill(0);
  textAlign(CENTER, CENTER);
  if ( showMonitoring ) 
    text("click to hide monitoring", width*0.5, height*0.5);
  else 
  text("click to show monitoring", width*0.5, height*0.5);
}

//DRAW BODY
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw bone
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

//draw hand state
void drawHandState(KJoint joint) {
  noStroke();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  ellipse(0, 0, 70, 70);
  popMatrix();
}

/*
Different hand state
 KinectPV2.HandState_Open
 KinectPV2.HandState_Closed
 KinectPV2.HandState_Lasso
 KinectPV2.HandState_NotTracked
 */
void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}

void mousePressed() {

  showMonitoring = !showMonitoring;
}