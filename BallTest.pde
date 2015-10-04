// Data for the screen
int sizeX = 200;
int sizeY = 200;
color bg = color(255);

// Data for the balls
int ballAmount = 10;
App[] ball = new App[ballAmount];

// Forces
PVector gravity = new PVector (0, 9.82);

// The program 
// App ball;

void setup(){
  size(sizeX, sizeY);

  background(bg);

  for(int i = 0; i < ballAmount; i++){
    ball[i] = new App(10, 10, random(50, width - 50), random(height - 50), random(-2.2), random(-5,5));
  }
}
 
void draw() {
  background(bg);
  
  // Draw the ball
  for(App balls : ball){
    balls.checkEdges();
    
    balls.friction();
    balls.applyForce(gravity);
    
    balls.move();
    balls.run();
  }
}


