/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 *  DomoHouse 0.80.2b 12V 
 *  GitHub Edition
 */
#include <Stepper.h>
const int sensorPin = A0; // Pin fotoresistenza
int sensorVal; // Valore analogico della resistenza
int luci_interni=0 ; // 8casi.
int menu=0,luci_esterni=15,scelta_automazione=0 ;
bool checkmenu=true,automazione=false,apertura_cancello=false;
int tastoindietro=1;

int cancello=19;
Stepper myStepper(2048, 11, 9, 10, 8);
float gradi = 0;


void setup() {
  Serial.begin(9600);
  pinMode(2,OUTPUT); //casa primo bit 001.
  pinMode(3,OUTPUT); //corridoio secondo bit 010.
  pinMode(4,OUTPUT); //garage terzo bit 100.
  pinMode(5,OUTPUT); //luci esterne
  myStepper.setSpeed(10);
}


void Fluci_esterni(){
  if(Serial.available()) luci_esterni=Serial.read();
  if(luci_esterni==15) {
    automazione=false;
    digitalWrite(5,LOW);
  }
  else if(luci_esterni==16) {
    automazione=true;
    digitalWrite(5,LOW);
  }
  if(automazione==false){
    if(luci_esterni==9) digitalWrite(5,HIGH);
    else if(luci_esterni==10) digitalWrite(5,LOW);
  }
  if(luci_esterni==111){
    checkmenu=true;
    menu=0;
  }
}


void Fluci_interni(){
  luci_interni=Serial.read();
  if(luci_interni==1){
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if(luci_interni==2){
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if(luci_interni==3){
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);  
  } 
  else if(luci_interni==4){
    digitalWrite(2, HIGH);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);    
  }
  else if(luci_interni==5){
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, HIGH);    
  }
  else if(luci_interni==6){
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, HIGH);    
  }
  else if(luci_interni==7){
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, HIGH);  
  } 
  else if(luci_interni==8){
    digitalWrite(2, HIGH);
    digitalWrite(3, HIGH);
    digitalWrite(4, HIGH);
  }
  if(luci_interni==111){
    checkmenu=true;
    menu=0;
  }
}


void Fcancello(){
  //gradi = map(gradi, 0, 360, 0, 2048);
  cancello=Serial.read();
  if(cancello==17) gradi=1;
  else if(cancello==18) gradi=-1;
  else if(cancello==19) gradi=0;
  if(cancello==111){
    checkmenu=true;
    menu=0;
  }
}

void loop() {
  //Luci esterne automatiche
  if(automazione==true){
    sensorVal = analogRead(sensorPin);
    if(sensorVal/5<60) digitalWrite(5,HIGH);
    else digitalWrite(5,LOW);
  }
  if (checkmenu==true){
    if(Serial.available()) menu=Serial.read();
  }
  if(menu==11){        //Menu delle luci interne
    checkmenu=false;
    Fluci_interni();  //Funzione che controlla le luci interne
  }
  if(menu==13){ //menu luci esterne
    checkmenu=false;
    Fluci_esterni();  //funzione menu luci esterne
  }
  if(menu==14){ //menu cancello
    checkmenu=false;
    Fcancello();  //funzione menu cancello
  }
  if(gradi!=0) myStepper.step(gradi);
}
