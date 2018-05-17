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
PShape ship; // don't have to use pshape - can use image
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums]; 
float speed = 0; 
float maxSpeed =4; 
float radians=radians(270); //if your ship is facing up (like in atari game)
PVector shipCoord;
PVector direction;
ArrayList shots= new ArrayList();
ArrayList sDirections= new ArrayList();
boolean sUP=false,sDOWN=false,sRIGHT=false,sLEFT=false;
int score=0;
boolean alive=true;



void setup(){
  size(1000,800);
  shipCoord = new PVector(width/2, height/2);
  direction = new PVector(0,0); 
  ship();// Creates PShape of ship 
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

void moveShip(){
  
  if(sUP){
    speed += 0.1; 
    direction.x = cos(rotated+radians(270))*(speed);  //+radians(270) to make sure the ship is facing upwards/moves in the right direction
    direction.y = sin(rotated+radians(270))*(speed);  //+radians(270) to make sure the ship is facing upwards/moves in the right direction
  }
    
  if(sDOWN){
    speed -= 0.1;
    direction.x = cos(rotated+radians(270))*(speed); //<>//
    direction.y = sin(rotated+radians(270))*(speed); 
     
  }
  
  if(sRIGHT){
    rotated+=0.05;
  }
  if(sLEFT){
    rotated-=0.05;
  }
  
  //Next two if statements keep speed inside max speed limits 
   if (speed>= maxSpeed){ 
      speed = maxSpeed; }
   if (speed <= -1*(maxSpeed)){ 
      speed = -1*(maxSpeed); }

   shipCoord.add(direction); //moves the ship even if a key has not been pushed. 
 
   if (shipCoord.x >=width) { //brings the ship back if it goes off screen. 
         shipCoord.x -= width; }
   if (shipCoord.x <= 0){//brings the ship back if it goes off screen. 
         shipCoord.x += width;}
   if (shipCoord.y >= height){//brings the ship back if it goes off screen. 
         shipCoord.y -= height;}
   if (shipCoord.y <= 0){//brings the ship back if it goes off screen. 
         shipCoord.y += height;} 
  }

void ship() {
  
  ship = createShape();
  ship.beginShape();
  ship.noFill();
  ship.stroke(255);
  ship.strokeWeight(1);
  ship.vertex(15,0);
  ship.vertex(0,30);
  ship.vertex(15,20);
  ship.vertex(30,30);
  //ship.translate(-15,-15);
  ship.endShape(CLOSE); 
  
}


void drawShots(){
   //draw points for each shot from spacecraft 
   //at location and updated to new location
}

void drawAstroids(){
  if (initalised == 0){ //initalised variable added to ensure that the PVectors arrays are only populated once.  
     //populates the PVector astroids[] and PVector astroDirect[]
     for(int a =0; a < astroNums; a++){ 
       astroids[a] = new PVector(0, 0, 0); // places random generated numbers into PVector
       astroids[a].x = random(width); //generates random x value for astroid starting point
       astroids[a].y = random(height); //generates random y value for astroid starting point
       
       fill(209); // colour of astroid 
       ellipse(astroids[a].x, astroids[a].y, astroidSize, astroidSize); //prints the astroid on the screen
       
       astroDirect[a] = new PVector(0, 0); // places random generated numbers into PVector
       astroDirect[a].x = random(-2,2); //generates random x value for astroid direction
       astroDirect[a].y = random(-2,2); //generates random y value for astroid direction
       
       astroids[a].z = 0; // Boolean value to indicate that the astroid has not been exploded.       
     }
  } 
   else{
     // Adds the Pvectors astroids[] and astroDirect[]
     for(int d = 0; d< astroNums; d++) {  
       
       if(astroids[d].z == 0){     // checks to see if astroid has exploded or not. 0 = Alive, 1 = Exploded
       
          astroids[d].add(astroDirect[d]);//Draws the astroid on the screen
         
          if(astroids[d].x >=width) { //brings the astroid back if it goes off screen. 
           astroids[d].x -= width; }
          if(astroids[d].x <= 0){//brings the astroid back if it goes off screen. 
           astroids[d].x += width;}
          if(astroids[d].y >= height){//brings the astroid back if it goes off screen. 
           astroids[d].y -= height;}
          if(astroids[d].y <= 0){//brings the astroid back if it goes off screen. 
           astroids[d].y += height;}
         
          fill(209);// colour of astroid
          ellipse(astroids[d].x, astroids[d].y , astroidSize , astroidSize); //prints the astroid on the screen
       }  
   
   }
     
   }    
}

void collisionDetection(){
 

}


void draw(){
  background(0);  
  pushMatrix();
  background(0);
  translate(shipCoord.x, shipCoord.y); // Moves origin to the centre of the screen. 
  rotate(rotated);
  shape(ship,-ship.width/2,-ship.height/2); //Makes the ship at the centre of the screen.
  if(rotated >=TWO_PI) rotated = 0;
  if(rotated<0) rotated = TWO_PI;
  popMatrix(); 
 
  
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  drawShots();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
  // draw score //<>//
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