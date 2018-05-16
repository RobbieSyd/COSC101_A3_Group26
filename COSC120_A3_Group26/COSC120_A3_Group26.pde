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

float positionX = 0;
float positionY = 0;
float mouseXX;
float mouseYY;
float rotated = 0.0;

int initalised = 0; 
PShape ship; // don't have to use pshape - can use image
int astroNums=20;
PVector[] astroids = new PVector[astroNums];
PVector[] astroDirect = new PVector[astroNums];
float speed = 0;
float maxSpeed = 4;
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
  
  //initialise pvtecotrs 
  //random astroid initial positions and directions;
  //initialise shapes if needed
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
  
  //this function should update if keys are pressed down 
     // - this creates smooth movement
  //update rotation,speed and update current location
  //you should also check to make sure your ship is not outside of the window
  if(sUP){
  }
  if(sDOWN){
  
  }
  if(sRIGHT){
    rotated+=0.05;
  }
  if(sLEFT){
    rotated-=0.05;
  }
}

void ship() {
  //side engines
  fill(255, 0, 0);
  stroke(255, 0, 0);
  triangle(positionX, positionY-50, positionX+30, positionY, positionX-30, positionY);
  //main body
  fill(150);
  stroke(150);
  triangle(positionX, positionY-80, positionX+20, positionY, positionX-20, positionY);
  //center engine
  fill(255, 0, 0);
  stroke(255, 0, 0);
  triangle(positionX, positionY-25, positionX+10, positionY, positionX-10, positionY);
  //outside of engine
  fill(100);
  stroke(100);
  triangle(positionX, positionY-25, positionX+3, positionY, positionX+-3, positionY);
  //window
  fill(0);
  stroke(0);
  triangle(positionX, positionY-75, positionX+3, positionY-60, positionX-3, positionY-60);
  if (rotated>=TAU) rotated=0;
  if (rotated<0) rotated=TAU;
  
}


void drawShots(){
   //draw points for each shot from spacecraft 
   //at location and updated to new location
}

void drawAstroids(){
  if (initalised == 0){ //initalised variable added to ensure that the PVectors arrays are only populated once.  
     //populates the PVector astroids[] and PVector astroDirect[]
     for(int a =0; a < astroNums; a++){ 
  
       float rx = random(1000); //generates random x value for astroid starting point
       float ry = random(800); //generates random y value for astroid starting point
       astroids[a] = new PVector(rx, ry); // places random generated numbers into PVector
       fill(209); // colour of astroid 
       ellipse(astroids[a].x, astroids[a].y, 50, 50); //prints the astroid on the screen //<>//
       
       float dx = random(-2,2); //generates random x value for astroid direction
       float dy = random(-2,2); //generates random y value for astroid direction
       astroDirect[a] = new PVector(dx, dy); // places random generated numbers into PVector 
     }
  } 
   else{
     // Adds the Pvectors astroids[] and astroDirect[]
     for(int d = 0; d< astroNums; d++) {   
       astroids[d].add(astroDirect[d]);
       if (astroids[d].x >=1000) { //brings the astroid back if it goes off screen. 
         astroids[d].x -= 1000; }
       if (astroids[d].x <= 0){//brings the astroid back if it goes off screen. 
         astroids[d].x += 1000;}
       if (astroids[d].y >= 800){//brings the astroid back if it goes off screen. 
         astroids[d].y -= 800;}
       if (astroids[d].y <= 0){//brings the astroid back if it goes off screen. 
         astroids[d].y += 800;}
         
         
       fill(209);// colour of astroid
       ellipse(astroids[d].x, astroids[d].y , 50 , 50); //prints the astroid on the screen
     
     }
     
   
   }


  //check to see if astroid is not already destroyed
  //otherwise draw at location 
  //initial direction and location should be randomised
  //also make sure the astroid has not moved outside of the window
    
}

void collisionDetection(){
  mouseXX = mouseX - (width/2);
  mouseYY = mouseY - (height/2)-40;
  //Ellipse for collision detection testing
  fill(255,0,0);
  ellipse(100,100,100,100);  
  //ship collision areas
  //calculating ship collision areas
  //side engines triangle
  float areaOrigin1 = abs( ((positionX+30)-positionX)*((positionY)-positionY-50) - ((positionX-30)-positionX)*((positionY)-positionY-50) );
  float area1 =    abs( ((positionX)-mouseXX)*((positionY)-mouseYY) - ((positionX+30)-mouseXX)*((positionY-50)-mouseYY) );
  float area2 =    abs( ((positionX+30)-mouseXX)*((positionY)-mouseYY) - ((positionX-30)-mouseXX)*((positionY)-mouseYY) );
  float area3 =    abs( ((positionX-30)-mouseXX)*((positionY-50)-mouseYY) - ((positionX)-mouseXX)*((positionY)-mouseYY) );
  //main body triangle
  float areaOrigin2 = abs( ((positionX+20)-positionX)*((positionY)-positionY-80) - ((positionX-20)-positionX)*((positionY)-positionY-80) );
  float area4 =    abs( ((positionX)-mouseXX)*((positionY)-mouseYY) - ((positionX+20)-mouseXX)*((positionY-80)-mouseYY) );
  float area5 =    abs( ((positionX+20)-mouseXX)*((positionY)-mouseYY) - ((positionX-20)-mouseXX)*((positionY)-mouseYY) );
  float area6 =    abs( ((positionX-20)-mouseXX)*((positionY-80)-mouseYY) - ((positionX)-mouseXX)*((positionY)-mouseYY) );
  if (area1 + area2 + area3 == areaOrigin1 || area4 + area5 + area6 == areaOrigin2){
    fill(0,255,0);
    ellipse(100,100,100,100);
  }
}


void draw(){
  background(0);
  pushMatrix();
  translate(width/2,height/2);
  rotate(rotated);
  translate(0, 40); // offset by half the ship height to rotate around middle of the ship  
  ship();
  popMatrix();
  //might be worth checking to see if you are still alive first
  moveShip();
  collisionDetection();
  drawShots();
  // draw ship - call shap(..) if Pshape
  // report if game over or won
  drawAstroids();
  // draw score
  initalised = 1; 
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