/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 */
#include <Stepper.h>
#define VIN 5 // V power voltage
#define R 10000 //ohm resistance value
const int sensorPin = A0; // Pin fotoresistenza
int sensorVal;            // Valore analogico della resistenza
int luci_interni = 0;     // 8casi.
int menu = 0, luci_esterni = 15, scelta_automazione = 0;
bool checkmenu = true, automazione = false, apertura_cancello = false;
int tastoindietro = 1;
int lux;
int cancello = 19;
Stepper myStepper(2048, 11, 9, 10, 8);
float gradi = 0;
const int out=12;
const int in=13;
long dur;
long dis;
long tocm;
int misure[3];
int i;
int passi = 200;

void setup(){
  Serial.begin(9600);
  pinMode(2, OUTPUT); //casa primo bit 001.
  pinMode(3, OUTPUT); //corridoio secondo bit 010.
  pinMode(4, OUTPUT); //garage terzo bit 100.
  pinMode(5, OUTPUT); //luci esterne
  pinMode(in, INPUT);
  pinMode(out, OUTPUT);
  myStepper.setSpeed(10);
}

void Fluci_esterni(){
  luci_esterni = Serial.read();
  if (automazione == false){
    if (luci_esterni == 9)
      digitalWrite(5, HIGH);
    else if (luci_esterni == 10)
      digitalWrite(5, LOW);
  }
  if (luci_esterni == 15){
    automazione = false;
    digitalWrite(5, LOW);
  }
  else if (luci_esterni == 16){
    automazione = true;
    digitalWrite(5, LOW);
  }
  if (luci_esterni == 111){
    checkmenu = true;
    menu = 0;
  }
}

void Fluci_interni(){
  luci_interni = Serial.read();
  if (luci_interni == 1){
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 2){
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 3){
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 4){
    digitalWrite(2, HIGH);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 5)
  {
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, HIGH);
  }
  else if (luci_interni == 6)
  {
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, HIGH);
  }
  else if (luci_interni == 7)
  {
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, HIGH);
  }
  else if (luci_interni == 8)
  {
    digitalWrite(2, HIGH);
    digitalWrite(3, HIGH);
    digitalWrite(4, HIGH);
  }
  if (luci_interni == 111)
  {
    checkmenu = true;
    menu = 0;
  }
}

void Fcancello()
{
  cancello = Serial.read();
  if (cancello == 17){
    gradi = -1;
  }
  if (cancello == 18){
    gradi = 200;
  }
  else if (cancello == 19)
    gradi = 0;
  if (cancello == 111){
    checkmenu = true;
    menu = 0;
  }
}

void loop(){
  if(passi >= 2200){
    cancello = 19;
    gradi = 0;
    delay(2000);
    cancello = 18;
    gradi = 200;
  }
  if(passi <= 0){
    cancello = 19;
    gradi = 0;
  }
  //Sensore cancello
  if(gradi > 0){
    digitalWrite(out,LOW);
    digitalWrite(out,HIGH);
    digitalWrite(out,LOW);
    dur=pulseIn(in,HIGH);
    tocm=microsecondsToCentimeters(dur);
    if(tocm < 21) {
      cancello = 19;
      gradi = 0;
      Serial.println(19);
      delay(2000);
      cancello = 17;
      gradi =- 1;
    }
  }
  //Luci esterne automatiche
  if (automazione == true){
    sensorVal = analogRead(sensorPin);
    lux=sensorRawToPhys(sensorVal);
    if (lux< 60)
      digitalWrite(5, HIGH);
    else
      digitalWrite(5, LOW);
  }
  if (checkmenu == true){
    if (Serial.available())
      menu = Serial.read();
  }
  if (menu == 11){ //Menu delle luci interne
    checkmenu = false;
    Fluci_interni(); //Funzione che controlla le luci interne
  }
  if (menu == 13){ //menu luci esterne
    checkmenu = false;
    Fluci_esterni(); //funzione menu luci esterne
  }
  if (menu == 14){ //menu cancello
    checkmenu = false;
    Fcancello(); //funzione menu cancello
  }
  if (gradi != 0){
    myStepper.step(gradi);
    if(gradi < 0) passi = passi+1;
    if(gradi > 0) passi = passi-200;
  }
}

int sensorRawToPhys(int raw){
  // Conversion rule
  float Vout = float(raw) * (VIN / float(1023));// Conversion analog to voltage
  float RLDR = (R * (VIN - Vout))/Vout; // Conversion voltage to resistance
  int phys=500/(RLDR/1000); // Conversion resitance to lumen
  return phys;
}

long microsecondsToCentimeters(long microseconds)
{
return microseconds / 29 / 2;
}
