// Test

// Data for the screen
int sizeX = 200;
int sizeY = 200;
color bg = color(255);

// Data for the balls
int numberOfBalls = 10;
App[] ball;

// Forces
PVector gravity = new PVector (0, 0.1);

// The program 
// App ball;

void setup(){
  size(sizeX, sizeY);
  frameRate(60);
  background(bg);
  smooth();
  for(int i = 0; i <= numberOfBalls; i++){
    ball[i] = new App(width / 2,50, random(-5,5), random(-2,2));
  }
}
 
void draw() {
  background(bg);
  
  // Draw the ball
  for(App baall : ball){
    
  }
  
  ball.applyForce(gravity);
  ball.move();
  ball.checkEdges();
  ball.run(50);
  
  fill(0);
  text(ball.location.y, 10, 20);
}

class App {
  // Initialize the vectors
  PVector location; 
  PVector velocity;
  PVector acceleration;
  
  // Initialize the mass and size
  float mass;
  float size;
  
  // Initialize the ball app
  App(float startX, float startY, float velX, float velY){
    location = new PVector(startX, startY);
    velocity = new PVector(velX, velY);
    acceleration = new PVector(0,0);
    
    mass = 10;
  }
  
  // Apply force to the object
  void applyForce(PVector force){
    
    // Create a temp variable that stores the force divided by mass
    PVector tmp = PVector.div(force,mass);
    
    // Add the force to the acceleration
    acceleration.add(tmp);
  }
  
  void collision(float spring){
    
  }
  
  
  
  // Move the vector
  void move(){
    velocity.add(acceleration);
    location.add(velocity);
  }
  
  // Checks weather or not the velovity is bigger or smaller than the edges
  void checkEdges(){
    if(location.x + size/2 > width || location.x - size/2 < 0) {
      velocity.x *= -1;
    }
    
    if(location.y + size/2 >= height){
      velocity.y *= -1;
      location.y = height - size/2;
    }
  }
  
  // Run the program
  void run(float s){
    size = s;
    fill(0);
    ellipse(location.x, location.y, size, size);
  }
}
