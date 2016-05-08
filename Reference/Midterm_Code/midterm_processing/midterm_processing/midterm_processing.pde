import processing.serial.*;
Serial myPort;

int driveMode = 0;
int lSlide = 200;//y-coordinates of the sliders
int mSlide = 200;
int rSlide = 200; 

int lSpeed = 0;
int rSpeed = 0;
boolean rF = true; //is right going forward
boolean lF = true; //is left going forward

boolean clicked = false;

void setup(){
  printArray(Serial.list());
  myPort = new Serial(this, "COM15", 9600);
  
  size(600, 400);
  frameRate(60);
  //colorMode(HSB, height);
  rectMode(RADIUS);
  drawBackground();
}

void draw(){
  drawBackground();
  drawSliders();
  setValues();
  sendValues();
    
}

void stop(){
  rSpeed = 0;
  lSpeed = 0;
  driveMode = 0;
  sendValues();
}

void setValues(){
  if(lSlide <= 200){ //if you want left forward
   lF = true;
   lSpeed = 200 - lSlide;
  }else{  //left is backwards
   lF = false;
   lSpeed = lSlide - 200;
  }
  
  if(rSlide < 200){ //right is going forwards
    rF = true;
    rSpeed = 200 - rSlide;
  }else{   //right is backwards
    rF = false;
    rSpeed = rSlide - 200;
  }
  
  if(rF && lF){ //both forward
   driveMode = 1; 
  } 
  else if(rF && !lF){ //right forward left back
   driveMode = 2; 
  }
  else if(lF && !rF){ //left forward right back
   driveMode = 3;
  }else{ //both back
    driveMode = 4;
  }
}

void drawBackground(){
  background(0,0,255); //make background solid blue
  stroke(0,255,200); //left and right boundary rect color
  strokeWeight(8); //rect line thickness
  fill(0,0);    //make rectangles opaque
  rect(100,200,96,196);
  rect(500,200,96,196); //right boundary rectangle
  stroke(0,255,120); //middle rectangle color
  rect(300,200,96,196);//middle boundary rectangle
  stroke(255,0,0); //middle line color
  line(0,200,600,200);//middle line
}

void drawSliders(){
  fill(255,255);
  strokeWeight(1);
  stroke(0,0,0);
  rect(100,lSlide,92,30);
  rect(300,mSlide,92,30);
  rect(500,rSlide,92,30);
}

void sendValues(){
  if(myPort.available()>0){
    if(myPort.read() == 7){
      myPort.write(driveMode);
      myPort.write(rSpeed);
      myPort.write(lSpeed);
      delay(10);
    }
  }
  println("m:"+driveMode+" l:"+lSpeed+" r:"+rSpeed);
}

void mousePressed(){
   if(mouseX < 200){
       lSlide = mouseY; 
    }
    else if(mouseX < 400){
      lSlide = mouseY; 
      mSlide = mouseY;
      rSlide = mouseY;
    }
    else{
       rSlide = mouseY;
    }
}