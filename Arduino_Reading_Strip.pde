import processing.serial.*;

Serial myPort; //The serial port where the arduino is sending info
String inString; //Inputing string from the said serial port
int lf = 10; //for the buffer for ACSII

String[] photoSensorRead; //name of the sensor could change based on sensor
float n;

void setup() {
  size(1280, 720);
}

void draw() { //first read the sensor's value
  photoSensorRead = split(inString, '='); //subdividing the test string at "=", (Prof.)
  //println("photoSensorRead " + photoSensorRead); //just to see it working, not needed later
  ////arduino output _arduinosensor = number
  
  if (photoSensorRead.length > 1) {
    String num = photoSensorRead[1];
    n = float(Integer.parseInt(num.trim()));
  } //parsing text value of photosensor value (Prof.)
  
  // set a value = map(n, 0.0, 1024.0, x, y), x and y being the range you need
  // create a function that you may want to run with this
  
 void serialEvent(Serial p) {
  inString = p.readString();
}