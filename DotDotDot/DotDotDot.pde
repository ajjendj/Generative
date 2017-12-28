Sun suns[][]; //array of array of sun rings

color palette[] = new color[] {
  color(#D90000,255),
  color(#FF2D00,255),
  color(#FF8C00,255),
  color(#04756F,255)}; 
float ror = random(1,1.2);
  
void setup() {
  //setup
  size(600,600);
  background(#2E0927);
  frameRate(30);
  smooth(8);
  //strokeCap(SQUARE);
  ellipseMode(CENTER);
  noStroke();
  suns = new Sun[11][11];
  
  for (int j=1; j<=suns.length;j++) {
    for(int i=1; i<=suns[0].length; i++) {
        suns[j-1][i-1] = new Sun(50*i,50*j,(int)((55)),(int)((60)),palette);
        //ellipse(100*i, 100*j, 25, 25);
    }
  }  
}

void draw() {
  //initialize and draw sun
  for (int j = 0; j < suns.length; j++) {
    for(int i=0; i<suns.length; i++) {
      suns[j][i].draw();  
    }
  }
  int i = (int)(random(1,12));
  int j = (int)(random(1,12));
  stroke(#FF8C00);
  ellipse(50*i,50*j, 5, 5);
  saveFrame("frames/####.png");
}