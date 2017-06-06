#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <WiFiManager.h> 
#include <ESP8266WebServer.h>
#include <ESP8266mDNS.h>
#include <DNSServer.h>

class _EzEsp8266 {
  


private:
/*
  const char* ssid;
  const char* password;
  IPAddress ip;
  IPAddress gateway;
  IPAddress subnet;
  
  void setup(const char* ssid, const char* password) {
      this->ssid = ssid;
      this->ssid = password;
   }

   void setup(const char* ssid, const char* password, IPAddress ip , IPAddress gateway, IPAddress subnet) {
      this->ip = ip;
      this->gateway = gateway;
      this->subnet = subnet;
      setup(ssid,pasword);
   }
*/
public:
  _EzEsp8266() {

    
  }

  void startAccessPoint(const char* ssid, const char* password) {
    //setup(ssid,password);
    Serial.println("*ESP: trying to setup access point");
    WiFi.softAP(ssid, password);
    //this->ip = WiFi.softAPIP();
  }

   void startAccessPoint(const char* ssid, const char* password, IPAddress ip , IPAddress gateway, IPAddress subnet) {
      //setup(ssid, password, ip , ateway,subnet) ;
      Serial.println("*ESP: trying to setup access point");
      WiFi.softAPConfig (ip, gateway, subnet) ;
      WiFi.softAP(ssid, password);
  }

  
  void connect(const char* ssid, const char* password) {
    //setup(ssid,password);
    Serial.println("*ESP: trying to connect");
    WiFi.begin(ssid, password);
    
  }

   void connect(const char* ssid, const char* password, IPAddress ip , IPAddress gateway, IPAddress subnet) {
      //setup(ssid, password, ip , ateway,subnet) 
      Serial.println("*ESP: trying to connect");
      WiFi.config(ip, gateway, subnet);
      WiFi.begin(ssid, password);
      
  }


  void autoConnect(const char* fallback_ssid, const char* fallback_password) {
    
    WiFiManager wifiManager;
    wifiManager.autoConnect(fallback_ssid,fallback_password);
    /*
    wifiManager.setConfigPortalTimeout(30); // 30s
   
    if(!wifiManager.autoConnect(fallback_ssid,fallback_password)) {
    	Serial.println("*WM: failed to connect, will reset");
    	delay(3000);    //reset and try again, or maybe put it to deep sleep
    	ESP.restart();
    	delay(5000);
	} 
  */

  }

  void autoConnect(const char* fallback_ssid, const char* fallback_password, IPAddress ip , IPAddress gateway, IPAddress subnet) {
    
    
    WiFiManager wifiManager;
    wifiManager.setSTAStaticIPConfig(ip, gateway, subnet);
    wifiManager.autoConnect(fallback_ssid,fallback_password);
    /*
    wifiManager.setConfigPortalTimeout(180); // 3 min
     if(!wifiManager.autoConnect(fallback_ssid,fallback_password)) {
    	Serial.println("*WM: failed to connect, will reset");
    	delay(3000);    //reset and try again, or maybe put it to deep sleep
    	ESP.restart();
    	delay(5000);
	} 
  */

  }


  
};

_EzEsp8266 EzEsp8266;

