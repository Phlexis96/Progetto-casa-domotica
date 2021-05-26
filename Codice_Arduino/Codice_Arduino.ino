/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 *  DomoHouse 0.80.2b 12V 
 *  GiHub Edition
 */
#define VIN 5
#define R 200
int luci_interni=0 ; // 8casi.
int menu=0,luci_esterni=0,scelta_automazione=0 ;
bool checkmenu=true,automazione=false;
int tastoindietro=1;
const int sensorPin = A0; // Pin connected to sensor
int sensorVal; // Analog value from the sensor
int lux; //Lux value
void setup() {
 Serial.begin(115200);
 pinMode(2,OUTPUT); //casa primo bit 001.
 pinMode(3,OUTPUT); //corridoio secondo bit 010.
 pinMode(4,OUTPUT); //garage terzo bit 100.
 pinMode(5,OUTPUT); //luci esterne
 pinMode(A0,OUTPUT);// Fotoresistenza
}
void Fluci_esterni(){
  if(Serial.available())
    scelta_automazione=Serial.read();
  if(scelta_automazione==16) automazione=true;
  else if(scelta_automazione==15) automazione=false;
  if(automazione==true){
    if(lux<50) digitalWrite(5,HIGH);
    if(Serial.available())
    scelta_automazione=Serial.read();
    else if(lux>=50)digitalWrite(5,LOW);
  }else if(automazione==false){
   if(Serial.available()) luci_esterni=Serial.read(); 
    if(luci_esterni==9){
      digitalWrite(5,HIGH);
     }
    else if(luci_esterni==10){
      digitalWrite(5,LOW);
     }
  } 
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


void loop() {
   //Luci esterne automatiche
  sensorVal = analogRead(sensorPin);
  lux=sensorRawToPhys(sensorVal);
  if(automazione==true){
    if(lux<50) digitalWrite(5,HIGH);
    else if(lux>=50)digitalWrite(5,LOW);
  }
  if (Serial.available() && checkmenu==true){
    menu=Serial.read();
  }
  if(menu==11){        //Menu delle luci interne
    checkmenu=false;
    Fluci_interni(); //Funzione che controlla le luci interne
  }
  if(menu==13){ //menu luci esterne
    checkmenu=false;
    Fluci_esterni();
  }
}


int sensorRawToPhys(int raw){
  // Conversion rule
  float Vout = float(raw) * (VIN / float(1023));// Conversion analog to voltage
  float RLDR = (R * (VIN - Vout))/Vout; // Conversion voltage to resistance
  int phys=500/(RLDR/1000); // Conversion resitance to lumen
  return phys;
}
