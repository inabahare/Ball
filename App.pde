// The Ball function
class App {
  // Initialize the vectors
  PVector location; 
  PVector velocity;
  PVector acceleration;
  PVector friction;
  
  // Initialize the mass and size
  float mass;
  float size;
  
  
  // Initialize the ball app
  App(  
        float s,
        float m,
        float startX, 
        float startY, 
        float velX, 
        float velY
     ){
    location = new PVector(startX, startY);
    velocity = new PVector(velX, velY);
    acceleration = new PVector(0,0);
    
    mass = m; 
    size = s;
  }
  
  // Apply force to the object
  void applyForce(PVector force){
    
    PVector tmp = force.get();
    
    // Create a temp variable that stores the force divided by mass
    tmp.div(mass);
    
    // Add the force to the acceleration
    acceleration.add(tmp);
  }
  
  
  // Calculate the friction
  void friction(){
    float constant = 0.01;
    float normal = 1;
    float magnitude = constant * normal;
    
    PVector fr = velocity.get();
    fr.mult(-1);
    fr.normalize();
    fr.mult(magnitude);
    
    this.applyForce(fr);
  }
  
  // Move the vector
  void move(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  // Checks weather or not the velovity is bigger or smaller than the edges
  void checkEdges(){
    if(location.x + size/2 > width || location.x - size/2 < 0) {
      velocity.x *= -1;
    }
    
    if(location.y + (size/2) > height){
      location.y = height - size/2;
      velocity.y *= -1;
    }
  }
  
  // Run the program
  void run(){
    fill(0);
    ellipse(location.x, location.y, size, size);
  }
}
