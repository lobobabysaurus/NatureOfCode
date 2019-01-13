class Mover {
  
  PVector location;
  float topspeed;
  PVector velocity;
  
  Mover() {
    location = new PVector(width/2, height/2);
    topspeed = 10;
    velocity = new PVector(0, 0);
  }
  
  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    dir.normalize();
    dir.mult(0.5);

    velocity.add(dir);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display() {
    stroke(255);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }
  
  void adjustForEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height; 
    }
  }
}

Mover[] movers = new Mover[20];

void setup() {
  size(1710, 900);
  for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(0);
  for (int i = 0; i < movers.length; i++) {
    Mover m = movers[i];
    m.update();
    m.adjustForEdges();
    m.display();
  }
}
