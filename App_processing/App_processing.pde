/*Progetto Casa Domotica
  by Maggio Antonino, Pulizzi Josè e Lombardo Marco
*/
import processing.serial.*;
int larghezza=width, altezza=height;
boolean primavolta=false;
boolean clicked_luce_interno=false;  //luce interno menù principale
boolean clicked_porta_garage=false;  //porta garage menù principale
boolean clicked_luce_esterno=false;  //luce esterno menù principale
boolean clicked_cancello=false;  //tasto cancello menù principale
boolean clicked_luce_cucina=false;  //luce cucina menù luci
boolean clicked_luce_salone=false;  //luce salone menù luci
boolean clicked_luce_garage=false;  //luce garage menù luci
boolean clicked_porta_garage_apertura=false;  //porta garage menù garage
boolean clicked_luci_esterno=false;  //luci esterno menù luci esterno
boolean tastiluci=false;
boolean tastogarage=false;
boolean tastoluciesterne=false;
String binario="000";
int casa_ino=0;
int corridoio_ino=0;
int garage_ino=0;
String a;
Serial port;
void setup(){
  fullScreen();
  port = new Serial(this, Serial.list()[0], 115200); //Variabile luce
  background(0);
}

//Funzione del menù principale
void tasti(){
  larghezza=width;
  altezza=height;
  stroke(0);
  strokeWeight(2);
  fill(255,180,0);  //giallo
  rect(0,0,larghezza/2,altezza/2);
  fill(0,100,255);  //blu
  rect((larghezza/2)+1,0,larghezza/2,altezza/2);
  fill(0,255,50);   //verde
  rect(0,(altezza/2)+1,larghezza/2,altezza/2);
  fill(255,0,255);  //viola
  rect((larghezza/2)+1,(altezza/2)+1,larghezza/2,altezza/2);
  fill(0);
  //Simbolo lampadina
  ellipse(larghezza/4-10,altezza/4-100,100,100);
  rect(larghezza/4-35,altezza/4-70,50,55,10);
  rect(larghezza/4-32,altezza/4-10,44,5,10);
  rect(larghezza/4-32,altezza/4,44,5,10);
  rect(larghezza/4-32,altezza/4+10,44,5,10);
  textSize(40);
  text("     LUCI\n INTERNO",larghezza/4-105,altezza/4+70);
  //Simbolo garage
  rect(larghezza/4*3-70,altezza/4-80,140,70);
  triangle(larghezza/4*3-69,altezza/4-81,larghezza/4*3+69,altezza/4-81,larghezza/4*3,altezza/4-110);
  stroke(255);
  rect(larghezza/4*3-55,altezza/4-70,110,10);
  rect(larghezza/4*3-55,altezza/4-60,110,10);
  rect(larghezza/4*3-55,altezza/4-50,110,10);
  rect(larghezza/4*3-55,altezza/4-40,110,10);
  rect(larghezza/4*3-55,altezza/4-30,110,10);
  rect(larghezza/4*3-55,altezza/4-20,110,10);
  stroke(0);
  fill(255);
  ellipse(larghezza/4*3,altezza/4-90,10,10);
  fill(0);
  text(" PORTA\nGARAGE",larghezza/4*3-77,altezza/4+70);
  //Simbolo lampadina 2
  ellipse(larghezza/4-10,altezza/4*3-100,100,100);
  rect(larghezza/4-35,altezza/4*3-70,50,55,10);
  rect(larghezza/4-32,altezza/4*3-10,44,5,10);
  rect(larghezza/4-32,altezza/4*3,44,5,10);
  rect(larghezza/4-32,altezza/4*3+10,44,5,10);
  textSize(40);
  text("     LUCI\n ESTERNO",larghezza/4-105,altezza/4*3+70);
  //Simbolo cancello
  rect(larghezza/4*3+70,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3+50,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3+30,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3+10,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3-10,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3-30,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3-50,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3-70,altezza/4*3-120,8,110,10);
  rect(larghezza/4*3-80,altezza/4*3-105,170,8,10);
  rect(larghezza/4*3-80,altezza/4*3-30,170,8,10);
  rect(larghezza/4*3-60,altezza/4*3-171,110,4);
  triangle(larghezza/4*3-60,altezza/4*3-177,larghezza/4*3-60,altezza/4*3-160,larghezza/4*3-70,altezza/4*3-169);
  text("CANCELLO",larghezza/4*3-105,altezza/4*3+70);
  strokeWeight(1);
}

//Funzione per il menù luci interne
void luceinterno(){
  int larghezza=width, altezza=height;
  strokeWeight(2);
  if(clicked_luce_cucina==true) fill(255,180,0);
  else fill(155,80,0);
  rect(0,0,larghezza,altezza/3);
  if(clicked_luce_salone==true) fill(255,180,0);
  else fill(155,80,0);
  rect(0,altezza/3,larghezza,altezza/3);
  if(clicked_luce_garage==true) fill(255,180,0);
  else fill(155,80,0);
  rect(0,altezza/3*2,larghezza,altezza/3);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  fill(0);
  textSize(25);
  text(" INDIETRO",larghezza/2-65,altezza-20);
  textSize(40);
  //prima lampadina
  ellipse(larghezza/2-10,altezza/5-150,100,100);
  rect(larghezza/2-35,altezza/5-120,50,55,10);
  rect(larghezza/2-32,altezza/5-60,44,5,10);
  rect(larghezza/2-32,altezza/5-50,44,5,10);
  rect(larghezza/2-32,altezza/5-40,44,5,10);
  text("  LUCE\nCUCINA",larghezza/2-83,altezza/5+10);
  //seconda lampadina
  ellipse(larghezza/2-10,altezza/5*2.7-150,100,100);
  rect(larghezza/2-35,altezza/5*2.7-120,50,55,10);
  rect(larghezza/2-32,altezza/5*2.7-60,44,5,10);
  rect(larghezza/2-32,altezza/5*2.7-50,44,5,10);
  rect(larghezza/2-32,altezza/5*2.7-40,44,5,10);
  text("  LUCE\nSALONE",larghezza/2-83,altezza/5*2.7+10);
  //terza lampadina
  ellipse(larghezza/2-10,altezza/5*4.3-150,100,100);
  rect(larghezza/2-35,altezza/5*4.3-120,50,55,10);
  rect(larghezza/2-32,altezza/5*4.3-60,44,5,10);
  rect(larghezza/2-32,altezza/5*4.3-50,44,5,10);
  rect(larghezza/2-32,altezza/5*4.3-40,44,5,10);
  text("   LUCE\n GARAGE",larghezza/2-95,altezza/5*4.3+10);
  strokeWeight(1);
}


void portagarage(){
  int larghezza=width, altezza=height;
  fill(0,100,255);  //blu
  rect(0,0,larghezza,altezza);
  fill(0);
  rect(larghezza/2-140,altezza/2-80,140*2,70*2-8);
  triangle(larghezza/2-139,altezza/2-81,larghezza/2+139,altezza/2-81,larghezza/2,altezza/2-165);
  stroke(255);
  strokeWeight(4);
  rect(larghezza/2-110,altezza/2-70,220,20);
  rect(larghezza/2-110,altezza/2-50,220,20);
  if(clicked_porta_garage_apertura==false){
  rect(larghezza/2-110,altezza/2-30,220,20);
  rect(larghezza/2-110,altezza/2-10,220,20);
  rect(larghezza/2-110,altezza/2+10,220,20);
  rect(larghezza/2-110,altezza/2+30,220,20);
  }
  strokeWeight(2);
  stroke(0);
  fill(255);
  ellipse(larghezza/2,altezza/2-110,20,20);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  fill(0);
  textSize(25);
  text(" INDIETRO",larghezza/2-65,altezza-20);
}


void luciesterno(){
  int larghezza=width, altezza=height;
  if(clicked_luci_esterno==true) fill(0,255,50);
  else fill(0,120,10);
  rect(0,0,larghezza,altezza);
  fill(0);
  ellipse(larghezza/2,altezza/2-100,200,200);
  rect(larghezza/2-50,altezza/2-70,100,110,10);
  rect(larghezza/2-44,altezza/2+50,88,10,10);
  rect(larghezza/2-44,altezza/2+70,88,10,10);
  rect(larghezza/2-44,altezza/2+90,88,10,10);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  fill(0);
  textSize(25);
  text(" INDIETRO",larghezza/2-65,altezza-20);
}


void draw(){
  if(a=="ciao") port.write(11);
  else if(a=="ciao8") port.write(0);
  else if(a=="ciao3") port.write(13);
  primavolta=true;
  if(clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) tasti();
  else if(clicked_luce_interno==true){
    tastiluci=true;
    luceinterno();
   }
  else if(clicked_porta_garage==true){
    tastogarage=true;
    portagarage();
  }
  else if(clicked_luce_esterno==true){
    tastoluciesterne=true;
    luciesterno();
  }
}


void mousePressed(){
  Button luceinterno = new Button(0,0);
  Button portagarage = new Button(width/2+1,0);
  Button luceesterno = new Button(0,height/2+1);
  Button cancello = new Button(width/2+1,height/2+1);
  Button lucecucina = new Button(0,0);
  Button lucesalone = new Button(0,height/3);
  Button lucegarage = new Button(0,height/3*2);
  Button portagarageapertura = new Button(0,0);
  Button indietro = new Button(0,height-(height/25));
  Button luciesterno = new Button(0,0);
  luceinterno.clicked_luce_interno(mouseX,mouseY);
  portagarage.clicked_porta_garage(mouseX,mouseY);
  luceesterno.clicked_luce_esterno(mouseX,mouseY);
  cancello.clicked_cancello(mouseX,mouseY);
  lucecucina.clicked_luce_cucina(mouseX,mouseY);
  lucesalone.clicked_luce_salone(mouseX,mouseY);
  lucegarage.clicked_luce_garage(mouseX,mouseY);
  indietro.clicked_indietro(mouseX,mouseY);
  portagarageapertura.clicked_porta_garage_apertura(mouseX,mouseY);
  luciesterno.clicked_luci_esterno(mouseX,mouseY);
}

//classe pulsanti menu principale
public class Button {
  int larghezza=width, altezza=height;
  int x,y,w,h,w1,h1,h2,h3;
  public Button(int xb, int yb){
    int larghezza=width, altezza=height;
    x=xb;
    y=yb;
    w=larghezza/2;
    h=altezza/2;
    w1=larghezza;
    h1=altezza/3;
    h2=altezza/25;
    h3=altezza-(altezza/25);
  }
  public void draw(){
    stroke(0);
    rect(x,y,w,h);
  }
  public void clicked_luce_interno(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) {
      clicked_luce_interno=!clicked_luce_interno;
      a="ciao";
      println(a);
    }
  }
  public void clicked_porta_garage(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) {
      clicked_porta_garage=!clicked_porta_garage;
      a="ciao2";
      println(a);
    }
  }
  public void clicked_luce_esterno(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) {
      clicked_luce_esterno=!clicked_luce_esterno;
      a="ciao3";
      println(a);
      port.write(13);
    }
  }
  public void clicked_cancello(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) {
      clicked_cancello=!clicked_cancello;
      a="ciao4";
      println(a);
    }
  }
  public void clicked_luce_cucina(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h1+y && clicked_luce_interno==true && tastiluci==true) {
      clicked_luce_cucina=!clicked_luce_cucina;
      a="ciao5";
      println(a);
      if(casa_ino==0){
        casa_ino=1;
      }
      else if(casa_ino==1){
        casa_ino=0;
      }
      binario=casa_ino+""+corridoio_ino+""+garage_ino;
      println(casa_ino+""+corridoio_ino+""+garage_ino);
      if(binario.equals("000")){
        port.write(1);
        }
      if(binario.equals("001")){
        port.write(2);
      }
      if(binario.equals("010")){
        port.write(3);
      } 
      if(binario.equals("011")){
        port.write(4);
      }
      if(binario.equals("100")){
        port.write(5);
      }
      if(binario.equals("101")){
        port.write(6);
      }
      if(binario.equals("110")){
        port.write(7);
      } 
      if(binario.equals("111")){
        port.write(8);
      }
    }
  }
    public void clicked_luce_salone(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h1+y && clicked_luce_interno==true && tastiluci==true) {
      clicked_luce_salone=!clicked_luce_salone;
      a="ciao6";
      println(a);
      if(corridoio_ino==0){
        corridoio_ino=1;
      }
      else if(corridoio_ino==1){
        corridoio_ino=0;
      }
      binario=casa_ino+""+corridoio_ino+""+garage_ino;
      println(casa_ino+""+corridoio_ino+""+garage_ino);
      if(binario.equals("000")){
        port.write(1);
        }
      if(binario.equals("001")){
        port.write(2);
      }
      if(binario.equals("010")){
        port.write(3);
      } 
      if(binario.equals("011")){
        port.write(4);
      }
      if(binario.equals("100")){
        port.write(5);
      }
      if(binario.equals("101")){
        port.write(6);
      }
      if(binario.equals("110")){
        port.write(7);
      } 
      if(binario.equals("111")){
        port.write(8);
      }
    }
  }
    public void clicked_luce_garage(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h1-(altezza/25)+y && clicked_luce_interno==true) {
      clicked_luce_garage=!clicked_luce_garage;
      a="ciao7";
      println(a);
      if(garage_ino==0){
        garage_ino=1;
      }
      else if(garage_ino==1){
        garage_ino=0;
      }
      binario=casa_ino+""+corridoio_ino+""+garage_ino;
      println(casa_ino+""+corridoio_ino+""+garage_ino);
      if(binario.equals("000")){
        port.write(1);
        }
      if(binario.equals("001")){
        port.write(2);
      }
      if(binario.equals("010")){
        port.write(3);
      } 
      if(binario.equals("011")){
        port.write(4);
      }
      if(binario.equals("100")){
        port.write(5);
      }
      if(binario.equals("101")){
        port.write(6);
      }
      if(binario.equals("110")){
        port.write(7);
      } 
      if(binario.equals("111")){
        port.write(8);
      }
    }
  }
    public void clicked_porta_garage_apertura(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h3+y && clicked_porta_garage==true && tastogarage==true) {
      clicked_porta_garage_apertura=!clicked_porta_garage_apertura;
      a="ciao9";
      println(a);
    }
  }
    public void clicked_luci_esterno(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h3+y && clicked_luce_esterno==true && tastoluciesterne==true) {
      clicked_luci_esterno=!clicked_luci_esterno;
      a="ciao10";
      println(a);
      if(clicked_luci_esterno==true) port.write(9);
      else port.write(10);
    }
  }
    public void clicked_indietro(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h2+y && (clicked_luce_interno==true || clicked_porta_garage==true || clicked_luce_esterno==true)) {
      if(clicked_luce_interno==true) clicked_luce_interno=false;
      if(clicked_porta_garage==true) clicked_porta_garage=false;
      if(clicked_luce_esterno==true) clicked_luce_esterno=false;
      tastoluciesterne=false;
      tastiluci=false;
      tastogarage=false;
      a="ciao8";
      println(a);
      port.write(100);
    }
  }
}
