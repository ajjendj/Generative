color[] palette = {#5C4B51, #8CBEB2, #F2EBBF, #F3B562, #F06060,#FF6138,#FFFF9D,#BEEB9F,#79BD8F,
                  #FCFFF5,#193441,#91AA9D,#D1DBBD,#3E606F,#ACF0F2,#F3FFE2,#1695A3,#EB7F00,#225378,#00A388};
float yoff = 0.80;
Drop[] rain;

void setup() {
  size(600, 600);
  frameRate(10);
  //d = new Drop(100,100,2);
  rain = new Drop[200];
  for (int i = 0; i < 200; i++) {
    rain[i] = new Drop(int(random(0, width)), int(random(0, height)), int(random(2, 4)));
  }
}

void draw() {
  background(#2C3E50);
  
  strokeWeight(2);
  stroke(53);
  
  for (int rep = 0; rep < 20; rep += 1) {
    
    noiseSeed(rep);
    fill(palette[rep],200);
    beginShape();
    
    float xoff = 0;
    
    //Iterate over horizontal pixels
    for (float x = 0; x <= width; x += 10) {
      // Calculate a y value according to noise
      float y = map(noise(xoff, yoff), 0, 1, 200 + rep*20, 300 + rep*20);
      
      vertex(x,y);
      xoff += 0.025;
    }
    
    yoff += 0.01;
    vertex(width,height);
    vertex(0,height);
    endShape(CLOSE);
  }
  
  for (int i = 0; i < 200; i++) {
    rain[i].update();
  }
  
  saveFrame("frames/####.png");
}

class Drop {
  int x1, y1;
  float sp;
  int x2, y2;
  
  Drop (int x, int y, int s) {
    x1 = x;
    x2 = y;
    sp = s;
  }
  
  void update() {

      y1 = y1 + int(sp * int(random(50,100)));
      x2 = x1 + int(random(5,10));
      y2 = y1 + int(random(100,150));
  
      stroke(200,200,200,150);
      line(x1, y1, x2, y2);
  
      if (y1 >= height - 100) {
        noFill();
        stroke(int(random(100,200)),150);
        ellipse(x1, height - random(30, 300), random(15, 50), random(5,10));
        x1 = int(random(0, width));
        y1 = -120;
      }
    }
}