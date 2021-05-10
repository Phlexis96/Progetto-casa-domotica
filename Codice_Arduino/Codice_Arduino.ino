/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 *  DomoHouse 0.80.2b 12V 
 *  GiHub Edition
 */
int luci_interni=0; // 8casi.

int menu=0;
void setup() {
 Serial.begin(9600);
 pinMode(2, OUTPUT); //casa primo bit 001.
 pinMode(3,OUTPUT); //corridoio secondo bit 010.
 pinMode(4,OUTPUT); //garage terzo bit 100.
}

void Fluci_interni(){
  
}
void loop() {
  /*switch(menu){
     case 1:{ //menu luci interne
        Fluci_interni(); //controllo delle luci interne.
     }
     case 2:{ //menu garage
        
     }
     case 3:{ //
        
     }
     case 4:{ //
        
     }
   }*/
  if (Serial.available()){
    luci_interni=0+Serial.read();
  }
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
