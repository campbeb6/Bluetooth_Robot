int mode = 0;
int rSpeed = 0;
int lSpeed = 0;

void setup() {
  Serial.begin(9600);
  motorSetup();
}

void loop() {
  Serial.write(7);
  delay(10);
  if(Serial.available() > 6){
     mode = Serial.read(); 
     rSpeed = Serial.read();
     lSpeed = Serial.read();
  }
  setMotors();
  
}

void setMotors(){
 if(mode == 1){
  forwardR(rSpeed);
  forwardL(lSpeed);
 } 
 else if(mode == 2){
  forwardR(rSpeed);
  reverseL(lSpeed); 
 }
 else if(mode == 3){
  forwardL(lSpeed);
  reverseR(rSpeed); 
 }
 else if(mode == 4){
  reverseR(rSpeed);
  reverseL(lSpeed); 
 } else{
   stopL();
   stopR(); 
 }
  
}
