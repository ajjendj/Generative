//#inspired by http://beautifulprogramming.com/arachnocampa-luminosa/

Part[] allParts;
int numParts = 5;
boolean isPaused = false;
boolean firstTime;
 
Part part;
 
void setup()
{
  size(600, 600);
  colorMode(HSB, 1.0, 1.0, 1.0, 1.0);
  background(0.0);
  strokeWeight(1.01);
  createParts();
}
 
void draw()
{ 
  updateParts();
  saveFrame("frames/####.png");
}
 
void createParts()
{
  numParts = round(random(20, 30));
  allParts = new Part[numParts];
 
  for (int i=0; i<numParts; i++)
  {
    Part part = new Part(width/2, height/2, 0.1);
    allParts[i] = part;
  }
}
 
void updateParts()
{ 
  if (!isPaused)
  {
    for (int i=0; i<allParts.length; i++)
    {
      allParts[i].update();
    }
  }
}
 
void mousePressed()
{
  background(0);
  firstTime = true;
  createParts();
}
 
void keyPressed()
{
  if (key == 'c')
  {
    background(0);
  }
 
  if (key == 'p')
  {
    isPaused = !isPaused;
  }
}
 
class Part
{
  PVector pos = new PVector(0,0,0);
  PVector vel = new PVector(0,0,0);
  float size = 10;
  float scale;
  float accelMod = 0.1;
  float hue = 0.0;
  float sat = 0.0;
  float[] x, y;
  int formResolution;
 
  Part(float _x, float _y, float _accelMod)
  {
    accelMod = _accelMod;
    pos.set(_x, _y, 0);
    vel.set(random(-1, 1), random(-1, 1), 0);
    scale = random(5, 50);
    hue = random(0, 1);
    sat = random(0.5, 1);
    formResolution = 10;
    int radius = 5;
    
    x = new float[formResolution];
    y = new float[formResolution];

    // calculate new points
    float angle = radians(360/float(formResolution));
    for (int i=0; i<formResolution; i++){
      x[i] = cos(angle*i) * radius;
      y[i] = sin(angle*i) * radius;  
    }  
  }
 
  void update()
  {
    PVector accel = PVector.random3D();
    accel.mult(accelMod);
    vel.add(accel);
    vel.mult(0.995);
 
    pos.add(vel);     
    size += (vel.mag() * scale - size) * 0.02;
    wrap();
 
    noFill();
    stroke(hue, sat, 1.0, 0.02);
    
    for (int i=0; i<formResolution; i++){
        x[i] += random(-1,1);// ,stepSize);
        y[i] += random(-1,1);
    }
    beginShape();
    // start controlpoint
    curveVertex(x[formResolution-1]+pos.x, y[formResolution-1]+pos.y);
  
    // only these points are drawn
    for (int i=0; i<formResolution; i++){
      curveVertex(x[i]+pos.x, y[i]+pos.y);
    }
    curveVertex(x[0]+pos.x, y[0]+pos.y);
  
    // end controlpoint
    curveVertex(x[1]+pos.x, y[1]+pos.y);
    endShape();
    
    //ellipse(pos.x, pos.y, random(size-5,size+5), random(size-5,size+5));
  }
 
  void wrap()
  {
    float radius = size/2;
    float top = 0 - radius;
    float bottom = height + radius;
    float left = 0 - radius;
    float right = width + radius;
 
    if (pos.x > right)
    {
      pos.x = left;
    } else if (pos.x < left)
    {
      pos.x = right;
    }
 
    if (pos.y > bottom)
    {
      pos.y = top;
    } else if (pos.y < top)
    {
      pos.y = bottom;
    }
  }
}