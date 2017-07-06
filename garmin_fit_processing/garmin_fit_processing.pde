
GarminFit garminFit;

void setup() {

  size(640, 480);

  garminFit = new GarminFit("2017-05-13-17-09-44.fit");

  //printEntryList(garminFit.gyroscope);
  //printEntryList(garminFit.distance);
  printEntryList(garminFit.accelerometer);
  //printEntryList(garminFit.magnetometer);
  //printEntryList(garminFit.gps);
}


void draw() {

  background(0);
  
  noStroke();
  fill(255,0,0);
  displayEntry( garminFit.distance,0,96);
   fill(0,255,0);
  displayEntry( garminFit.accelerometer,30000,33000);
}  





void displayEntry(ArrayList<GarminFit.Entry> list, int dataMin, int dataMax) {
  for ( int i =0; i < list.size(); i ++ ) {
    GarminFit.Entry entry = list.get(i);
    float x = i/(float)list.size()*width;

    long timestamp = entry.timestamp;

    for ( int j =0; j < entry.data.length; j++ ) {
      ellipse( x, map(entry.data[j], dataMin, dataMax, height, 0), 5, 5);
    }
  }
}

void printEntryList( ArrayList<GarminFit.Entry> list ) {
  for ( int i =0; i < list.size(); i ++ ) {

    print("["+i+"]");

    GarminFit.Entry entry = list.get(i);

    print(" ");
    print(entry.timestamp);

    for ( int j =0; j < entry.data.length; j++ ) {
      print(" ");
      print(entry.data[j]);
    }
    println();
  }
}