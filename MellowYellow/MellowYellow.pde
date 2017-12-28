import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;
color col1 = color(255,75,25,150);
color col2 = color(0,0,0,150);
color col3 = color(50,255,200,100);

//int cx, int cy, color c, float r, int fR, int sZ, boolean h
DistCirc C1 = new DistCirc(-50,250,col1,50,100,1,true);
DistCirc C2 = new DistCirc(-50,150,col2,10,5,1,true);
DistCirc C3 = new DistCirc(-50,450,col3,20,50,1,true);

DistCirc C4 = new DistCirc(200,-50,col3,20,20,1,false);

void setup() {
  size(600,600);
  smooth();
  background(255, 220, 20);

}

void draw() {
  C1.update();
  C2.update();
  C3.update();
  C4.update();
  saveFrame("frames/####.png");
}

class DistCirc {
  int centerX, centerY;
  color col;
  float radius;
  int formResolution;
  float[] x, y;
  int stepSize;
  boolean horizontal;
  
  DistCirc (int cx, int cy, color c, float r, int fR, int sZ, boolean h) {
    centerX = cx;
    centerY = cy;
    col = c;
    radius = r;
    formResolution = fR;
    stepSize = sZ;
    horizontal = h;
    
    x = new float[formResolution];
    y = new float[formResolution];

    // calculate new points
    float angle = radians(360/float(formResolution));
    for (int i=0; i<formResolution; i++){
      x[i] = cos(angle*i) * radius;
      y[i] = sin(angle*i) * radius;  
    }  
  }
  
  void update() {
    if (horizontal == true) {
      for (int i=0; i<formResolution; i++){
        x[i] += noise(stepSize);// ,stepSize);
        y[i] += random(-stepSize,stepSize);
      }
    } else {
      for (int i=0; i<formResolution; i++){
        x[i] += random(-stepSize,stepSize);// ,stepSize);
        y[i] += noise(stepSize);
      }
    }
    strokeWeight(0.05);
    stroke(col);
    noFill();
    beginShape();
    // start controlpoint
    curveVertex(x[formResolution-1]+centerX, y[formResolution-1]+centerY);
  
    // only these points are drawn
    for (int i=0; i<formResolution; i++){
      curveVertex(x[i]+centerX, y[i]+centerY);
    }
    curveVertex(x[0]+centerX, y[0]+centerY);
  
    // end controlpoint
    curveVertex(x[1]+centerX, y[1]+centerY);
    endShape();
  }
  
}