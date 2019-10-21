/ TP1 prog principal 2019
// Nancy Dodier, Jean-Philippe Dufour, David Martin Pierre Sévigny

// images fixe machine,ecran,distributeur
String file = "background photo.jpg";//  background 
PImage img;// background
PShape machine;//SVG machine
PShape distributeur; //SVG distributeur
PShape ecran; // SVG ecran de controle

// video---------------------------
import processing.video.*;
Movie video;

// Police de caractère ----
PFont policeONOFF;
PFont policeMoniteur;
  
// images en mouvement ou animé------------------
PShape chariot; // chariot
PShape boite;// boite+
//PShape boitesupport;// support 
PShape gyroscopeon; //gryroscope allume
PShape gyroscopeoff; // gyroscope eteind
PShape lumiererouge;//lumiére rouge
PShape lumiereverte; //lumiére verte
PShape brasmecanique;// bras mecanique
float x;
float y;
float vitesseX;
float vitesseY;

// audio-----
import ddf.minim.*;//************************

Minim minim;//**************************
AudioSample machineon;//**************************
AudioSample bruitagetapis;//***********************
AudioSample bruitagemachine;//*********************
AudioSample bruitsourd;//**********************
//------tapis roulant-------------------
PVector p3 = new PVector(200, 0, 00);
PVector p4 = new PVector(800, 0, 00);

//-----------------------------------------------------------------

//-------- Bouton on du tapis roulant ------
boolean boutonOnOver = false;
boolean boutonOffOver = true;

int tmpo;//++++++++++++++++++++++++++++++++++++++++

void setup() {
  tmpo = 0;//++++++++++++++++++++++++++++++++++++++
  x=-50;
  y=-20;
  vitesseX=20;
  policeONOFF = loadFont("ArialMT-45.vlw");  //Police de caractère pour le bouton ON/OFF (
  policeMoniteur = loadFont("Georgia-20.vlw");  //Police de caractère pour le moniteur
  size(1920,1080); // full hd
  img= loadImage("background photo.jpg"); //load background-image 
  frameRate(30); // 30 images seconde
  
  // --------affichage image fixe-----------
  machine = loadShape("machine.svg");//SVG machine
  distributeur = loadShape("distributeur.svg");//SVG distributeur
  ecran = loadShape("ecran.svg");//SVG ecran de controle
  
  //---------affichage image mouvement -------
  chariot= loadShape("chariot portique.svg");
 //boitesupport= loadShape("boite support.svg");
  boite= loadShape("boite.svg");//+
  //--------affichage image animé------------
  lumiereverte= loadShape("lumiere verte.svg");// lumiere machine on
  lumiererouge= loadShape("lumiere rouge.svg");// lumiere machine off
 
  gyroscopeoff= loadShape("gyroscope off.svg"); 
  gyroscopeon= loadShape("gyroscope on.svg");

  //--------affichage bras mecanique---------
  brasmecanique= loadShape("bras mecanique.svg");

  //----------affichage video--------------
  video = new Movie(this, "video surveillance.mov");
  video.frameRate(30);
  video.loop();
  // audio-------------------
   minim = new Minim(this);//********************************************
 machineon = minim.loadSample("bruitagemachine.mp3");//************************************
 bruitagetapis = minim.loadSample("bruitagetapis.mp3");//************************************
 bruitagemachine = minim.loadSample("grincement.wav");//************************************
bruitsourd = minim.loadSample("bruitsourd.mp3");//***********************************
 }
 
 
 void draw() {
   update(mouseX, mouseY);
   imageMode(CORNER);//  background
 tint(90);
   image(img, 0, 0, width , height);
// filter(GRAY);//fin background

 //-------support avant et arriere tapis roulant
 fill (74,187,183);// couleur bleu moodboard
 rect (1250,900,150,100);// support arriere
 rect (387,900,130,100); // support avant
  
    //---- boites A ANIMER ----
 // shape(boitesupport,-110,730,850,300);
 //----- Machine -------
 shape(machine, -450, 400, 1200, 800);
 //-------- animation bras mecanique chariot

shape(brasmecanique,345,320,2000,1000);
 
 //-------chariot portique-----
  fill (112,108,105);//couleur portique gris moonboard
  rect (1200,480,750,60);// portique 
  
  shape(chariot,900,400,850,300);// chariot du portique
  
  //--------gyroscope-------
 shape(gyroscopeon,642,290,200,200);//gyroscope on
 tmpo= tmpo+1;
 if (tmpo==2){
shape(gyroscopeoff,642,290,200,200);//gyroscope off
 }
if (tmpo ==3) {
tmpo=0;//+++++++++++++++++++
 }
//if (tempo==120) {
 // tempo =0;
//}
 
 //---------animation bras mecanique distributeur

 
 shape(brasmecanique,309,100,1200,1400);
 

 //-------- Distributeur -----
 shape(distributeur,150,10,1500,900);
 fill(238,81,72);
 circle (1052,380,30);

 //-------- Écran de controle -------
 shape(ecran,10,-350,700,700);
  
  //-----------video-----------
 //tint(91 , 255, 127, 255);
 noTint();
image(video, 150, 80,394,230);

//bouton on-off de la machine
  fill(21, 104, 51);
  noStroke();
  ellipse(150, 710, 50, 60);
  fill(181, 54, 51);
  ellipse(150, 840, 50, 60);
  
  // ---- boutons avance-recule du chariot porticle ---
  stroke(#000000);
  strokeWeight(0.5);
  fill(112,108,105);
  triangle(1288,535,1255,550,1288,565);
  triangle(1358,535,1391,550,1358,565);
  //noStroke();
  


//-----------textes--------

//textSize(20);// texte ecran
textFont(policeMoniteur,20);
fill(255);
text("monitor 1", 155, 100);

// texte machine on et off
textFont(policeONOFF,45);
fill(65, 61, 60);
text("ON", 122, 660); 
text("OFF", 110, 800); 
  
//--------tapis roulant ----------------
  Pontroulant();
  if (boutonOnOver){
  AnimPontRoulant();
  // audio
  machineon.trigger();//*****************************************
  bruitagetapis.trigger();//*****************************************
  bruitagemachine.trigger();//*****************************************
  shape(lumiereverte,-315,467,200,-150);//lumiére verte machine ouverte
  shape(boite,x,y,250,250);
  if (x<=800){
  bouge();
  
  }
  }
  else {
  shape(lumiererouge,-315,467,200,-150);//lumiére rouge machine fermé
  // audio off
 machineon.stop();//*****************************************************
 bruitagetapis.stop();//**************************************************
 bruitagemachine.stop();//********************************

  shape(boite,x,y,250,250);
  
  }
  if (x==790){ 
   bruitsourd.trigger();//*****************************************
}
}

void bouge(){
  x=x+vitesseX;
  
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void Pontroulant() {
  scale(1.0f, -1.0f);
  stroke(155, 102, 0);
  translate(380, -950);//modif david
  arc(p3.x, p3.y, height / 10.0f, height / 10.0f, 0.0f, radians(360.0f));
  arc(p4.x, p4.y, height / 10.0f, height / 10.0f, 0.0f, radians(360.0f));
  strokeWeight(5);
  stroke(74, 74, 74);
  if (frameCount % 2 == 0)
    //position moteur 1
  fill(224, 224, 224);
  line(200, height / 20.0f, 800, height / 20.0f);
  line(200, -height / 20.0f, 800, -height / 20.0f);
}
 
 //----Bouton tapis roulant ---- 
void update(int x, int y) {
  if (boutonOnOver(150, 710, 50) ) {
    boutonOnOver = true;
  } else if ( boutonOffOver(150, 840, 50) ) {
    boutonOnOver = false;
  }
  }
 
boolean boutonOnOver(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
 }
 
 boolean boutonOffOver(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
    
 
  } else {
    return false;
  }
 }

void AnimPontRoulant() {
  pushMatrix();
  translate(200, p3.y);
  rotate(radians(-frameCount * 30 % 360));
  rect(0, 0, 40, 2);
  popMatrix();
  //position moteur 2
  pushMatrix();
  translate(800, p4.y);
  rotate(radians(-frameCount * 30 % 360));
  rect(0, 0, 40, 2);
  popMatrix();
}

// fin
