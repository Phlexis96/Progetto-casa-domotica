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
boolean clicked_automazione=false;  //automazione luci esterno
boolean clicked_apertura_cancello=false; //tasto per aprire il cancello
boolean clicked_switch=false; //tasto per cambiare menu
boolean tastiluci=false;
boolean tastogarage=false;
boolean tastoluciesterne=false;
boolean tastocancello=false;
int pausacancello=0;
String binario="000";
int casa_ino=0;
int corridoio_ino=0;
int garage_ino=0;
String a;
PImage scena;
PImage termometro;
PImage luce;
PImage cancello;
PImage garage;
Serial port;
void setup(){
  fullScreen();
  //size(1280,720);
  port = new Serial(this, Serial.list()[0], 115200); //Variabile luce
  scena = loadImage("pngegg.png");
  termometro = loadImage("termometro.png");
  luce = loadImage("luce.png");
  cancello = loadImage("cancello.png");
  garage = loadImage("garage.png");
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
  fill(50);  //Switch
  rect(0,0,larghezza,altezza/25);
  fill(0);
  //Simbolo lampadina
  image(luce,larghezza/5.5,altezza/12,altezza/4.11,altezza/4.11);
  textSize(height/36);
  text("     LUCI\n INTERNO",larghezza/4-altezza/13.7,altezza/4+altezza/10);
  //Simbolo garage
  image(garage,larghezza/10*6.95,altezza/9,height/4.8,height/4.8);
  fill(0);
  text(" PORTA\nGARAGE",larghezza/4*3-height/18.7,altezza/4+height/10);
  //Simbolo lampadina 2
  image(luce,larghezza/5.5,altezza/10*5.7,altezza/4.11,altezza/4.11);
  textSize(height/36);
  text("     LUCI\n ESTERNO",larghezza/4-height/13.7,altezza/4*3+height/12);
  //Simbolo cancello
  image(cancello,larghezza/10*6.9,altezza/10*6.2,height/4.5,height/5);
  text("CANCELLO",larghezza/4*3-height/13.71,altezza/4*3+height/9);
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
  textSize(height/57);
  text(" INDIETRO",larghezza/2-height/22.15,altezza-height/72);
  textSize(height/36);
  //prima lampadina
  image(luce,larghezza/2-larghezza/16,altezza/100,height/4.8,height/4.8);
  text("  LUCE\nCUCINA",larghezza/2-width/31,altezza/5+altezza/20);
  //seconda lampadina
  image(luce,larghezza/2-larghezza/16,altezza/3+altezza/100,height/4.8,height/4.8);
  text("  LUCE\nSALONE",larghezza/2-width/31,altezza/5*2.7+altezza/20);
  //terza lampadina
  image(luce,larghezza/2-larghezza/16,altezza-altezza/3+altezza/100,height/4.8,height/4.8);
  text("   LUCE\n GARAGE",larghezza/2-width/28,altezza/5*4.3+altezza/20);
  strokeWeight(1);
}


void portagarage(){
  int larghezza=width, altezza=height;
  fill(0,100,255);  //blu
  rect(0,0,larghezza,altezza);
  image(garage,larghezza/2-altezza/9.6,altezza/2-altezza/9.6,height/4.8,height/4.8);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  fill(0);
  textSize(height/57);
  text(" INDIETRO",larghezza/2-height/22.15,altezza-height/72);
}


void luciesterno(){
  int larghezza=width, altezza=height;
  if(clicked_luci_esterno==true) fill(0,255,50);
  else fill(0,120,10);
  rect(0,0,larghezza/2-1,altezza);
  if(clicked_automazione==true) fill(0,255,50);
  else fill(0,120,10);
  rect(larghezza/2+1,0,larghezza,altezza);
  //Lampadina
  image(luce,larghezza/5.5,altezza/10*3.3,altezza/4.11,altezza/4.11);
  fill(0);
  textSize(height/36);
  text("   LUCE\nESTERNO",larghezza/4-height/17.1,altezza/5*3);
  text("AUTOMAZIONE",larghezza/4*3-height/17.1,altezza/5*3);
  if(clicked_automazione==true) text("ON",larghezza/4*3+10,altezza/5*3+40);
  else text("OFF",larghezza/4*3+10,altezza/5*3+40);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  textSize(height/57);
  fill(0);
  text(" INDIETRO",larghezza/2-height/22.15,altezza-height/72);
}


void cancello(){
  fill(255,0,255);
  rect(0,0,larghezza,altezza-altezza/25);
  fill(130);
  rect(0,altezza-(altezza/25),larghezza,altezza/25);
  fill(0);
  textSize(height/57);
  text(" INDIETRO",larghezza/2-height/22.15,altezza-height/72);
  rect(larghezza/2+70,altezza/2-120,8,110,10);
  rect(larghezza/2+50,altezza/2-120,8,110,10);
  rect(larghezza/2+30,altezza/2-120,8,110,10);
  rect(larghezza/2+10,altezza/2-120,8,110,10);
  rect(larghezza/2-10,altezza/2-120,8,110,10);
  rect(larghezza/2-30,altezza/2-120,8,110,10);
  rect(larghezza/2-50,altezza/2-120,8,110,10);
  rect(larghezza/2-70,altezza/2-120,8,110,10);
  rect(larghezza/2-80,altezza/2-105,170,8,10);
  rect(larghezza/2-80,altezza/2-30,170,8,10);
  rect(larghezza/2-60,altezza/2-171,110,4);
  triangle(larghezza/2-60,altezza/2-177,larghezza/2-60,altezza/2-160,larghezza/2-70,altezza/2-169);
  textSize(height/36);
  text("CANCELLO",larghezza/2-105,altezza/2+70);
  strokeWeight(1);
}

void tasti2(){
  fill(0);
  strokeWeight(2);
  stroke(0);
  rect(0,altezza/25,larghezza,altezza-altezza/25);
  fill(204,101,255);
  rect(0,altezza/25,larghezza/2,altezza-altezza/25);
  fill(24,255,132);
  rect(larghezza/2,altezza/25,larghezza/2,altezza-altezza/25);
  strokeWeight(1);
  image(scena,larghezza/6.5,altezza/4,height/3.5,height/3.5);
  fill(0);
  textSize(height/20);
  text("SCENE",larghezza/5.3,altezza/10*7);
  image(termometro,larghezza/10*6.5,altezza/4,height/3.5,height/3.5);
  text("TEMPERATURA",larghezza/10*6.5,altezza/10*7);
}

void draw(){
  if(a=="ciao8") port.write(111);
  primavolta=true;
  if(clicked_switch==false){
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
    else if(clicked_cancello==true){
      tastocancello=true;
      cancello();
    }
  }
  else if(clicked_switch==true) tasti2();
}


void mousePressed(){
  Button luceinterno = new Button(0,altezza/25);
  Button portagarage = new Button(width/2+1,altezza/25);
  Button luceesterno = new Button(0,height/2+1);
  Button cancello = new Button(width/2+1,height/2+1);
  Button lucecucina = new Button(0,0);
  Button lucesalone = new Button(0,height/3);
  Button lucegarage = new Button(0,height/3*2);
  Button portagarageapertura = new Button(0,0);
  Button indietro = new Button(0,height-(height/25));
  Button luciesterno = new Button(0,0);
  Button automazione = new Button(larghezza/2+1,0);
  Button apertura_cancello = new Button(0,0);
  Button Switch = new Button(0,0);
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
  automazione.clicked_automazione(mouseX,mouseY);
  apertura_cancello.clicked_apertura_cancello(mouseX,mouseY);
  Switch.clicked_switch(mouseX,mouseY);
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
    if(mx>x && mx<x+w && my>y && my<(h-altezza/25)+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false && clicked_switch==false) {
      clicked_luce_interno=!clicked_luce_interno;
      a="ciao";
      println(a);
      port.write(11);
    }
  }
  public void clicked_porta_garage(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<(h-altezza/25)+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false && clicked_switch==false) {
      clicked_porta_garage=!clicked_porta_garage;
      a="ciao2";
      println(a);
    }
  }
  public void clicked_luce_esterno(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false && clicked_switch==false) {
      clicked_luce_esterno=!clicked_luce_esterno;
      a="ciao3";
      println(a);
      port.write(13);
    }
  }
  public void clicked_cancello(int mx, int my){
    if(mx>x && mx<x+w && my>y && my<h+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false && clicked_switch==false) {
      clicked_cancello=!clicked_cancello;
      a="ciao4";
      port.write(14);
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
    if(mx>x && mx<x+larghezza/2-1 && my>y && my<h3+y && clicked_luce_esterno==true && tastoluciesterne==true) {
      clicked_luci_esterno=!clicked_luci_esterno;
      a="ciao10";
      println(a);
      if(clicked_luci_esterno==true) port.write(9);
      else port.write(10);
    }
  }
  public void clicked_automazione(int mx, int my){
    if(mx>x && mx<x+larghezza/2-1 && my>y && my<h3+y && clicked_luce_esterno==true && tastoluciesterne==true) {
      clicked_automazione=!clicked_automazione;
      a="ciao11";
      println(a);
      if(clicked_automazione==true) {
        port.write(16);
      }
      else if(clicked_automazione==false) port.write(15);
    }
  }
  public void clicked_apertura_cancello(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h3+y && clicked_cancello==true && tastocancello==true){
      clicked_apertura_cancello=!clicked_apertura_cancello;
      a="ciao12";
      println(a);
      if(pausacancello==0){
        port.write(17);
        pausacancello+=1;
        println(17);
      }
      else if(pausacancello==1){
        port.write(19);
        pausacancello+=1;
        println(19);
      }
      else if(pausacancello==2){
        port.write(18);
        pausacancello+=1;
        println(18);
      }
      else{
        port.write(19);
        println(19);
        pausacancello=0;
      }
    }
  }
  public void clicked_switch(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h2+y && clicked_luce_interno==false && clicked_porta_garage==false && clicked_luce_esterno==false && clicked_cancello==false) {
      clicked_switch = !clicked_switch;
      println("ciao13");
    }
  }
  public void clicked_indietro(int mx, int my){
    if(mx>x && mx<x+w1 && my>y && my<h2+y && (clicked_luce_interno==true || clicked_porta_garage==true || clicked_luce_esterno==true || clicked_cancello==true)) {
      if(clicked_luce_interno==true) clicked_luce_interno=false;
      if(clicked_porta_garage==true) clicked_porta_garage=false;
      if(clicked_luce_esterno==true) clicked_luce_esterno=false;
      if(clicked_cancello==true) clicked_cancello=false;
      tastoluciesterne=false;
      tastiluci=false;
      tastogarage=false;
      tastocancello=false;
      a="ciao8";
      println(a);
    }
  }
}
