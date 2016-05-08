int encoder_pin1 = 21;  // The pin the encoder is connected
int encoder_pin2 = 20;

int rpm1;     // rpm reading
int rpm2;
int rSpeed = 165;
int lSpeed = 200;
int totalPulses;
int dist;
int operation;
boolean canMove = false;
volatile byte pulses1;  // number of pulses
volatile byte pulses2; 
unsigned long timeold; 
// The number of pulses per revolution
// depends on your index disc!!
unsigned int pulsesperturn = 20;

void setup()
 {
   mSetup();
   Serial.begin(9600);
   delay(1000);
   Serial.write(7);//tell the PC you are ready for a value
     //Use statusPin to flash along with interrupts
   pinMode(encoder_pin1, INPUT);
   pinMode(encoder_pin2, INPUT);
   
   //Interrupt 0 is digital pin 2, so that is where the IR detector is connected
   //Triggers on FALLING (change from HIGH to LOW)
   attachInterrupt(3, counter1, FALLING);
   attachInterrupt(2, counter2, FALLING);
   // Initialize
   totalPulses = 0;
   pulses1 = 0;
   pulses2 = 0;
   rpm1 = 0;
   rpm2 = 0;
   timeold = 0;

 }

 void loop()
 {
      if(Serial.available()){
        operation = Serial.read();
        canMove = true;
      }
     if(canMove){
        if(operation < 3){ //if moving forward or backwards
            if(totalPulses > 100){
              stopA();
              canMove = false;
              totalPulses = 0;
              Serial.write(7);
            }
            
            else if (millis() - timeold >= 100){  /*Uptade every one second, this will be equal to reading frecuency (Hz).*/
               getSpeed();
               setMotors();
            }
         }
         else{
            if(operation == 4){
               pulses1 = 0;
               while(pulses1 < 100){
                  forwardR(rSpeed);
               } 
            } else {
              pulses2 = 0;
              while(pulses2 < 100){
                  forwardL(lSpeed);  
              }
            }
            stopA();
            canMove = false;
            //delay(100);
            pulses1 = 0;
            pulses2 = 0;
            Serial.write(7);
         }   
     }
}

void counter1()
{
    //Update count
      pulses1++;    
}
 
void counter2()
{   
      pulses2++; 
}

void getSpeed(){
 //Don't process interrupts during calculations
   detachInterrupt(2);
   detachInterrupt(3);
   //Note that this would be 60*1000/(millis() - timeold)*pulses if the interrupt
   //happened once per revolution
   rpm1 = (pulses1 * 60000) / (20 * (millis() - timeold));
   rpm2 = (pulses2 * 60000) / (20 * (millis() - timeold));
   totalPulses = totalPulses + pulses1;
   timeold = millis();
   pulses1 = 0;
   pulses2 = 0;
   
   //Write it out to serial por
   //Serial.println(totalPulses);
   //Serial.print("RPM1 = ");
   //Serial.print(rpm1,DEC);
   //Serial.print("  RPM2 = ");
   //Serial.println(rpm2,DEC); 
   //Restart the interrupt processing
   attachInterrupt(2, counter1, FALLING);
   attachInterrupt(3, counter2, FALLING);
  
   if(rpm1 < rpm2){ //if the right wheel is turning slower
      rSpeed = rSpeed - 5; //supply more power to the right wheel
   }
   else if(rpm2 > rpm1 && (rSpeed < 250)){ //if the right wheel is turning faster
     rSpeed = rSpeed + 5;       //supply less power to the right wheel
   }
   //Serial.println(rSpeed);
}

void setMotors(){
   if(operation == 1){
       forwardR(rSpeed);
       forwardL(lSpeed); 
   } else {
       reverseR(rSpeed);
       reverseL(lSpeed);
   }
}

