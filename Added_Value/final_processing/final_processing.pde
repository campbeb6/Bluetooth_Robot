import processing.serial.*;
Serial myPort;

ArrayList<Integer> operations = new ArrayList<Integer>();
ArrayList<Integer> program    = new ArrayList<Integer>();

PShape play;
PShape stop;
PShape pause;
PShape up;
PShape dn;
PShape lt;
PShape rt;

color blu = color(0,0,255);
color wit = color(255,255,255);

final int STOPPED = 1;
final int RUNNING = 2;
final int PAUSED = 3;

int[] buttonX = { 250, 250, 150, 350,  1,  1,   1};
int[] buttonY = {  75, 275, 175, 175,  0, 51, 102};
int buttonSize = 50;

int xPos = 0;
int yPos = 0; 
boolean clicked = false; //tells if the user has clicked the mouse;

int state = STOPPED;

void setup(){
  printArray(Serial.list());
  myPort = new Serial(this, "COM15", 9600);
  //myPort.write(7);
  textSize(20);
  size(600, 475);
  frameRate(60);
  
  up = loadShape("up-arrow.svg");
  dn = loadShape("dn-arrow.svg");
  rt = loadShape("rt-arrow.svg");
  lt = loadShape("lt-arrow.svg");
  play = loadShape("play.svg");
  stop = loadShape("stop.svg");
  pause = loadShape("pause.svg");
  
  noStroke();
  drawBackground();
  drawButtons();
  drawState();
  myPort.write('f');
}

void draw(){  
  drawState();
  if(clicked){
     getOperation(); 
}
  
  if(state == RUNNING){
      if(operations.size() == 0){
         state = STOPPED; 
         operations.clear();
         copyOp();
         drawOpList();
      } 
      else {
        sendValue();
      }  
  }   
}

void getOperation(){
  int op = 0;  
    for(int i = 0; i < buttonX.length; i++){
        if(mouseX >= buttonX[i] && mouseX < (buttonX[i] + buttonSize)){
          if(mouseY > buttonY[i] && mouseY < (buttonY[i] + buttonSize)){
              op = i + 1;
              if(op < 5 && state == STOPPED){
                program.add(op);
                operations.add(op);
                drawOpList();
                drawProgram();
              }
          } 
        }  
     }
     handleOp(op);
     clicked = false;
}

void stop(){
  
}

void sendValue(){
  if(myPort.available() > 0 && operations.size() > 0){ //if there is serial data available and there is data to send
    if(myPort.read() == 7){
      delay(1000);
      myPort.write(operations.get(0)); //send value
      operations.remove(0);
      delay(20);
      drawOpList();
    }
  }
}

void handleOp(int op){
   if(op == 5 && state == STOPPED){
     state = RUNNING;
     drawOpList();
   } 
   else if(op == 5){
     state = RUNNING;
   } 
   else if(op == 6 && state == RUNNING){
     state = PAUSED;
   } 
   else if(op == 7 && state == STOPPED){
       operations.clear();
       program.clear();
       drawOpList();
       drawProgram();
   } 
   else if(op == 7){
     state = STOPPED; 
     operations.clear();
     copyOp();
     drawOpList();
   } 
}

void copyOp(){
   for(int op : program){
     operations.add(op);
   }
}

void mousePressed(){
   xPos = mouseX;
   yPos = mouseY;
   clicked = true;
}