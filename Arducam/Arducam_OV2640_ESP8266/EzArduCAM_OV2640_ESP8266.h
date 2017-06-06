#include <Wire.h>
#include <SPI.h>

#include <ArduCAM.h>

#include <ESP8266WiFi.h>

//#define OV2640_MINI_2MP
//#define OV2640_CAM


class _EzArduCAM_OV2640_ESP8266 {


#define bufferSize  1024
    uint8_t buffer[bufferSize] = {0xFF};
    uint8_t temp = 0, temp_last = 0;
    int i = 0;
    bool is_header = false;
    // set GPIO16 as the slave select :
    const int CS = 16;

  public:
    ArduCAM myCAM = ArduCAM(OV2640, 16);
    void setup() {

      Wire.begin();

      uint8_t vid, pid;
      uint8_t temp;

      // set the CS as an output:
      pinMode(CS, OUTPUT);

      // initialize SPI:
      SPI.begin();
      SPI.setFrequency(4000000); //4MHz

      //Check if the ArduCAM SPI bus is OK
      Serial.println("*AC: Checking SPI bus");
      myCAM.write_reg(ARDUCHIP_TEST1, 0x55);
      temp = myCAM.read_reg(ARDUCHIP_TEST1);
      if (temp != 0x55) {
        Serial.println(F("SPI1 interface Error!"));
        while (1);
      }

      //Check if the camera module type is OV2640
      Serial.println("*AC: Looking for OV2640");
      myCAM.wrSensorReg8_8(0xff, 0x01);
      myCAM.rdSensorReg8_8(OV2640_CHIPID_HIGH, &vid);
      myCAM.rdSensorReg8_8(OV2640_CHIPID_LOW, &pid);
      if ((vid != 0x26 ) && (( pid != 0x41 ) || ( pid != 0x42 )))
        Serial.println("*AC: Can't find OV2640 module!");
      else
        Serial.println("*AC: OV2640 detected.");

      //Change to JPEG capture mode and initialize the OV2640 module
      myCAM.set_format(JPEG);
      myCAM.InitCAM();
      myCAM.OV2640_set_JPEG_size(OV2640_320x240);

      myCAM.clear_fifo_flag();
    }

    void startCapture() {

      Serial.println("*AC: Starting capture");

      // START CAPTURE
      myCAM.clear_fifo_flag();
      myCAM.start_capture();

    }

    bool isCapturing() {

      return (!myCAM.get_bit(ARDUCHIP_TRIG, CAP_DONE_MASK));

    }


    size_t fifoLength() {

      return myCAM.read_fifo_length();
    }

    bool writeImageToArducamJs( Stream* stream) {

      Serial.println("*AC: Writing image to arducam.js");

      size_t len = fifoLength();

      myCAM.CS_LOW();
      myCAM.set_fifo_burst();

      int i = 0;
      while ( len-- )
      {
        temp_last = temp;
        temp =  SPI.transfer(0x00);
        //Read JPEG data from FIFO
        if ( (temp == 0xD9) && (temp_last == 0xFF) )  {
          // If find the end ,break while,
          buffer[i++] = temp;  //save the last  0XD9
          myCAM.CS_HIGH();
          //Write the remain bytes in the buffer
          //if (!client.connected()) break;
          stream->write(&buffer[0], i);
          is_header = false;
          i = 0;
          break;
        }
        if (is_header == true)
        {
          //Write image data to buffer if not full
          if (i < bufferSize)
            buffer[i++] = temp;
          else
          {
            //Write bufferSize bytes image data to file
            stream->write(&buffer[0], bufferSize);
            i = 0;
            buffer[i++] = temp;
          }
        }
        else if ((temp == 0xD8) & (temp_last == 0xFF))
        {
          is_header = true;
          buffer[i++] = temp_last;
          buffer[i++] = temp;
        }
      }
    }


    void setJpegSize(int ql) {
      myCAM.OV2640_set_JPEG_size(ql);
    }

    void captureAndReturnImageToClient(ESP8266WebServer* server, WiFiClient* client) {


      startCapture();

      // WAIT UNTIL IT IS DONE
      while ( isCapturing() );

      size_t len = fifoLength();

      if (!client->connected()) return;
      String response = "HTTP/1.1 200 OK\r\n";
      response += "Content-Type: image/jpeg\r\n";
      response += "Content-len: " + String(len) + "\r\n\r\n";
      server->sendContent(response);


      if (!client->connected()) return;
      
      writeImageToArducamJs(client);

    }

    bool captureAndStreamToClient(ESP8266WebServer* server, WiFiClient* client) {


      if (!client->connected()) return false;
      String response = "HTTP/1.1 200 OK\r\n";
      response += "Content-Type: multipart/x-mixed-replace; boundary=frame\r\n\r\n";
      server->sendContent(response);

      // START CAPTURING
      startCapture();

      // WAIT UNTIL IT IS DONE
      while ( isCapturing());

      if (!client->connected()) return false;

      writeImageToArducamJs(client);

      return 1;


    }

    void captureAndPostImageToServer(const char* host , const char* path  ) {

      WiFiClient client;

      if ( !client.connect (host, 80)) {
        Serial.println("*AC: Could not connect to server");
        return;
      }

      //if ( client.connected() )  Serial.println("connected");

      startCapture();

      // WAIT UNTIL IT IS DONE
      while ( isCapturing());

      Serial.println("*AC : Uploading capture");

      const char* filename = "CAM1.jpg";
      size_t jpglen = fifoLength();
      
      

      if (client.connected()) {
        String start_request = "";
        String end_request = "";
        start_request = start_request +
                        "\n--AaB03x\n" +
                        "Content-Disposition: form-data; name=\"userfile\"; filename=\"ArduCAM.jpg\"\n" +
                        "Content-Transfer-Encoding: binary\n\n";
        end_request = end_request + "\n--AaB03x--\n";
        uint16_t full_length = start_request.length() + jpglen + end_request.length();

        client.println("POST /public/storejpeg.php HTTP/1.1");
        client.println(String("Host: ") + host);
        client.println("Content-Type: multipart/form-data; boundary=AaB03x");
        client.print("Content-Length: ");
        client.println(full_length);
        client.print(start_request);
        // Read image data from Arducam mini and send away to internet

        buffer[bufferSize] = {0xFF};

        myCAM.CS_LOW();
        myCAM.set_fifo_burst();
        SPI.transfer(0xFF);

        while (jpglen) {
          size_t will_copy = (jpglen < bufferSize) ? jpglen : bufferSize;
          SPI.transferBytes(&buffer[0], &buffer[0], will_copy);
          if (!client.connected()) break;
          client.write(&buffer[0], will_copy);
          jpglen -= will_copy;
        }

        myCAM.CS_HIGH(); //digitalWrite(led, HIGH);


        //client.println(end_request);
        client.println(end_request);
        client.stop();
      }
    }
};

_EzArduCAM_OV2640_ESP8266 EzArduCAM;

