import processing.serial.*;
import java.awt.event.KeyEvent;
import java.io.IOException;
Serial myPort;
String data="";
float roll, pitch,yaw;
void setup() {
  size (1920, 1080, P3D);
  myPort = new Serial(this, "COM5", 57600);//need to modify
  myPort.bufferUntil('\n');
}
void draw() {
  translate(width/2, height/2, 0);
  background(200);
  textSize(30);
  text("Roll: " + int(roll) + "     Pitch: " + int(pitch)+ "     Yaw: " + int(yaw), -100, 265);

  rotateX(radians(-roll));
  rotateZ(radians(-pitch));
  rotateY(radians(yaw));

  textSize(30);  
  fill(243, 23, 40);
  box (380, 50, 200); 
  textSize(25);
  fill(200, 250, 250);
  text("Arm", -120, 10, 100);
}
void serialEvent (Serial myPort) { 
  data = myPort.readStringUntil('\n');
  if (data != null) {
    data = trim(data);
    String items[] = split(data, '/');
    if (items.length > 1) {
      //--- Roll,Pitch in degrees
      roll = float(items[0]);
      pitch = float(items[1]);
      yaw = float(items[2]);
    }
  }
}
