float gravity = 1;

class Mover {
  
  PVector acceleration;
  PVector location; 
  PVector velocity;

  float mass;
  float diameter;
  
  float angle;
  float aVelocity;
  float aAcceleration;
  
  Mover(float m, float x, float y) {
    acceleration = new PVector(0, 0);
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    
    mass = m;
    diameter = mass * 16;
    
    angle = 0;
    aVelocity = 0;
    aAcceleration = 0;
    velocity = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    aAcceleration = acceleration.x / 10;
    
    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.1, 0.1);
    angle += aVelocity;

    acceleration.mult(0);
  }
  
  void display() {
    stroke(255);
    fill(175);
    
    float angle = velocity.heading();
    rectMode(CENTER);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(0, 0, diameter, diameter);
    popMatrix();
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = constrain(force.mag(), 5, 25);
    force.normalize();
    
    float strength = (gravity * mass * m.mass ) / (distance * distance);
    
    return force.mult(strength);
  }
}

int moverCount = 100;
Mover[] movers = new Mover[moverCount];

void setup() {
  size(1710, 900);

  for (int i =0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), random(width), random(height));
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < movers.length; i++) {
    Mover m = movers[i];
    for (int j = 0; j < movers.length; j++) {
      if (j != i) {
        PVector f = movers[j].attract(m);
        m.applyForce(f);
      }
    }
    m.update();
    m.display();
  }
}
