
/*
 *This method draws the buttons that can be pressed by the user
 * by clicking the mouse within them.
 */
void drawButtons(){
  fill(wit); //make rectangle white
  for(int i = 0; i < buttonX.length; i++){
      rect(buttonX[i], buttonY[i], buttonSize, buttonSize);
  }

 drawArrow(1, 40, buttonX[0], buttonY[0]); //draw the arrows in the rectangles
 drawArrow(2, 40, buttonX[1], buttonY[1]);
 drawArrow(3, 40, buttonX[2], buttonY[2]);
 drawArrow(4, 40, buttonX[3], buttonY[3]);
 
 shape(play,  buttonX[4]+5, buttonY[4]+5, 40, 40); //draw the play, pause, and stop buttons in their rectangles
 shape(pause, buttonX[5]+5, buttonY[5]+5, 40, 40);
 shape(stop,  buttonX[6]+5, buttonY[6]+5, 40, 40); 
}

/*
 *This method redraws the background 
 */
void drawBackground(){
  background(blu); //make background solid blue
}

/*
 *This method draws the operations list using  the 
 * drawArrow() helper method
 */
void drawOpList(){
  int xPos = 30;
  fill(blu);
  rect(0,400,600,40); //paint over the old one
  fill(wit);
  for(int i = 0; i < operations.size() && xPos <= 560; i++){
     rect(xPos, 400, 40, 40);
     drawArrow(operations.get(i), 30, xPos, 400);
     xPos += 45;
  }
}
/**
 *This method draws the program list using 
 *the drawArrow() helper method
 */
void drawProgram(){
  int xPos = 30;
  fill(blu);
  rect(0,350,600,40); //paint over the old one
  fill(wit);
  for(int i = 0; i < program.size() && xPos <= 560; i++){
     rect(xPos, 350, 40, 40);
     drawArrow(program.get(i), 30, xPos, 350);
     xPos += 45;
  }
}

/**
 * This method draws the spedified arrow type at the specified location
 * primarily used for displaying the program and operations lists
 */
void drawArrow(int type, int dim, int xPos, int yPos){
   if(type == 1){ //up arrow
      shape(up, xPos+5, yPos+5, dim, dim);
   } 
   else if(type == 2){ //down arrow
      shape(dn, xPos+5, yPos+5, dim, dim);
   } 
   else if(type == 3){ //left arrow
      shape(lt, xPos+5, yPos+5, dim, dim);
   } 
   else if(type == 4){ //right arrow 
      shape(rt, xPos+5, yPos+5, dim, dim);
   }
}

/**
 *This method draws the symbol for the current state of the program
 *in the center of the gui
 */
void drawState(){
  fill(wit); 
  rect(250,175, 50, 50);
  if(state == PAUSED){
     shape(pause, 255, 180, 40, 40);
   } 
   else if(state == STOPPED){
     shape(stop, 255, 180, 40, 40);
   } 
   else if(state == RUNNING){
     shape(play, 255, 180, 40, 40); 
   }
}