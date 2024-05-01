
const int pinA = 2;
const int pinB = 3;
const int pinC = 4;

void setup() {
  // put your setup code here, to run once:
  pinMode(pinA, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(pinC, OUTPUT);  
  delay(50);  
}
void blink(int pin,int sec){
  digitalWrite(pin, HIGH);   
  delayMicroseconds(sec/2);            
  digitalWrite(pin, LOW); 
  delayMicroseconds(sec);
}
void iblink(int pin,int sec){
  digitalWrite(pin, HIGH);   
  delayMicroseconds(sec/2);            
  digitalWrite(pin, LOW); 
  //delayMicroseconds(sec);
}
void pix(int pin,int sec){
  //sec = 300;//random(200, 800);
  digitalWrite(pin, LOW); 
  delayMicroseconds(sec);            
  digitalWrite(pin, HIGH);   
  delayMicroseconds(sec);

}

void ipix(int pin,int sec){
  //sec = 300;//random(0, 600);           
  digitalWrite(pin, HIGH);
  delayMicroseconds(sec);
  digitalWrite(pin, LOW);     
  delayMicroseconds(sec);
}



void loop() {
  // some misbehavior
  while( 1){
    iblink(pinA,2000); // frame impuls
    for(int i=0; i<20; i++){
      iblink(pinB,400); // line impuls
      for(int j=0; j<10; j++){
        blink(pinC,22);  // pixel value

      }
    }
  }
}

