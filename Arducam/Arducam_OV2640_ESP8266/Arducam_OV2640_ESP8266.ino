// CAMERA MODULE + MICROCONTROLLER
// * 2MP CAMERA : OV2640
// * ArduCAM-ESP8266-Nano
// * 2MP image sensor OV2640, support JPEG  Standard FOV 60°stock lens
// * SEE : http://www.robotshop.com/en/arducam-2mp-v2-mini-camera-shield-esp8266-nano-module.html

// INSTALLATION
// * ADD TO File -> Preferences -> Additional Board Manager URLs:
//    http://www.arducam.com/downloads/ESP8266_UNO/package_ArduCAM_index.json
// * OPEN Tools -> Board menu -> Boards Manager and install:
//    ArduCAM_ESP8266_UNO addon package.
// * SELECT Tools -> Board menu -> ArduCAM_ESP8266_UNO board.

// COMPLETE DOCUMENTATION
// * http://www.arducam.com/downloads/shields/ArduCAM_Mini_2MP_ESP8266_EvaluationKit_DS.pdf

// THIS CODE DOES THE FOLLOWING
// * Set the camera to JPEG output mode.
// * Stores a JPEG capture at regular intervals on a server with php (see sample php below)
// * Sets up a HTTP and Websocket server
// * if server.on("/capture", HTTP_GET, serverCapture),it can take photo and send to the client
// * if server.on("/stream", HTTP_GET, serverStream),it can take photo continuously as video to the client

// SAMPLE PHP CODE
// <?php
// // SET TO THE TARGET DIR :
// $target_dir = "storedjpegs/"; 
//
// $uploadfile = "";
// if(strlen(basename($_FILES["userfile"]["name"])) > 0) {
//   $uploadfile = basename($_FILES["userfile"]["name"]);
//   //error_log($uploadfile);
//   $datum = mktime(date('H')+0, date('i'), date('s'), date('m'), date('d'), date('y'));
//
//   if(move_uploaded_file($_FILES["userfile"]["tmp_name"], $target_dir.date('Y_m_d_H_i_s', $datum)."_".$uploadfile)) {
//     //error_log($target_dir.date('Y_m_d_H_i_s', $datum)."_".$uploadfile);
//   }
// }
// ?>

#include "EzEsp8266.h"
#include "EzArduCAM_OV2640_ESP8266.h"

ESP8266WebServer server(80);

#include <Chrono.h>
Chrono uploadChrono;

void setup() {

  delay(3000);

  Serial.begin(115200);

  EzEsp8266.autoConnect("arducam-ap", "arducam-ap");

  EzArduCAM.setup();


  // SETUP AND START THE SERVER
  server.on("/capture", HTTP_GET, serverCapture);
  server.on("/stream", HTTP_GET, serverStream);
  server.onNotFound(handleNotFound);
  server.begin();
  Serial.println("*AC: Server started :)");
}

void loop() {
  server.handleClient();

  if ( uploadChrono.hasPassed(10000) ) {
    uploadChrono.restart();
    uploadToServer();
  }
}

void uploadToServer() {

  Serial.println("***UPLOADING***");

  EzArduCAM.captureAndPostImageToServer("www.server.com","/public/storejpeg.php");
  
}



void serverCapture() {

  Serial.println("***RETURNING CAPTURE***");

  WiFiClient client = server.client();

  EzArduCAM.captureAndReturnImageToClient(&server,&client);

}

void serverStream() {
   Serial.println("***STREAMING***");
  
  WiFiClient client = server.client();
 
  // STREAM NON STOP UNTIL CLIENT DISCONNECTS
  while( EzArduCAM.captureAndStreamToClient(&server,&client) );
 
}

void handleNotFound() {
  String message = "Server is running!\n\n";
  message += "URI: ";
  message += server.uri();
  message += "\nMethod: ";
  message += (server.method() == HTTP_GET) ? "GET" : "POST";
  message += "\nArguments: ";
  message += server.args();
  message += "\n";
  server.send(200, "text/plain", message);

  if (server.hasArg("ql")) {
    int ql = server.arg("ql").toInt();
    EzArduCAM.setJpegSize(ql);

    delay(1000);
    Serial.println("QL change to: " + server.arg("ql"));
  }
}




