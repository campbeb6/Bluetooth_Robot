int encoder_pin = 20;  // The pin the encoder is connected 
int encoder_pin2 = 21;

int lSpeed = 200;
int rSpeed = 200;

int operation = 1;
boolean canMove = false;

volatile int pulses;  // number of pulses
volatile int pulses2;

// The number of pulses per revolution
// depends on your index disc!!
unsigned int pulsesperturn = 20;

 void counter()
 {
      pulses++;    
 }
 void counter2(){
      pulses2++; 
 }

void setup()
{
   Serial.begin(9600);
 
   Serial.write(7);
   //delay(5000);
     //Use statusPin to flash along with interrupts
   pinMode(encoder_pin, INPUT);
   pinMode(encoder_pin2, INPUT);
   
   //Interrupt 0 is digital pin 2, so that is where the IR detector is connected
   //Triggers on RISING (change from LOW to HIGH)
   attachInterrupt(3, counter, RISING);
   attachInterrupt(2, counter2, RISING);
   // Initialize
   pulses = 0;
   pulses2 = 0;
}

void loop()
{
  if(Serial.available()){
   operation = Serial.read();
   canMove = true; 
  } 
  if(canMove){
     pulses = 0;
     pulses2 = 0;
     if(operation == 1){
       goForward();
     } else if(operation == 2){
        goBackward();
     }
       else if(operation == 3){
       turnLeft();
     } else if(operation == 4){
        turnRight(); 
     }
     Serial.write(7);
     canMove = false;
  }
}
void goBackward(){
   stopA();
   while(pulses < 100){
       if(pulses > pulses2){
          stopA();
          reverseL(lSpeed);
          delay(10);
       } else if (pulses2 > pulses) {
          stopA();
          reverseR(rSpeed);
          delay(10);
       }  else {
         reverseR(rSpeed);
         reverseL(lSpeed);
       }
   }
   stopR();
   stopL(); 
   //Serial.println(pulses);  
   pulses = 0;
   pulses2 = 0;
}

void goForward(){
   stopA();
   while(pulses < 100){
       if(pulses > pulses2){
          stopA();
          forwardL(lSpeed);
          delay(10);
       } else if (pulses2 > pulses) {
          stopA();
          forwardR(rSpeed);
          delay(10);
       }  else {
         forwardR(rSpeed);
         forwardL(lSpeed);
       }
   }
   stopR();
   stopL(); 
   //Serial.println(pulses);  
   pulses = 0;
   pulses2 = 0;
}

void turnRight(){
  forwardL(lSpeed);
  while(pulses2 < 55){};
  stopA();
  pulses2 = 0;
}

void turnLeft(){
  forwardR(rSpeed); 
  while(pulses < 55){};
  stopA();
  pulses = 0;
}

