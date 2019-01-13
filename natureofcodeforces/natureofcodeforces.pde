class Mover {
  
  PVector acceleration;
  PVector location;
  float mass;
  float diameter;
  PVector velocity;
  
  Mover(float m, float x, float y) {
    acceleration = new PVector(0, 0);
    location = new PVector(x, y);
    mass = m;
    diameter = mass * 16;
    velocity = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(255);
    fill(175);
    ellipse(location.x, location.y, diameter, diameter);
  }
  
  void adjustForEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }
    
    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  boolean isInside(Liquid l ) {
    boolean inHorizontal = location.x > l.x && location.x < l.x + l.w;
    boolean inVertical = location.y > l.y && location.y < l.y + l.h;
    return inHorizontal && inVertical;
  }
  
  void drag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.friction * speed * speed;
    
    PVector drag = velocity.copy();
    drag.mult(-1);
    drag.normalize();
    
    drag.mult(dragMagnitude);
    
    applyForce(drag);
  }
}

class Liquid {
  float x, y, w, h;
  float friction;
  
  Liquid(float x_, float y_, float w_, float h_, float friction_) {
   x = x_;
   y = y_;
   w = w_;
   h = h_;
   friction = friction_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x, y, w, h);
  }
}

int moverCount = 200;
Mover[] movers = new Mover[moverCount];
Liquid liquid;

void setup() {
  size(1710, 900);

  liquid = new Liquid(0, height/2, width, height/2, 0.1);

  for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), random(width), random(height));
  }
}


PVector gravity = new PVector(0, 0.1);

void draw() {
  background(0);
  
  liquid.display();

  for (int i = 0; i < movers.length; i++) {
    Mover m = movers[i];

    if (movers[i].isInside(liquid)) {
      movers[i].drag(liquid); 
    }
      
    PVector g = new PVector(gravity.x, gravity.y * m.mass);
    m.applyForce(g);

    m.update();
    m.adjustForEdges();
    m.display();
  }
}
