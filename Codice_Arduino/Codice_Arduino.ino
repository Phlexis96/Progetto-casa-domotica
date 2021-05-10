/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 *  DomoHouse 0.80.2b 12V 
 *  GiHub Edition
 */
int luci_interni=0 ; // 8casi.
int menu=0,luci_esterni=0 ;
bool checkmenu=true;
int tastoindietro=1;
void setup() {
 Serial.begin(115200);
 pinMode(2,OUTPUT); //casa primo bit 001.
 pinMode(3,OUTPUT); //corridoio secondo bit 010.
 pinMode(4,OUTPUT); //garage terzo bit 100.
 pinMode(5,OUTPUT); //luci esterne
 //pinMode(A0,OUTPUT);// Fotoresistenza
}
void Fluci_esterni(){
  if(Serial.available())luci_esterni=Serial.read();
    if(luci_esterni==9){
      digitalWrite(5,HIGH);
    }
    if(luci_esterni==10){
      digitalWrite(5,LOW);
    }
}
void Fluci_interni(){
  if(Serial.available())luci_interni=Serial.read();
  if(luci_interni==0) checkmenu=true;
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
}
void loop() {
  if (Serial.available() && checkmenu==true){
    menu=Serial.read();
  }
  if(menu==11){        //Menu delle luci interne
    Fluci_interni(); //Funzione che controlla le luci interne
    checkmenu=false;
  }
  if(menu==13){ //menu luci esterne
    Fluci_esterni();
    checkmenu=false;
  }
}
