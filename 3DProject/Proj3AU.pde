

/**************************************************************************************************************************
 * Li Zheng work in 2014, m259 data visualization course                                                                  *
 * 2018 additions by George Legrady  
 * 2019 changes by Anagha Uppal
 *                                                                                                                        *
 * A 3D interactive demo that uses peasycam, updated in Processing 3.4 - February 20, 2019                               *
 *                                                                                                                        *
 * It compares the frequency of (interest in) religion (green) vs science (red)
 * in dewey classes over time.
 *                                                                                                                        *                                                                                                                   *
 *                                                                                                                        *
 **************************************************************************************************************************/
import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
//import peasy.test.*;

//Religion Hue, Saturation,Brightness, alpha variables
int ReligionHue = 103;
int ReligionSaturation = 67;
int ReligionBright = 61;
int ReligionTrans = 120;
//Science Hue, Saturation,Brightness, alpha variables
int ScienceHue = 254;
int ScienceSaturation = 172;
int ScienceBright = 173;
int ScienceTrans = 120;

color cColor = color(ReligionHue, ReligionSaturation, ReligionBright, ReligionTrans);//last value sets infograph transparency (0 fully transparent) -255 (fully opaque)
color jColor = color(ScienceHue, ScienceSaturation, ScienceBright, ScienceTrans); //last value sets infograph transparency

// Download and data from csv files
String cFile = "religion.csv";
String jFile = "science.csv";

String cString[], jString[];

int totalYear = 14;
int beginDewey = 50; //
int endDewey = 99;//endDewey stops at 99

int cVolume[][] = new int[totalYear][100];
int jVolume[][] = new int[totalYear][100];

//screen size and Z depth
int X = 680; //be the same as the size(x);
int Y = 520; //be the same as the size(y);
int Z = 5000; //peasycam Z depth

int ReligionHeight = 20; // starting log value for Religion to define data height
int ScienceHeight = 20; // Starting log value for Science to define data height

float zBase = 50; // height distance between gray platform and the two infographs

PeasyCam cam; // activate the PeasyCam interaction

// lining up the horizontal placement of the quads to match the bottom Dewey labels  
float adjustX = float(X)/(endDewey-beginDewey);
// lining up the vertical placement of the Quads to match the left year labels
float adjustY = float((Y-10))/(totalYear-1);



//----------------------------------------------------------
void setup() {
  size(1220, 980, P3D);
  smooth(); //Anti-aliasing of texts and visuals for a smooth visual effect

  // PeasyCam (this, x position, y position, z position, viewing distance (larger number means closer viewing)
  cam = new PeasyCam(this, X/2, Y/2, 100, 1800);
  // set onscreen visible distances for hte PeasyCam, otherwise it may not fully show
  cam.setMinimumDistance(1);//1
  cam.setMaximumDistance(Z);//was 5000, now 2000
  
  // Set the angle of view - like changing the lens on a camera PI/2 (wide angle); PI/6 normal lens; PI/12 (telephoto)
  float fov = PI/8; // field of view try between PI/2 to PI/10
  float cameraZ = (height/2.0) / tan(PI/6);
  //perspective(field of view in radians; aspect/ratio of width to height; zNear - Z position of nearest clipping, zFar - Z position of farthest clipping)
  //default values are : perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0) where cameraZ is ((height/2.0) / tan(PI*60.0/360.0));
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0); // if using 0.001 instead of cameraZ/10.0 so that all things close to the screen can be seen - get noise
  
}
//----------------------------------------------------------
void draw() {
  background(0);
  colorMode(HSB, 255);
  initializeData();
  drawPlatform(); //grey plate with labels
  drawReligion(); // red infograph
  drawScience(); //blue infograph

  //-------------Increase or decrease Religion and Science data using log()
    if (keyPressed) {
      if (key == CODED && keyCode == UP && ReligionHeight < 200) {
        ReligionHeight+=1;
      } else if (key == CODED && keyCode == DOWN && ReligionHeight >0) {
        ReligionHeight-=1;
      }
      if (key == CODED && keyCode == RIGHT && ScienceHeight < 200) {
        ScienceHeight+=1;
      } else if (key == CODED && keyCode == LEFT && ScienceHeight >0) {
        ScienceHeight-=1;
      }
      //change HSB for Religion-------------------------------
       else if (key == '2' && ReligionHue < 255) {
        ReligionHue+=1;
      } else if (key == '1' && ReligionHue > 0) {
        ReligionHue-=1;
      }
      if (key == '4' && ReligionSaturation < 255) {
        ReligionSaturation+=1;
      } else if (key == '3' && ReligionSaturation > 0) {
        ReligionSaturation-=1;
      }
      if (key == '6' && ReligionBright < 255) {
        ReligionBright+=1;
      } else if (key == '5' && ReligionBright > 0) {
        ReligionBright-=1;
      }
      if (key == '7' && ReligionTrans < 255) {
        ReligionTrans+=1;
      } else if (key == '8' && ReligionTrans > 0) {
        ReligionTrans-=1;
      }
       //change HSB for Science-------------------------------
      else if (key == 'w' && ScienceHue < 255) {
        ScienceHue+=1;
      } else if (key == 'q' && ScienceHue > 0) {
        ScienceHue-=1;
      }
      if (key == 'r' && ScienceSaturation < 255) {
        ScienceSaturation+=1;
      } else if (key == 'e' && ScienceSaturation > 0) {
        ScienceSaturation-=1;
      }
      if (key == 'y' && ScienceBright < 255) {
        ScienceBright+=1;
      } else if (key == 't' && ScienceBright > 0) {
        ScienceBright-=1;
      }
      if (key == 'u' && ScienceTrans <= 255) {
        ScienceTrans+=1;
      } else if (key == 'i' && ScienceTrans > 0) {
        ScienceTrans-=1;
      }
      println("Religion: " + ReligionHue, ReligionSaturation,ReligionBright,ReligionTrans + " | Science: " + ScienceHue, ScienceSaturation,ScienceBright,ScienceTrans + " | ReligionHeight: " + ReligionHeight + " | ScienceHeight: " + ScienceHeight);
    }
}
//----------------------------------------------------------
void initializeData() {
  //process Religion data
  cString = loadStrings(cFile);
  for (int j = 0; j < cString.length; j++) {
    String data[] = split(cString[j], ",");
    int year = (int)Integer.parseInt(data[0])-2006;
    int deweyNo = (int)Integer.parseInt(data[1])/10;
    int volume = (int)Integer.parseInt(data[2]);
    //try to use square root to show data. This will achive good effect when display data with huge difference(hundreds with ten thousands),
    //if data for different deweyClass does not have big difference, we can delete 'sqrt'
    // cVolume[year][deweyNo] = int(sqrt(volume)); // multiply by value to accentuate difference, make sure to add to both Science and Religion
    cVolume[year][deweyNo] = ReligionHeight*int(log(volume)); //
  }

  //process Science data
  jString = loadStrings(jFile);
  for (int j = 0; j < jString.length; j++) {
    String data[] = split(jString[j], ",");
    int year = (int)Integer.parseInt(data[0])-2006;
    int deweyNo = (int)Integer.parseInt(data[1])/10;
    int volume = (int)Integer.parseInt(data[2]);
    //try to use square root to show data. This will achive good effect when display data with huge difference(hundreds with ten thousands)
    //if data for different deweyClass does not have big difference, we can delete 'sqrt'
    jVolume[year][deweyNo] = ScienceHeight*int(log(volume));
  }
}


//----------------------------------------------------------
void drawReligion() {
  float z1, z2, z3, z4, x1, x2, y1, y2;

  cColor = color(ReligionHue, ReligionSaturation, ReligionBright, ReligionTrans);
  fill(cColor);

  for (int i = beginDewey; i < endDewey; i++) {
    for (int j = 0; j < totalYear - 1; j++) {
      beginShape(QUADS);
      z1 = min(cVolume[j][i], Z)+zBase;
      z2 = min(cVolume[j+1][i], Z)+zBase;
      z3 = min(cVolume[j+1][i+1], Z)+zBase;
      z4 = min(cVolume[j][i+1], Z)+zBase;

      x1 = (i-beginDewey)*adjustX;
      x2 = (i+1-beginDewey)*adjustX;
      y1 = j*adjustY;
      y2 = (j+1)*adjustY;
      vertex(x1, y1, z1);
      vertex(x1, y2, z2);
      vertex(x2, y2, z3);
      vertex(x2, y1, z4);
      endShape();
    }
  }
}
//----------------------------------------------------------
void drawScience() {
  float z1, z2, z3, z4, x1, x2, y1, y2;

  jColor = color(ScienceHue, ScienceSaturation, ScienceBright, ScienceTrans);
  fill(jColor);
  
  for (int i = beginDewey; i < endDewey; i++) {
    for (int j = 0; j < totalYear - 1; j++) {
      beginShape(QUADS);
      z1 = min(jVolume[j][i], Z)+zBase;
      z2 = min(jVolume[j+1][i], Z)+zBase;
      z3 = min(jVolume[j+1][i+1], Z)+zBase;
      z4 = min(jVolume[j][i+1], Z)+zBase;

      x1 = (i-beginDewey)*adjustX;
      x2 = (i+1-beginDewey)*adjustX;
      y1 = j*adjustY;
      y2 = (j+1)*adjustY;
      vertex(x1, y1, z1);
      vertex(x1, y2, z2);
      vertex(x2, y2, z3);
      vertex(x2, y1, z4);
      endShape();
    }
  }
}
//----------------------------------------------------------
void drawPlatform() {
 // fill(70, 80, 75, 180); //the gray bottom flat panel in RGB mode
 fill (160,100,100,140); 
  stroke(80);//partially transparent at 80 as 255 is full opaque
  rect(0, 0, X, Y); 
  int stickLength = 10;
  float adjustY = float((Y-10))/(totalYear-1);
  //draw Y
  for (int i = 0; i <= totalYear - 1; i++) {
    line(0-stickLength, i*adjustY+5, 0, i*adjustY+5);
    fill(255);
    text(i+2006, -50, i*adjustY+10);
  }
  //draw X
  float adjustX = float(X)/(endDewey-beginDewey);
  for (int i = beginDewey; i <= endDewey; i++) {
    line((i-beginDewey)*adjustX, Y, (i-beginDewey)*adjustX, Y-stickLength);
    textAlign(CENTER);
    text(i, (i-beginDewey)*adjustX, Y+2*stickLength);
  }

  text("DeweyClass/10", X/2, Y+50, 0);
}
//----------------------------------------------------------
