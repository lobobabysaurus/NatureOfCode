class Oscillator {
  PVector angle;
  PVector velocity;
  PVector amplitude;
  
  Oscillator() {
    angle = new PVector();
    velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
    amplitude = new PVector(random(width / 2), random(height / 2));
  }
  
  void oscillate() {
    angle.add(velocity);
  }
  
  void display() {
    float x = sin(angle.x) * amplitude.x;
    float y = sin(angle.y) * amplitude.y;
    
    pushMatrix();
    translate(width / 2, height / 2);
    stroke(255);
    fill(125);
    line(0, 0, x, y);
    ellipse(x, y, 16, 16);
    popMatrix();
  }
}

float startAngle = 0;
float angleVel = 0.2;

int oscillatorCount = 100;
Oscillator[] oscillators = new Oscillator[oscillatorCount];

void setup() {
  size(1710, 900);

  //for (int i =0; i < oscillators.length; i++) {
  //  oscillators[i] = new Oscillator();
  //}
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  
  float angle = startAngle;
  
  for (int x = 0; x <= width; x += 5) {
    float y = map(sin(angle), -1, 1, 0, height);
    stroke(255);
    fill(0,50);
    ellipse(x, y, 48, 48);
    angle += angleVel;
  }
  
  //for (int i = 0; i < oscillators.length; i++) {
  //    Oscillator o = oscillators[i];
  //    o.oscillate();
  //    o.display();
  //}
}
