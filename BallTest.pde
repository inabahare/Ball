// Data for the screen
int sizeX = 200;
int sizeY = 200;
color bg = color(255);

// Data for the balls
int ballAmount = 10;
App[] ball = new App[ballAmount];

// Forces
PVector gravity = new PVector (0, 0.01);

// The program 
// App ball;

void setup(){
  size(sizeX, sizeY);
  frameRate(60);
  background(bg);
  smooth();
  for(int i = 0; i < ballAmount; i++){
    ball[i] = new App(random(width - 50), random(height - 50), random(-2.2), random(-5,5), i, ball);
  }
}
 
void draw() {
  background(bg);
  
  // Draw the ball
  for(App balls : ball){
    balls.applyForce(gravity);
    balls.checkEdges();
    balls.collision(1);
    balls.move();
    balls.run(5);
  }
}

// The Ball function
class App {
  // Initialize the vectors
  PVector location; 
  PVector velocity;
  PVector acceleration;
  
  // Initialize the mass and size
  float mass;
  float size;
  
  // Data
  int id;
  
  // Array of balls
  App[] balls;
  
  
  // Initialize the ball app
  App(
        float startX, 
        float startY, 
        float velX, 
        float velY, 
        int tmpId, 
        App[] blls
     ){
    location = new PVector(startX, startY);
    velocity = new PVector(velX, velY);
    acceleration = new PVector(0,0);
    
    mass = 10;
    
    id = tmpId;
    
    balls = blls;
  }
  
  // Apply force to the object
  void applyForce(PVector force){
    
    // Create a temp variable that stores the force divided by mass
    PVector tmp = PVector.div(force,mass);
    
    // Add the force to the acceleration
    acceleration.add(tmp);
  }
  
  // Calculate the collision between two or more balls
  void collision(float spring){
    for(int i = id + 1; i < ballAmount; i++){
      
      // Find the difference in locations
      float distanceX = balls[i].location.x - location.x;
      float distanceY = balls[i].location.y - location.y;
      
      // Calculate the distance using Phytagoras
      float distance = sqrt(sq(distanceX) + sq(distanceY));
      
      // Calculate the minimum accepted distance
      float minDistance = (balls[i].size / 2) + (size / 2);
      
      if(distance < minDistance){
        float angle = atan2(distanceY, distanceX);
        
        PVector target = new PVector(location.x + cos(angle) * minDistance, location.y + sin(angle) * minDistance); 
        
        PVector a = new PVector((target.x - balls[i].location.x) * spring, (target.y - balls[i].location.y) * spring);
        
        velocity.sub(a);
        
        balls[i].velocity.add(a);
      }
    }
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
