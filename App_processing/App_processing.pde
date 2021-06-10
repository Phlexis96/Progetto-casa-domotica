/*
Progetto Casa Domotica
by Maggio Antonino, Pulizzi Josè e Lombardo Marco
*/
import processing.serial.*;
int larghezza = width, altezza = height;
boolean primavolta = false;
boolean clicked_luce_interno = false;  //luce interno menù principale
boolean clicked_porta_garage = false;  //porta garage menù principale
boolean clicked_luce_esterno = false;  //luce esterno menù principale
boolean clicked_cancello = false;  //tasto cancello menù principale
boolean clicked_luce_cucina = false;  //luce cucina menù luci
boolean clicked_luce_salone = false;  //luce salone menù luci
boolean clicked_luce_garage = false;  //luce garage menù luci
boolean clicked_porta_garage_apertura = false;  //porta garage menù garage
boolean clicked_luci_esterno = false;  //luci esterno menù luci esterno
boolean clicked_automazione = false;  //automazione luci esterno
boolean clicked_apertura_cancello = false; //tasto per aprire il cancello
boolean clicked_switch = false; //tasto per cambiare menu
boolean clicked_switch2 = false; //tasto per cambiare menu
boolean clicked_menuscene = false; //tasto menu scene
boolean clicked_menutemperatura = false; //tasto menu temperatura
boolean tastiluci = false;
boolean tastogarage = false;
boolean tastoluciesterne = false;
boolean tastocancello = false;
boolean tastomenuscene = false;
boolean tastoswitch = false;
boolean tastomenutemperatura = false;
float temperatura;
float verticalita;
float old_temperatura = 0;
int orizzontale;
int pausacancello = 0;
String binario = "000";
int casa_ino = 0;
int corridoio_ino = 0;
int garage_ino = 0;
int random = 0;
int rosso;
int verde;
String a;
PImage scena;
PImage termometro;
PImage luce;
PImage cancello;
PImage garage;
Serial port;


void setup() {
    fullScreen();
    //size(1920,1080);
    port = new Serial(this, Serial.list()[0], 38400); //Variabile luce
    scena = loadImage("pngegg.png");
    termometro = loadImage("termometro.png");
    luce = loadImage("luce.png");
    cancello = loadImage("cancello.png");
    garage = loadImage("garage.png");
    background(0);
}

//Funzione del menù principale
void tasti() {
    larghezza = width;
    altezza = height;
    stroke(0);
    strokeWeight(2);
    fill(255,180,0);  //giallo
    rect(0,0,larghezza / 2,altezza / 2);
    fill(0,100,255);  //blu
    rect((larghezza / 2) + 1,0,larghezza / 2,altezza / 2);
    fill(0,255,50);   //verde
    rect(0,(altezza / 2) + 1,larghezza / 2,altezza / 2);
    fill(255,0,255);  //viola
    rect((larghezza / 2) + 1,(altezza / 2) + 1,larghezza / 2,altezza / 2);
    fill(50);  //Switch
    rect(0,0,larghezza,altezza / 25);
    rect(0,altezza,larghezza, - altezza / 25);
    fill(0);
    image(luce,larghezza / 5.5,altezza / 12,altezza / 4.11,altezza / 4.11);  //Simbolo lampadina
    textSize(height / 36);
    text("     LUCI\n INTERNO",larghezza / 4 - altezza / 13.7,altezza / 4 + altezza / 10);
    image(garage,larghezza / 10 * 6.95,altezza / 9,height / 4.8,height / 4.8);  //Simbolo garage
    fill(0);
    text(" PORTA\nGARAGE",larghezza / 4 * 3 - height / 18.7,altezza / 4 + height / 10);
    image(luce,larghezza / 5.5,altezza / 10 * 5.7,altezza / 4.11,altezza / 4.11);  //Simbolo lampadina 2
    textSize(height / 36);
    text("     LUCI\n ESTERNO",larghezza / 4 - height / 13.7,altezza / 4 * 3 + height / 12);
    //Simbolo cancello
    image(cancello,larghezza / 10 * 6.9,altezza / 10 * 6.2,height / 4.5,height / 5);
    text("CANCELLO",larghezza / 4 * 3 - height / 13.71,altezza / 4 * 3 + height / 9);
    strokeWeight(1);
}

//Funzione per il menù luci interne
void luceinterno() {
    int larghezza = width, altezza = height;
    strokeWeight(2);
    if(clicked_luce_cucina ==  true) fill(255,180,0);
    else fill(155,80,0);
    rect(0,0,larghezza,altezza / 3);
    if(clicked_luce_salone ==  true) fill(255,180,0);
    else fill(155,80,0);
    rect(0,altezza / 3,larghezza,altezza / 3);
    if(clicked_luce_garage ==  true) fill(255,180,0);
    else fill(155,80,0);
    rect(0,altezza / 3 * 2,larghezza,altezza / 3);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    fill(0);
    textSize(height / 57);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
    textSize(height / 36);
    image(luce,larghezza / 2 - larghezza / 16,altezza / 100,height / 4.8,height / 4.8);  //prima lampadina
    text("    LUCE\nCORRIDOIO",larghezza / 2 - width / 22,altezza / 5 + altezza / 20);
    image(luce,larghezza / 2 - larghezza / 16,altezza / 3 + altezza / 100,height / 4.8,height / 4.8);  //seconda lampadina
    text("   LUCE\n GARAGE",larghezza / 2 - width / 25,altezza / 5 * 2.7 + altezza / 20);
    image(luce,larghezza / 2 - larghezza / 16,altezza - altezza / 3 + altezza / 100,height / 4.8,height / 4.8);  //terza lampadina
    text("LUCE\nCASA",larghezza / 2 - width / 45,altezza / 5 * 4.3 + altezza / 20);
    strokeWeight(1);
}

//Funzione per il menu del garage
void portagarage() {
    int larghezza = width, altezza = height;
    fill(0,100,255);  //blu
    rect(0,0,larghezza,altezza);
    image(garage,larghezza / 2 - altezza / 9.6,altezza / 2 - altezza / 6,height / 4.8,height / 4.8);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    fill(0);
    textSize(height / 57);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
}

//Funzione per il menu delle luci esterne
void luciesterno() {
    int larghezza = width, altezza = height;
    if(clicked_luci_esterno ==  true) fill(0,255,50);
    else fill(0,120,10);
    rect(0,0,larghezza / 2 - 1,altezza);
    if(clicked_automazione ==  true) fill(0,255,50);
    else fill(0,120,10);
    rect(larghezza / 2 + 1,0,larghezza,altezza);
    image(luce,larghezza / 5.5,altezza / 10 * 3.3,altezza / 4.11,altezza / 4.11);  //Lampadina
    fill(0);
    textSize(height / 36);
    text("   LUCE\nESTERNO",larghezza / 4 - height / 17.1,altezza / 5 * 3);
    text("AUTOMAZIONE",larghezza / 4 * 3 - height / 17.1,altezza / 5 * 3);
    if(clicked_automazione ==  true) text("ON",larghezza / 4 * 3 + 10,altezza / 5 * 3 + 40);
    else text("OFF",larghezza / 4 * 3 + 10,altezza / 5 * 3 + 40);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    textSize(height / 57);
    fill(0);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
}

//Funzione per il menu del cancello
void cancello() {
    fill(255,0,255);
    rect(0,0,larghezza,altezza - altezza / 25);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    fill(0);
    textSize(height / 57);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
    image(cancello,larghezza / 2 - height / 9,altezza / 2 - height / 6,height / 4.5,height / 5);
    textSize(height / 36);
    text("CANCELLO",larghezza / 2 - height / 13.71,altezza / 2 + height / 12);
    strokeWeight(1);
}

//Funzione per il secondo menu
void tasti2() {
    strokeWeight(2);
    fill(0);
    strokeWeight(2);
    stroke(0);
    rect(0,altezza / 25,larghezza,altezza - altezza / 25);
    fill(204,101,255);
    rect(0,altezza / 25,larghezza / 2,altezza - altezza / 25);
    fill(24,255,132);
    rect(larghezza / 2,altezza / 25,larghezza / 2,altezza - altezza / 25);
    strokeWeight(1);
    image(scena,larghezza / 6.5,altezza / 4,height / 3.5,height / 3.5);
    fill(0);
    textSize(height / 20);
    text("SCENE",larghezza / 5.3,altezza / 10 * 7);
    image(termometro,larghezza / 10 * 6.5,altezza / 4,height / 3.5,height / 3.5);
    text("TEMPERATURA",larghezza / 10 * 6.5,altezza / 10 * 7);
    fill(50);  //Switch
    rect(0,0,larghezza,altezza / 25);
    rect(0,altezza,larghezza, - altezza / 25);
    strokeWeight(1);
}

//Funzione per il menu delle scene
void menuscene() {
    fill(204,101,255);
    rect(0,0,larghezza,altezza);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    fill(0);
    textSize(height / 57);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
}

//Funzione per il menu della temperatura
void menutemperatura() {
    if (port.available()>0) {   
        temperatura = (float(port.readString().trim()));
        if (temperatura > 50) temperatura = 50;
        elseif (temperatura <-  20) temperatura =-  20;
 }
    println(temperatura);
    verticalita = map(temperatura,0,40,0,altezza - (altezza / 15 * 2));
    rosso = int(map(temperatura,25,35,0,255));
    verde = int(map(temperatura,25,35,255,0));
    if (orizzontale >= larghezza - (larghezza / 15 * 2)) {
        orizzontale = 0;
        fill(0);
        rect(0,0,larghezza,altezza - altezza / 25);
 }
    for (int i = 0; i <= 40; i++) {
        strokeWeight(0);
        fill(255,255,255);
        rect(larghezza / 15,altezza - altezza / 15 - ((altezza - (altezza / 15 * 2)) / 40 * i), larghezza - (larghezza / 15 * 2), 1);  //Rette del grafico
        strokeWeight(1);
        fill(255);
        textSize(15);
        rect(larghezza / 15,altezza - altezza / 15 - ((altezza - (altezza / 15 * 2)) / 40 * i), -larghezza / 100, altezza / 300);  //Trattini per scala gradi
        text(i + "°C", larghezza / 25, altezza - altezza / 16 - ((altezza - (altezza / 15 * 2)) / 40 * i));  //Scala gradi
 }
    fill(rosso,verde,0);
    strokeWeight(0);
    if ((temperatura > old_temperatura - 5 && temperatura < old_temperatura + 5) || old_temperatura == 0) {
        old_temperatura = temperatura;
        rect(larghezza / 15 + orizzontale,(altezza - altezza / 15) - verticalita,1,(altezza - altezza / 15) + verticalita);  //GRAFICO
        orizzontale += 1;
        fill(0);
        rect(larghezza / 100 * 45,altezza / 20,larghezza / 3, - altezza / 20);
        textSize(30);
        fill(255);
        text("Temperatura: " + temperatura,larghezza / 100 * 46,altezza / 20);
 }
    strokeWeight(1);
    fill(255);
    rect(larghezza / 15,altezza - altezza / 15, larghezza - (larghezza / 15 * 2), altezza / 300); //asse x
    rect(larghezza / 15,altezza - altezza / 15, altezza / 300, - (altezza - (altezza / 15 * 2))); //asse y
    fill(0);
    rect(larghezza / 15,altezza - altezza / 15 + altezza / 300, larghezza - (larghezza / 15 * 2), altezza / 40);
    fill(130);
    rect(0,altezza - (altezza / 25),larghezza,altezza / 25);
    fill(0);
    textSize(height / 57);
    text(" INDIETRO",larghezza / 2 - height / 22.15,altezza - height / 72);
    delay(100);
}


void draw() {
    if(clicked_switch ==  false) {
        if (clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false) tasti();
        elseif (clicked_luce_interno ==  true) {
            tastiluci = true;
            tastoswitch = true;
            luceinterno();
        }
        elseif (clicked_porta_garage ==  true) {
            tastoswitch = true;
            tastogarage = true;
            portagarage();
        }
        elseif (clicked_luce_esterno ==  true) {
            tastoswitch = true;
            tastoluciesterne = true;
            luciesterno();
        }
        elseif (clicked_cancello ==  true) {
            tastoswitch = true;
            tastocancello = true;
            cancello();
        }
 }
    else if (clicked_switch ==  true) {
        if (clicked_menuscene == false && clicked_menutemperatura == false) {
            tasti2();
            orizzontale = 0;
        }
        elseif (clicked_menuscene == true) {
            tastoswitch = true;
            tastomenuscene = true;
            menuscene();
        }
        elseif (clicked_menutemperatura == true) {
            if (primavolta == false) {
                fill(0);
                rect(0,0,width,height);
                primavolta = true;
        }
            tastoswitch = true;
            tastomenutemperatura = true;
            menutemperatura();
        }
 }
}


void mousePressed() {
    Button luceinterno = new Button(0,altezza / 25);
    Button portagarage = new Button(width / 2 + 1,altezza / 25);
    Button luceesterno = new Button(0,height / 2 + 1);
    Button cancello = new Button(width / 2 + 1,height / 2 + 1);
    Button lucecucina = new Button(0,0);
    Button lucesalone = new Button(0,height / 3);
    Button lucegarage = new Button(0,height / 3 * 2);
    Button portagarageapertura = new Button(0,0);
    Button indietro = new Button(0,height - (height / 25));
    Button luciesterno = new Button(0,0);
    Button automazione = new Button(larghezza / 2 + 1,0);
    Button apertura_cancello = new Button(0,0);
    Button Switch = new Button(0,0);
    Button Switch2 = new Button(0,altezza - altezza / 25);
    Button menuscene = new Button(0,altezza / 25);
    Button menutemperatura = new Button(larghezza / 2,altezza / 25);
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
    Switch2.clicked_switch2(mouseX,mouseY);
    menuscene.clicked_menuscene(mouseX,mouseY);
    menutemperatura.clicked_menutemperatura(mouseX,mouseY);
}

//Classe pulsanti
public class Button {
    int larghezza = width, altezza = height;
    int x,y,w,h,w1,h1,h2,h3;
    public Button(int xb, int yb) {
        int larghezza = width, altezza = height;
        x = xb;
        y = yb;
        w = larghezza / 2;
        h = altezza / 2;
        w1 =larghezza;
        h1 =altezza / 3;
        h2 =altezza / 25;
        h3 =altezza - (altezza / 25);
 }
    public void draw() {
        stroke(0);
        rect(x,y,w,h);
 }
    //Pulsante luci interno nel menu principale
    public void clicked_luce_interno(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < (h - altezza / 25) + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_switch ==  false) {
            clicked_luce_interno =! clicked_luce_interno;
            a = "ciao";
            println(a);
            port.write(11);
        }
 }
    //Pulsante garage nel menu principale
    public void clicked_porta_garage(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < (h - altezza / 25) + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_switch ==  false) {
            clicked_porta_garage =! clicked_porta_garage;
            a = "ciao2";
            println(a);
            port.write(12);
        }
 }
    //Pulsante luci esterno nel menu principale
    public void clicked_luce_esterno(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < h - altezza / 25 + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_switch ==  false) {
            clicked_luce_esterno =! clicked_luce_esterno;
            a = "ciao3";
            println(a);
            port.write(13);
        }
 }
    //Pulsante cancello nel menu principale
    public void clicked_cancello(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < h - altezza / 25 + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_switch ==  false) {
            clicked_cancello =! clicked_cancello;
            a = "ciao4";
            port.write(14);
            println(a);
        }
 }
    //Pulsante luci cucina nel menu luci interno
    public void clicked_luce_cucina(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h1 + y && clicked_luce_interno ==  true && tastiluci ==  true) {
            clicked_luce_cucina =! clicked_luce_cucina;
            a = "ciao5";
            println(a);
           if (casa_ino ==  0) {
                casa_ino= 1;
        }
            else if (casa_ino ==  1) {
                casa_ino= 0;
        }
            binario = casa_ino + "" + corridoio_ino + "" + garage_ino;
            println(casa_ino + "" + corridoio_ino + "" + garage_ino);
           if (binario.equals("000")) {
                port.write(1);
        }
           if (binario.equals("001")) {
                port.write(2);
        }
           if (binario.equals("010")) {
                port.write(3);
        } 
           if (binario.equals("011")) {
                port.write(4);
        }
           if (binario.equals("100")) {
                port.write(5);
        }
           if (binario.equals("101")) {
                port.write(6);
        }
           if (binario.equals("110")) {
                port.write(7);
        } 
           if (binario.equals("111")) {
                port.write(8);
        }
        }
 }
    //Pulsante luci salone nel menu luci interno
    public void clicked_luce_salone(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h1 + y && clicked_luce_interno ==  true && tastiluci ==  true) {
            clicked_luce_salone =! clicked_luce_salone;
            a = "ciao6";
            println(a);
           if (corridoio_ino ==  0) {
                corridoio_ino = 1;
        }
            else if (corridoio_ino ==  1) {
                corridoio_ino = 0;
        }
            binario = casa_ino + "" + corridoio_ino + "" + garage_ino;
            println(casa_ino + "" + corridoio_ino + "" + garage_ino);
           if (binario.equals("000")) {
                port.write(1);
        }
           if (binario.equals("001")) {
                port.write(2);
        }
           if (binario.equals("010")) {
                port.write(3);
        } 
           if (binario.equals("011")) {
                port.write(4);
        }
           if (binario.equals("100")) {
                port.write(5);
        }
           if (binario.equals("101")) {
                port.write(6);
        }
           if (binario.equals("110")) {
                port.write(7);
        } 
           if (binario.equals("111")) {
                port.write(8);
        }
        }
 }
    //Pulsante luci garage nel menu luci interno
    public void clicked_luce_garage(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h1 - (altezza / 25) + y && clicked_luce_interno ==  true) {
            clicked_luce_garage =! clicked_luce_garage;
            a = "ciao7";
            println(a);
           if (garage_ino ==  0) {
                garage_ino = 1;
        }
            else if (garage_ino ==  1) {
                garage_ino = 0;
        }
            binario = casa_ino + "" + corridoio_ino + "" + garage_ino;
            println(casa_ino + "" + corridoio_ino + "" + garage_ino);
           if (binario.equals("000")) {
                port.write(1);
        }
           if (binario.equals("001")) {
                port.write(2);
        }
           if (binario.equals("010")) {
                port.write(3);
        } 
           if (binario.equals("011")) {
                port.write(4);
        }
           if (binario.equals("100")) {
                port.write(5);
        }
           if (binario.equals("101")) {
                port.write(6);
        }
           if (binario.equals("110")) {
                port.write(7);
        } 
           if (binario.equals("111")) {
                port.write(8);
        }
        }
 }
    //Pulsante apertura/chiusura garage nel menu del garage
    public void clicked_porta_garage_apertura(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h3 + y && clicked_porta_garage ==  true && tastogarage ==  true) {
            clicked_porta_garage_apertura =! clicked_porta_garage_apertura;
            a = "ciao9";
            port.write(20);
            println(a);
        }
 }
    //Pulsante accensione/spegnimento luci esterne nel menu luci esterno
    public void clicked_luci_esterno(int mx, int my) {
        if (mx > x && mx < x + larghezza / 2 - 1 && my > y && my < h3 + y && clicked_luce_esterno ==  true && tastoluciesterne ==  true && clicked_automazione ==  false) {
            clicked_luci_esterno =! clicked_luci_esterno;
            a = "ciao10";
            println(a);
           if (clicked_luci_esterno ==  true) port.write(9);
            else port.write(10);
        }
 }
    //Pulsante automazioni luci esterne nel menu luci esterne
    public void clicked_automazione(int mx, int my) {
        if (mx > x && mx < x + larghezza / 2 - 1 && my > y && my < h3 + y && clicked_luce_esterno ==  true && tastoluciesterne ==  true) {
            clicked_automazione =! clicked_automazione;
            a = "ciao11";
            println(a);
           if (clicked_automazione ==  true) {
                port.write(16);
                clicked_luci_esterno = false;
        }
            else if (clicked_automazione ==  false) port.write(15);
        }
 }
    //Pulsante apertura/chiusura cancello nel menu cancello
    public void clicked_apertura_cancello(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h3 + y && clicked_cancello ==  true && tastocancello ==  true) {
            clicked_apertura_cancello =! clicked_apertura_cancello;
            a = "ciao12";
            println(a);
           if (pausacancello ==  0) {
                port.write(17);
                pausacancello += 1;
                println(17);
        }
            else if (pausacancello ==  1) {
                port.write(19);
                pausacancello += 1;
                println(19);
        }
            else if (pausacancello ==  2) {
                port.write(18);
                pausacancello += 1;
                println(18);
        }
        else{
                port.write(19);
                println(19);
                pausacancello = 0;
        }
        }
 }
    //Pulsante per cambiare menu (sopra)
    public void clicked_switch(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h2 + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_menuscene == false) {
            clicked_switch = !clicked_switch;
            println("ciao13");
        }
 }
    //Pulsante per cambiare menu (sotto)
    public void clicked_switch2(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < h2 + y && clicked_luce_interno ==  false && clicked_porta_garage ==  false && clicked_luce_esterno ==  false && clicked_cancello ==  false && clicked_menuscene == false) {
            clicked_switch = !clicked_switch;
            println("ciao13");
        }
 }
    //Pulsante menu delle scene nel secondo menu principale
    public void clicked_menuscene(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < altezza - (altezza / 25 * 2) + y && clicked_switch == true && clicked_menuscene == false) {
            clicked_menuscene = !clicked_menuscene;
            println("ciao14");
            port.write(21);
        }
 }
    //Pulsante menu della temperatura nel secondo menu principale
    public void clicked_menutemperatura(int mx, int my) {
        if (mx > x && mx < x + w && my > y && my < altezza - (altezza / 25 * 2) + y && clicked_switch == true && clicked_menutemperatura == false) {
            clicked_menutemperatura = !clicked_menutemperatura;
            println("ciao15");
            port.write(33);
        }
 }
    //Pulsante per tornare indietro da qualsiasi sotto-menu
    public void clicked_indietro(int mx, int my) {
        if (mx > x && mx < x + w1 && my > y && my < altezza - altezza / 2 + y && (clicked_luce_interno ==  true || clicked_porta_garage ==  true || clicked_luce_esterno ==  true || clicked_cancello ==  true || clicked_menuscene == true || clicked_menutemperatura == true)) {
           if (clicked_luce_interno ==  true) clicked_luce_interno = false;
           if (clicked_porta_garage ==  true) clicked_porta_garage = false;
           if (clicked_luce_esterno ==  true) clicked_luce_esterno = false;
           if (clicked_cancello ==  true) clicked_cancello = false;
           if (clicked_menuscene == true) clicked_menuscene = false;
           if (clicked_menutemperatura == true) clicked_menutemperatura = false;
            clicked_switch = !clicked_switch;
            tastoluciesterne = false;
            tastiluci = false;
            tastogarage = false;
            tastocancello = false;
            tastomenuscene = false;
            tastoswitch = false;
            tastomenutemperatura = false;
            primavolta = false;
            a = "ciao8";
            println(a);
            port.write(111);
        }
 }
}
