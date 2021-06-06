/*  I.T.T Piersanit Mattarella VD
 *  Pulizzi Jose', Maggio Antonino, Lombardo Marco presentano: 
 */
#include <Stepper.h>
#include <Servo.h>

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
Stepper myStepper(2048, 11, 9, 10, 8);  //MOTORE STEPPER
float gradi = 0;
const int out=12;
const int in=13;
long dur;
long dis;
long tocm;
int misure[3];
int i;
int passi = 0;
int servomotore;
Servo myServo;  // SERVOMOTORE
boolean debugcancello = false;
boolean inverter = false;

void setup()
{
  Serial.begin(9600);
  pinMode(2, OUTPUT); //casa primo bit 001.
  pinMode(3, OUTPUT); //corridoio secondo bit 010.
  pinMode(4, OUTPUT); //garage terzo bit 100.
  pinMode(5, OUTPUT); //luci esterne
  pinMode(in, INPUT);
  pinMode(out, OUTPUT);
  myServo.attach(40);
  myStepper.setSpeed(10);
  myServo.write(0);
}

void Fluci_esterni()
{
  luci_esterni = Serial.read();
  if (automazione == false)
  {
    if (luci_esterni == 9)
      digitalWrite(5, HIGH);
    else if (luci_esterni == 10)
      digitalWrite(5, LOW);
  }
  if (luci_esterni == 15)
  {
    automazione = false;
    digitalWrite(5, LOW);
  }
  else if (luci_esterni == 16)
  {
    automazione = true;
    digitalWrite(5, LOW);
  }
  if (luci_esterni == 111)
  {
    checkmenu = true;
    menu = 0;
  }
}

void Fluci_interni()
{
  luci_interni = Serial.read();
  if (luci_interni == 1)
  {
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 2)
  {
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 3)
  {
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);
  }
  else if (luci_interni == 4)
  {
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
<<<<<<< HEAD
  //gradi = map(gradi, 0, 360, 0, 2048);
  cancello = Serial.read();
  if (cancello == 17)
    gradi = 1;
  else if (cancello == 18)
    gradi = -1;
  else if (cancello == 19)
    gradi = 0;
  if (cancello == 111)
  {
=======
    cancello = Serial.read();
   if (cancello == 17 && inverter == false){
   gradi = -1;
   }
   else if (cancello == 17 && inverter == true){
   gradi = 200;
   }
   if (cancello == 18 && inverter == false){
   gradi = 200;
   }
   else if (cancello == 18 && inverter == true){
   gradi = -1;
   } 
   if (cancello == 19) gradi = 0;
   else if (cancello == 111){
     checkmenu = true;
     menu = 0;
   }
}

void Fservomotore(){
  servomotore = Serial.read();
  if(servomotore == 20 && myServo.read() == 0) myServo.write(90);
  else if(servomotore == 20) myServo.write(0);
  if(servomotore == 111){
>>>>>>> 840f59f73c15199b1329973387c077eae79f32f3
    checkmenu = true;
    menu = 0;
  }
}

<<<<<<< HEAD
void loop()
{
=======
void loop(){
  if(gradi > 0) debugcancello = false;
  if(passi >= 2200){
    inverter = !inverter;
    gradi = 0;
    delay(2000);
    gradi = 200;
  }
  else if(passi < 0 && debugcancello == false){
    gradi = 0;
    debugcancello = true;
  }
  //Sensore cancello
  if(gradi > 0){
    digitalWrite(out,LOW);
    digitalWrite(out,HIGH);
    digitalWrite(out,LOW);
    dur=pulseIn(in,HIGH);
    tocm=microsecondsToCentimeters(dur);
    if(tocm < 21) {
      gradi = 0;  
      Serial.println(19);
      delay(2000);
      gradi = -1;
    }
  }
  if (gradi != 0){
    myStepper.step(gradi);
    if(gradi < 0) passi = passi+1;
    if(gradi > 0) passi = passi-200;
  }
>>>>>>> 840f59f73c15199b1329973387c077eae79f32f3
  //Luci esterne automatiche
  if (automazione == true)
  {
    sensorVal = analogRead(sensorPin);
    lux=sensorRawToPhys(sensorVal);
    if (lux< 60)
      digitalWrite(5, HIGH);
    else
      digitalWrite(5, LOW);
  }
  if (checkmenu == true)
  {
    if (Serial.available())
      menu = Serial.read();
  }
  if (menu == 11)
  { //Menu delle luci interne
    checkmenu = false;
    Fluci_interni(); //Funzione che controlla le luci interne
  }
<<<<<<< HEAD
  if (menu == 13)
  { //menu luci esterne
=======
  if(menu == 12){
    checkmenu = false;
    Fservomotore();
  }
  if (menu == 13){ //menu luci esterne
>>>>>>> 840f59f73c15199b1329973387c077eae79f32f3
    checkmenu = false;
    Fluci_esterni(); //funzione menu luci esterne
  }
  if (menu == 14)
  { //menu cancello
    checkmenu = false;
    Fcancello(); //funzione menu cancello
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
