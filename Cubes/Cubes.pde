void setup() {
  size(800, 800);
  frameRate(1);
}

void draw() {
  background(0,75,120);
  
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 7; j++) {
      polygon(i*100 + 100, j*100 + 100, 25, 6);
    }
  }
  saveFrame("frames/####.png");
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  noFill();
  strokeWeight(5);
  strokeCap(ROUND);

  float a = -TWO_PI/12;
  float sx1 = x + cos(a) * radius;
  float sy1 = y + sin(a) * radius;
  for (a = TWO_PI/12; a <= TWO_PI; a += angle) {
    float sx2 = x + cos(a) * radius;
    float sy2 = y + sin(a) * radius;
    float r = random(100);
    if (r > 50){
      stroke(255,220,0);
      line(sx1,sy1,sx2,sy2);
    } 
    sx1 = sx2;
    sy1 = sy2;
  }
  for (a = TWO_PI/12; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    float r = random(100);
    if (r > 50){
      stroke(255,220,0);
      line(x,y,sx,sy);
    } 
  }
}