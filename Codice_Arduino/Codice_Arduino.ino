/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 *  DomoHouse 0.80.2b 12V 
 *  GiHub Edition
 */
#include <Stepper.h>
#define VIN 5
#define R 200
int luci_interni=0 ; // 8casi.
int menu=0,luci_esterni=0,scelta_automazione=0 ;
bool checkmenu=true,automazione=false,apertura_cancello=false;
int tastoindietro=1;
const int sensorPin = A0; // Pin connected to sensor
int sensorVal; // Analog value from the sensor
int lux; //Lux value
int cancello=19, excancello=0;
Stepper myStepper(2048, 11, 9, 10, 8);
float gradi = 0;
void setup() {
 Serial.begin(115200);
 pinMode(2,OUTPUT); //casa primo bit 001.
 pinMode(3,OUTPUT); //corridoio secondo bit 010.
 pinMode(4,OUTPUT); //garage terzo bit 100.
 pinMode(5,OUTPUT); //luci esterne
 pinMode(A0,OUTPUT);// Fotoresistenza
 myStepper.setSpeed(10);
}
void Fluci_esterni(){
  if(scelta_automazione==15){
    automazione=false;
    digitalWrite(5,LOW);
  }
  if(automazione==false){
    if(Serial.available()) luci_esterni=Serial.read();
    if(luci_esterni==9){
      digitalWrite(5,HIGH);
    }
    else if(luci_esterni==10){
      digitalWrite(5,LOW);
    }
    if(luci_esterni==16) automazione=true;
    if(luci_esterni==111) checkmenu=true;
  }
  if(Serial.available()) scelta_automazione=Serial.read();
  if(scelta_automazione==16) automazione=true;
  
  if(scelta_automazione==111) checkmenu=true;
}
void Fluci_interni(){
  if(Serial.available())luci_interni=Serial.read();
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
  else if(luci_interni==111) checkmenu=true;
}

void Fcancello(){
  //gradi = map(gradi, 0, 360, 0, 2048);
  cancello=Serial.read();
  if(cancello==17) gradi=1;
  else if(cancello==18) gradi=-1;
  else if(cancello==19){
  gradi=0;
  //movimento=false;
  }
  myStepper.step(gradi);
  if(cancello==111) checkmenu=true;
}

void loop() {
  //Luci esterne automatiche
  if(automazione==true){
    if(lux<1) digitalWrite(5,HIGH);
    else if(lux>=1)digitalWrite(5,LOW);
  }
  sensorVal = analogRead(sensorPin);
  lux=sensorRawToPhys(sensorVal);
  if (checkmenu==true){
    menu=Serial.read();
  } 
  if(menu==11){        //Menu delle luci interne
    checkmenu=false;
    Fluci_interni(); //Funzione che controlla le luci interne
  }
  if(menu==13){ //menu luci esterne
    checkmenu=false;
    Fluci_esterni(); //funzione menu luci esterne
  }
  if(menu==14){ //menu cancello
    checkmenu=false;
    Fcancello(); //funzione menu cancello
  }
  myStepper.step(gradi);
}


int sensorRawToPhys(int raw){
  // Conversion rule
  float Vout = float(raw) * (VIN / float(1023));// Conversion analog to voltage
  float RLDR = (R * (VIN - Vout))/Vout; // Conversion voltage to resistance
  int phys=500/(RLDR/1000); // Conversion resitance to lumen
  return phys;
}
