/**************************************************************
 * File: a3.pde
 * Group: <Group members,group number>
 * Date: 14/03/2018
 * Course: COSC101 - Software Development Studio 1
 * Desc: Astroids is a ...
 * ...
 * Usage: Make sure to run in the processing environment and press play etc...
 * Notes: If any third party items are use they need to be credited (don't use anything with copyright - unless you have permission)
 * ...
 **************************************************************/

float astroidSize = 70; 
float rotated = 0.0;
int initalised = 0;
PImage bg; 
PShape ship;
PShape fowardThrust;
PShape reverseThrust; 
int astroNums = 10;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums]; 
float speed = 0; 
float maxSpeed =4; 
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
PVector direction;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false, sDOWN=false, sRIGHT=false, sLEFT=false;
int score=0;
boolean alive=true;
ArrayList<Missile> missiles = new ArrayList<Missile>();
PVector[] triangle = new PVector[8];
int scoreCount = 0;


void setup() {
  size(1000, 800);
  bg = loadImage("SpaceBackground.jpg");
  bg.resize(1000,800); 
  shipCoord = new PVector(width/2, height/2);
  direction = new PVector(0, 0); 
  ship();
  buildFowardThrust();
  buildReverseThrust(); 
  drawAstroids();
  initalised = 1;// sets initalised variable to 1.
}

/**************************************************************
 * Function: myFunction()
 * Parameters: None ( could be integer(x), integer(y) or String(myStr))
 * Returns: Void ( again this could return a String or integer/float type )
 * Desc: Each funciton should have appropriate documentation. 
 This is designed to benefit both the marker and your team mates.
 So it is better to keep it up to date, same with usage in the header comment
 ***************************************************************/

void moveShip() {

  if (sUP) {
    speed += 0.1; 
    direction.x = cos(rotated+radians(270))*(speed);  //+radians(270) to make sure the ship is facing upwards/moves in the right direction
    direction.y = sin(rotated+radians(270))*(speed);  //+radians(270) to make sure the ship is facing upwards/moves in the right direction
    fowardThrust();
  }

  if (sDOWN) {
    speed -= 0.1;
    direction.x = cos(rotated+radians(270))*(speed);
    direction.y = sin(rotated+radians(270))*(speed);
    reverseThrust(); 
  }

  if (sRIGHT) {
    rotated+=0.05;
  }
  if (sLEFT) {
    rotated-=0.05;
  }

  //Next two if statements keep speed inside max speed limits 
  if (speed>= maxSpeed) { 
    speed = maxSpeed;
  }
  if (speed <= -1*(maxSpeed)) { 
    speed = -1*(maxSpeed);
  }

  shipCoord.add(direction); //moves the ship even if a key has not been pushed. 

  if (shipCoord.x >=width) { //brings the ship back if it goes off screen. 
    shipCoord.x -= width;
  }
  if (shipCoord.x <= 0) {//brings the ship back if it goes off screen. 
    shipCoord.x += width;
  }
  if (shipCoord.y >= height) {//brings the ship back if it goes off screen. 
    shipCoord.y -= height;
  }
  if (shipCoord.y <= 0) {//brings the ship back if it goes off screen. 
    shipCoord.y += height;
  }
}

void ship() {
  ship = createShape();
  ship.beginShape();
  ship.fill(0);
  ship.stroke(255);
  ship.strokeWeight(1);
  ship.vertex(15, 0);
  ship.vertex(0, 30);
  ship.vertex(15, 20);
  ship.vertex(30, 30);
  //ship.translate(-15,-15);
  ship.endShape(CLOSE);
}

class Missile {
  float x, y, angle;

  Missile(float xpos, float ypos, float a) {
    x = xpos;
    y = ypos;
    angle = a;
  }
}

void draw_missiles() {
  for (int i = 0; i<missiles.size(); i++) {
    Missile m = missiles.get(i);
    stroke(255);
    point(m.x, m.y);
    m.x += cos(m.angle+radians(270))*5;  // Issues: bullets move when rotating the ship. When the ship is rotated slightly the bullets fire in weird directions.
    m.y += sin(m.angle+radians(270))*5;
    //if(m.x > width || m.x < 0 || m.y > height || m.y < 0) {    This is not currently working. Shots don't appear.
    //  missiles.remove(m);
    //}
    //print(missiles);
  }
}
void buildFowardThrust() { 
  fowardThrust = createShape();  
  fowardThrust.beginShape(TRIANGLES);
  fowardThrust. fill(122, 186, 221);
  fowardThrust.vertex(30, 75);
  fowardThrust.vertex(40, 20);
  fowardThrust.vertex(50, 75);
  fowardThrust.endShape();
}

void buildReverseThrust(){
  reverseThrust = createShape();  
  reverseThrust.beginShape(TRIANGLES);
  reverseThrust. fill(122, 186, 221);
  reverseThrust.vertex(7.5, -20);
  reverseThrust.vertex(2.5, -60);
  reverseThrust.vertex(12.5, -60);
  reverseThrust.vertex(22.5, -20);
  reverseThrust.vertex(17.5, -60);
  reverseThrust.vertex(27.5, -60);
  reverseThrust.endShape(); }
  
void fowardThrust() {
  pushMatrix();
  translate(shipCoord.x, shipCoord.y);
  rotate(rotated);
  shape(fowardThrust, -ship.width/2 - 25, ship.height/2 -25) ; 
  popMatrix();
}
void reverseThrust(){
  pushMatrix();
  translate(shipCoord.x, shipCoord.y);
  rotate(rotated);
  shape(reverseThrust, -ship.width/2, ship.height/2) ; 
  popMatrix();
}
  
void drawAstroids() {
  if (initalised == 0) { //initalised variable added to ensure that the PVectors arrays are only populated once.  
    //populates the PVector astroids[] and PVector astroDirect[]
    for (int a =0; a < astroNums; a++) { 
      astroids[a] = new PVector(0, 0, 0); // places random generated numbers into PVector
      astroids[a].x = random(width/4); //generates random x value for astroid starting point
      astroids[a].y = random(height); //generates random y value for astroid starting point

      fill(209); // colour of astroid 
      ellipse(astroids[a].x, astroids[a].y, astroidSize, astroidSize); //prints the astroid on the screen

      astroDirect[a] = new PVector(0, 0); // places random generated numbers into PVector
      astroDirect[a].x = random(-2, 2); //generates random x value for astroid direction
      astroDirect[a].y = random(-2, 2); //generates random y value for astroid direction

      astroids[a].z = 0; // Boolean value to indicate that the astroid has not been exploded.
    }
  } else {
    // Adds the Pvectors astroids[] and astroDirect[]
    for (int d = 0; d< astroNums; d++) {  

      if (astroids[d].z == 0) {     // checks to see if astroid has exploded or not. 0 = Alive, 1 = Exploded

        astroids[d].add(astroDirect[d]);//Draws the astroid on the screen

        if (astroids[d].x >=width) { //brings the astroid back if it goes off screen. 
          astroids[d].x -= width;
        }
        if (astroids[d].x <= 0) {//brings the astroid back if it goes off screen. 
          astroids[d].x += width;
        }
        if (astroids[d].y >= height) {//brings the astroid back if it goes off screen. 
          astroids[d].y -= height;
        }
        if (astroids[d].y <= 0) {//brings the astroid back if it goes off screen. 
          astroids[d].y += height;
        }
        stroke(209);
        fill(209);// colour of astroid
        ellipse(astroids[d].x, astroids[d].y, astroidSize, astroidSize); //prints the astroid on the screen
      }
    }
  }
}

void asteroidCollisionDetection() {
  triangle[0] = new PVector(((shipCoord.x)-15)+15, ((shipCoord.y)-15)+0); //Pvector coordinates of ship's vertex (15,0)
  triangle[1] = new PVector(((shipCoord.x)-15)+7.5, ((shipCoord.y)-15)+15); //Pvector coordinates of ship's vertex (7.5,15) half way between two pvectors
  triangle[2] = new PVector(((shipCoord.x)-15)+0, ((shipCoord.y)-15)+30); //Pvector coordinates of ship's vertex (0,30)
  triangle[3] = new PVector(((shipCoord.x)-15)+7.5, ((shipCoord.y)-15)+25); //Pvector coordinates of ship's vertex (7.5,25) half way between two pvectors
  triangle[4] = new PVector(((shipCoord.x)-15)+15, ((shipCoord.y)-15)+20); //Pvector coordinates of ship's vertex (15,20)
  triangle[5] = new PVector(((shipCoord.x)-15)+22.5, ((shipCoord.y)-15)+25); //Pvector coordinates of ship's vertex (22.5,25) half way between two pvectors
  triangle[6] = new PVector(((shipCoord.x)-15)+30, ((shipCoord.y)-15)+30); //Pvector coordinates of ship's vertex (30,30)
  triangle[7] = new PVector(((shipCoord.x)-15)+22.5, ((shipCoord.y)-15)+15); //Pvector coordinates of ship's vertex (22.5,15) half way between two pvectors

  //Tests each asteroid
  for (int d = 0; d< astroNums; d++) { 
    //For each asteroid, each point of the ship is tested for collision
    if ((dist(triangle[0].x, triangle[0].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[1].x, triangle[1].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[2].x, triangle[2].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[3].x, triangle[3].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[4].x, triangle[4].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[5].x, triangle[5].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[6].x, triangle[6].y, astroids[d].x, astroids[d].y)<=astroidSize/2 ||
      dist(triangle[7].x, triangle[7].y, astroids[d].x, astroids[d].y)<=astroidSize/2) && astroids[d].z == 0) {
      alive=false;
    }
  }
}

void missileCollisionDetection() {
  for (int d = 0; d< astroNums; d++) { //Tests each asteroid
    for (int i = 0; i<missiles.size(); i++) { //Tests each missile against each asteroid
      Missile m = missiles.get(i);
      stroke(255);
      point(m.x, m.y);
      if ((dist(m.x, m.y, astroids[d].x, astroids[d].y)<=astroidSize/2) && astroids[d].z == 0) {
        astroids[d].z = 1; //Removes asteroid
        m.x = 10000; //Takes collided missiles off screen
        m.y = 10000; //Takes collided missiles off screen
        scoreCount += 1; //Increments everytime an astroid is destroyed
      }
    }
  }
}

void gameState() {

  //Game Screen
  if (alive==true) {
    noCursor();
    fill(0, 255, 0);
    stroke(0, 255, 0);
    textSize(20);
    text("asteroids: " + scoreCount + "/" + astroNums, 50, 50);
  }

  //GameOver Screen
  if (alive==false) {
    background(0);
    fill(255);
    textSize(100);
    text("GAME OVER", 200, 400);
    noLoop();
    cursor();
  }

  //Completed Screen
  if (scoreCount == astroNums) {
    background(0);
    fill(255);
    textSize(80);
    text("Completed!", 260, 350);
    text("Well Done!", 280, 450);
    noLoop();
    cursor();
  }
}


void draw() {
  background(bg);  
  pushMatrix();
  translate(shipCoord.x, shipCoord.y); // Moves origin to the centre of the screen.
  rotate(rotated);
  shape(ship, -ship.width/2, -ship.height/2); //Makes the ship at the centre of the screen.
  if (rotated >=TWO_PI) rotated = 0;
  if (rotated<0) rotated = TWO_PI;
  popMatrix(); 
  draw_missiles();
  asteroidCollisionDetection();
  missileCollisionDetection();
  //might be worth checking to see if you are still alive first
  moveShip();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
  // draw score
  gameState(); //What state the game is in
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=true;
    }
    if (keyCode == DOWN) {
      sDOWN=true;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=true;
    }
    if (keyCode == LEFT) {
      sLEFT=true;
    }
  }
  if (key == ' ') {
    //fire a shot
    missiles.add(new Missile(shipCoord.x, shipCoord.y, rotated));  //Adds a missile to the arraylist missiles. 0,-10 makes them appear from the point of the ship. Rotated is the angle they are supposed to fire.
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      sUP=false;
    }
    if (keyCode == DOWN) {
      sDOWN=false;
    } 
    if (keyCode == RIGHT) {
      sRIGHT=false;
    }
    if (keyCode == LEFT) {
      sLEFT=false;
    }
  }
}