int pin1 = 10;
int pin2 = 11;
int pin3 = 6;
int pin4 = 7;
int pwmL = 12;
int pwmR = 5;

void mSetup() {
  pinMode(pin1, OUTPUT);
  pinMode(pin2, OUTPUT);
  pinMode(pin3, OUTPUT);
  pinMode(pin4, OUTPUT);
  pinMode(pwmR, OUTPUT);
  pinMode(pwmL, OUTPUT);
}

void stopL(){
 digitalWrite(pin3, LOW);
 digitalWrite(pin4, LOW); 
}

void stopR(){
 digitalWrite(pin1, LOW);
 digitalWrite(pin2, LOW); 
}

void stopA(){
 stopL();
 stopR(); 
}

void forwardR(int spd){
  digitalWrite(pin1, LOW);
  digitalWrite(pin2, HIGH);
  analogWrite(pwmR, spd); 
}

void forwardL(int spd){
 digitalWrite(pin3, LOW);
 digitalWrite(pin4, HIGH);
 analogWrite(pwmL, spd); 
}

void forward(int spd){
 forwardR(spd);
 forwardL(spd); 
}

void reverseR(int spd){
  digitalWrite(pin1, HIGH);
  digitalWrite(pin2, LOW);
  analogWrite(pwmR, spd);
}

void reverseL(int spd){
  digitalWrite(pin3, HIGH);
  digitalWrite(pin4, LOW);
  analogWrite(pwmL, spd); 
}

void reverse(int spd){
  reverseR(spd);
  reverseL(spd); 
}
