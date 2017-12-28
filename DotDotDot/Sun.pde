/** Sun class
*   consists of a rotating wheels with several segments (inspired by Chashnik's circular paintings)
*/

class Sun {
  Segment segments[];
  int x, y;
  int innerRadius, outerRadius;
  
  // constructor: takes x,y coordinates of center, inner and outer-radius as well as color palette 
  public Sun(int x, int y, int innerRadius, int outerRadius, color[] palette) {
    this.x = x;
    this.y = y;
    this.innerRadius = (int)(innerRadius * 2 );
    this.outerRadius = (int)(outerRadius * 2 );
    segments = new Segment[palette.length];
     
    float maxLength = TWO_PI;
    for(int i=0; i<palette.length; i++) {
      maxLength = random(maxLength / 2, maxLength);
      segments[i] = new Segment(random(TWO_PI),maxLength,random(-0.2,0.2),innerRadius,outerRadius,i%palette.length);
    }
  }
   
  void draw() {
    pushMatrix();
    translate(x,y);
    for(int i=0; i<segments.length; i++)
      segments[i].draw();
    popMatrix(); 
  }
  
  //inner segment class
  class Segment {
    float phase, length, phaseInc;
    int innerRadius, outerRadius;
    int colorIndex;
     
    public Segment(float phase, float length, float phaseInc, int innerRadius, int outerRadius, int colorIndex) {
      this.phase = phase;
      this.length = length;
      this.phaseInc = phaseInc;
      this.innerRadius = innerRadius;
      this.outerRadius = outerRadius;
      this.colorIndex = colorIndex;
    }
     
    void draw() {
      phase += phaseInc;
      int mid = (innerRadius + outerRadius) / 2;
      stroke(palette[colorIndex]);
      strokeWeight(outerRadius - innerRadius);
      noFill();
      arc(0,0,mid,mid,phase, phase + length);
    }
  } 
}