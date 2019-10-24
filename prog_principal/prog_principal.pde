// TP1 prog principal 2019
// Nancy Dodier, Jean-Philippe Dufour, David Martin Pierre Sévigny

// images fixe machine,ecran,distributeur

String file = "background Photo.jpg";//  background 
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
PFont f;

// images en mouvement ou animé-----------------

PShape chariot; // chariot

PShape boitesupport;// support 
PShape gyroscopeon; //gryroscope allume
PShape gyroscopeoff; // gyroscope eteind
PShape lumiererouge;//lumiére rouge
PShape lumiereverte; //lumiére verte
PShape brasmecanique;// bras mecanique

//Boite-----------------------------------

PShape boite;// boite+
PVector orgPosBoite = new PVector(340, 732);
PVector currentPosBoite = new PVector(340, 732);
float vitesseX;
float orgVitesseY = 2;
float currentVitesseY;
boolean brasCanMoveBox = false;

// audio-----

import ddf.minim.*;
Minim minim;
AudioSample machineon;
AudioSample bruitagetapis;
AudioSample bruitagemachine;
AudioSample bruitsourd;
AudioSample portique;
AudioSample rangeboite;
AudioSample manette;
AudioSample manette2;

//------tapis roulant-------------------

PVector p3 = new PVector(580, -950, 00);
PVector p4 = new PVector(1180, -950, 00);
boolean tapisIsOn = false;
int speed;
int bouge;
int ess;

//Bouton tapis roulant

PVector boutonOnPos =  new PVector(150, 710, 00);
PVector boutonOffPos = new PVector(150, 840, 00);
PVector boutonSize =   new PVector (50, 60, 00);
PVector boutonActivePos = boutonOnPos;
color greenButon = color(0, 255, 0);
color redButon =   color(100, 0, 0);

//BrasMechanique

//Bouton Bras Mechanique

PVector triangleOneX = new PVector(1288, 1255, 1288);
PVector triangleY = new PVector(535, 550, 565);
PVector triangleTwoX = new PVector(1358, 1391, 1358);
PVector triangleSize = new PVector(triangleOneX.x-triangleOneX.y, triangleY.z-triangleY.x);
PVector redRectPos = new PVector(triangleOneX.x, triangleY.z);
PVector redRectSize = new PVector(triangleTwoX.x - triangleOneX.z, triangleY.x - triangleY.z);

//BrasMechanique Position et autre

PVector brasPos = new PVector(345, 320);
PVector brasSize = new PVector(2000, 900);
PVector chariotPos = new PVector(900, 400);
PVector chariotSize = new PVector(850, 300);
float chariotOrgPosX;
float brasMove = 0;
float brasMoveSpeed = 10;
boolean dropTheBox = false;

int tmpo;
int bras;
int touche;

void setup() {
  ess=1;
  bouge=480;
  bras=50;
  tmpo = 0;
  currentVitesseY = orgVitesseY;
  vitesseX=20;
  chariotOrgPosX = chariotPos.x;

  policeONOFF = loadFont("ArialMT-45.vlw");  //Police de caractère pour le bouton ON/OFF (
  policeMoniteur = loadFont("Georgia-20.vlw");  //Police de caractère pour le moniteur
  size(1920, 1080); // full hd
  img= loadImage("background_photo.jpg"); //load background-image 
  frameRate(30); // 30 images seconde

  // --------affichage image fixe-----------

  machine = loadShape("machine.svg");//SVG machine
  distributeur = loadShape("distributeur.svg");//SVG distributeur
  ecran = loadShape("ecran.svg");//SVG ecran de controle

  //---------affichage image mouvement -------

  chariot= loadShape("chariotportique.svg");
  boitesupport= loadShape("boitesupport.svg");
  boite = loadShape("boite.svg");//+

  //--------affichage image animé------------

  lumiereverte= loadShape("lumiereverte.svg");// lumiere machine on
  lumiererouge= loadShape("lumiererouge.svg");// lumiere machine off
  gyroscopeoff= loadShape("gyroscopeoff.svg"); 
  gyroscopeon= loadShape("gyroscopeon.svg");

  //--------affichage bras mecanique---------

  brasmecanique= loadShape("brasmecanique.svg");

  //----------affichage video--------------

  video = new Movie(this, "videosurveillance.mov");
  video.frameRate(30);
  video.loop();

  // audio-------------------

  minim = new Minim(this);
  machineon = minim.loadSample("bruitagemachine.wav");
  bruitagetapis = minim.loadSample("bruitagetapis.wav");
  bruitagemachine = minim.loadSample("grincement.wav");
  bruitsourd = minim.loadSample("bruitsourd.mp3");
  portique = minim.loadSample("bruitsourd.mp3");
  rangeboite = minim.loadSample("bruitsourd.mp3"); 
  portique= minim.loadSample("portique.mp3");
  rangeboite= minim.loadSample("bruitrangement.mp3");
  manette= minim.loadSample("bras.mp3");
  manette2= minim.loadSample("manette.mp3");

  //----typo
  f=createFont("Lato-Regular.ttf", 20);
}

//******************************************

void draw() {

  pushMatrix();
  imageMode(CORNER);//  background
  tint(90);
  image(img, 0, 0, width, height);

  //-------support avant et arriere tapis roulant

  fill (74, 187, 183);// couleur bleu moodboard
  rect (1250, 900, 150, 100);// support arriere
  rect (387, 900, 130, 100); // support avant

  //----- Machine -------

  shape(machine, -450, 400, 1200, 800);

  //-------chariot portique-----

  rect (1200, 480, 750, 60);// portique 

  //--------gyroscope-------
  shape(gyroscopeon, 642, 290, 200, 200);//gyroscope on
  tmpo= tmpo+1;
  if (tmpo==2) {
    shape(gyroscopeoff, 642, 290, 200, 200);//gyroscope off
  }
  if (tmpo ==3) {
    tmpo=0;//+++++++++++++++++++
  }

  //---------animation bras mecanique distributeur
  
  if (bouge==480) {
    bras=bras+15;
  }
  if (bouge==380) {
    bras=bras-15;
  }
  if (bras<-150) {
    bras=-150;
  }  
  if (bras>120) {
    bras=120;
  } 
  if (touche==1) {
    if (bras<120) {
      manette.trigger();
    }
  } else
  {
    manette.stop();
  }  
  if (touche==0) {
    if (bras>-150) {
      manette2.trigger();
    }
  } else
  {
    manette2.stop();
  }  
  shape(brasmecanique, 309, bras, 1200, 1400);
  if (bras<=120) {
    if (ess==1) {
      shape(boitesupport, 671, bras+630, 450, 80);
    }
  }
  if (bras==-150) {

    shape(boitesupport, 671, bras+630, 450, 80);
  }

  //-------- Distributeur -----
  shape(distributeur, 150, 10, 1500, 900);
  fill(238, 81, 72);
  circle (1052, bouge, 30);
  if (keyPressed == true) {
    bouge=480;
    touche=1;
  } else {
    bouge=380;
    touche=0;
  }

  //-------- Écran de controle -------
  shape(ecran, 10, -350, 700, 700);

  //-----------video-----------
  //tint(91 , 255, 127, 255);
  noTint();
  image(video, 150, 80, 394, 230);

  //bouton on-off de la machine
  fill(21, 104, 51);
  noStroke();
  ellipse(150, 710, 50, 60);
  fill(181, 54, 51);
  ellipse(150, 840, 50, 60);

  //-----------textes--------

  textFont(f);
  fill(#FFD52E);
  text("Production #", width/1.5f, height/1.155f);
  textFont(f);
  fill(#E82D2C);
  text("BY40125", width / 1.5f, height / 1.125f); 
  textFont(policeMoniteur, 20);
  fill(255);
  text("monitor 1", 155, 100);

  popMatrix();
  Boite();
  BrasMechanique();

  //--------tapis roulant ----------------

  Pontroulant();
  BoutonOnOff();
  LumiereMarche();
  SonAmbiant();
}

// Called every time a new frame is available to read

void movieEvent(Movie m) {
  m.read();
}

// Boite

void Boite()
{
  pushMatrix();
  shape(boite, currentPosBoite.x, currentPosBoite.y, 250, 250);
  BoiteMouvement();
  popMatrix();
}

void BoiteMouvement() 
{
  if (dropTheBox)
  {
    if (currentPosBoite.y < 2000)
    {
      brasCanMoveBox = false;
      currentVitesseY += currentVitesseY /3.00f;
      currentPosBoite.y += currentVitesseY;
    } else
    {
      currentVitesseY = orgVitesseY;
      currentPosBoite.y = orgPosBoite.y;
      currentPosBoite.x = orgPosBoite.x;
      dropTheBox = false;
    }
  } else
  {

    if (currentPosBoite.x <= 1180 && tapisIsOn)
    {
      currentPosBoite.x += vitesseX;
      textFont(f);
      fill(#E82D2C);
      text("APPROUVÉE", width / 1.52f, height / 1.085f);
    } else if (brasCanMoveBox)
    {
      textFont(f);
      fill(#FFD52E);
      text("APPROUVÉE", width / 1.52f, height / 1.085f);
      currentPosBoite.x += brasMove;
    } else if (currentPosBoite.x >= 1180 && chariotPos.x <= chariotOrgPosX)
    {
      brasCanMoveBox = true;
      currentPosBoite.x += brasMove;
    } else if (currentPosBoite.x <= 1180 && chariotPos.x >= chariotOrgPosX)
    {
      brasCanMoveBox = false;
    }
  }
}



//
//
// PontRoulant
void Pontroulant() 
{
  pushMatrix();
  scale(1.0f, -1.0f);
  stroke(0, 0, 0);
  fill(96, 96, 96);
  arc(p3.x, p3.y, height / 10.0f, height / 10.0f, 0.0f, radians(360.0f));
  arc(p4.x, p4.y, height / 10.0f, height / 10.0f, 0.0f, radians(360.0f));
  strokeWeight(5);
  stroke(0, 0, 0);
  if (frameCount % 2 == 0)
  {
    //position moteur 1
  }
  line(p3.x, p3.y + (height / 20.0f), p4.x, p3.y + (height / 20.0f));
  line(p3.x, p3.y - (height / 20.0f), p4.x, p3.y - (height / 20.0f));
  AnimPontRoulant();
}

void AnimPontRoulant() {

  int speed = 0;
  if (tapisIsOn && speed != 30)
  {
    speed = 30;
  } else
  {
    speed = 0;
  }
  Moteur(p3.x, speed);
  Moteur(p4.x, speed);
  popMatrix();
}

void Moteur(float x, float speed)
{
  pushMatrix();
  translate(x, p3.y);
  rotate(radians(-frameCount * speed % 360));
  rect((height / 22.0f)*-1, -1, height / 11.0f, 2);
  rect(-1, (height / 22.0f)*-1, 2, height / 11.0f);
  popMatrix();
}

void BoutonOnOff()
{
  pushMatrix();
  textFont(policeONOFF, 45);
  textSize(45);
  fill(65, 61, 60);
  text("ON", boutonOnPos.x-boutonSize.x/5, 660); 
  text("OFF", boutonOnPos.x-boutonSize.x/4, 800); 

  stroke(0, 0, 0);
  fill(greenButon);
  ellipse(boutonOnPos.x, boutonOnPos.y, boutonSize.x, boutonSize.y);
  fill(redButon);
  ellipse(boutonOffPos.x, boutonOffPos.y, boutonSize.x, boutonSize.y);
  popMatrix();
}

void LumiereMarche()
{
  pushMatrix();
  if (tapisIsOn)
  {
    shape(lumiereverte, 65, 480, 200, 150);//lumiére verte machine ouverte
  } else
  { 
    shape(lumiererouge, 65, 480, 200, 150);//lumiére rouge machine fermé
  }
  popMatrix();
}


//
//
//BrasMechanique

void BoutonBrasMechanique()
{
  pushMatrix();
  stroke(#000000);
  strokeWeight(2);
  fill(112, 108, 105);
  triangleOneX = NewBoutonPosAfterMove(triangleOneX, brasMove);
  triangleTwoX = NewBoutonPosAfterMove(triangleTwoX, brasMove);
  triangle(triangleOneX.x, triangleY.x, triangleOneX.y, triangleY.y, triangleOneX.z, triangleY.z);
  triangle(triangleTwoX.x, triangleY.x, triangleTwoX.y, triangleY.y, triangleTwoX.z, triangleY.z);
  fill(200, 0, 0);
  redRectPos.x = triangleOneX.z;
  rect(redRectPos.x, redRectPos.y, redRectSize.x, redRectSize.y);
  popMatrix();
}

void BrasMechanique()
{
  //-------- animation bras mecanique chariot

  pushMatrix();

  brasPos.x += brasMove;
  chariotPos.x += brasMove;
  shape(brasmecanique, brasPos.x, brasPos.y + 52, brasSize.x, brasSize.y);
  shape(chariot, chariotPos.x, chariotPos.y, chariotSize.x, chariotSize.y);// chariot du portique
  BoutonBrasMechanique();
  if (chariotPos.x >= 1400 || chariotPos.x <= chariotOrgPosX)
  {
    brasMove = 0;
  }
  popMatrix();
}

PVector NewBoutonPosAfterMove(PVector baseVector, float moveValue)
{
  PVector newVector = baseVector;
  newVector.x += moveValue;
  newVector.y += moveValue;
  newVector.z += moveValue;
  return newVector;
}

// Controle

void mousePressed()
{
  if (mouseButton == LEFT && MouseSquareCollider(boutonActivePos, boutonSize))
  {
    tapisIsOn = !tapisIsOn;
    if (boutonActivePos == boutonOnPos)
    {
      boutonActivePos = boutonOffPos;
      redButon = color(255, 0, 0);
      greenButon = color(0, 100, 0);
    } else
    {
      boutonActivePos = boutonOnPos;
      redButon = color(100, 0, 0);
      greenButon = color(0, 255, 0);
    }
  }

  if (mouseButton == LEFT  && MouseSquareCollider(new PVector(triangleOneX.x - 16, triangleY.z - 15), triangleSize))
  {
    if (brasMove != -15 && chariotPos.x > chariotOrgPosX)
    {
      brasMove = -brasMoveSpeed;
      portique.trigger();//audio
    }
  } else if (mouseButton == LEFT && MouseSquareCollider(new PVector(triangleTwoX.y - 16, triangleY.z - 15), triangleSize))
  {
    if (brasMove != 15 && chariotPos.x < 1400)
    {
      brasMove = brasMoveSpeed;
      portique.trigger();//audio
    }
  } else if (mouseButton == LEFT  && RedButonCollider(redRectPos, redRectSize))
  {
    brasMove = 0;
    if (chariotPos.x >= 1400 && brasCanMoveBox)
    {
      dropTheBox = true;
      brasCanMoveBox = false;
      rangeboite.trigger();//audio
    }
  }
}

//Detection si la souris est dans une zone interactif

boolean MouseSquareCollider(PVector basePos, PVector size)
{
  if (mouseX >= basePos.x - size.x/2 &&
    mouseX <= basePos.x + size.x/2 &&
    mouseY <= basePos.y + size.y/2 &&
    mouseY >= basePos.y - size.y/2)
  {
    return true;
  } else { 
    return false;
  }
}

boolean RedButonCollider(PVector basePos, PVector size)
{
  if (mouseX >= basePos.x &&
    mouseX <= basePos.x + size.x &&
    mouseY >= basePos.y + size.y &&
    mouseY <= basePos.y)
  {
    return true;
  } else { 
    return false;
  }
}

void SonAmbiant()
{
  if (tapisIsOn)
  {
    machineon.trigger();//*****************************************
    bruitagetapis.trigger();//*****************************************
    bruitagemachine.trigger();//*****************************************
  } else
  {
    machineon.stop();//*****************************************************
    bruitagetapis.stop();//**************************************************
    bruitagemachine.stop();//********************************
  }

  if (currentPosBoite.x >=645 && currentPosBoite.x <= 660) 
  { 
    bruitsourd.trigger();//*****************************************
  }
}
// fin

/*
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
 
 boolean boutonOffOver(int x, int y, int diameter) 
 {
 float disX = x - mouseX;
 float disY = y - mouseY;
 if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
 return true;
 
 
 } else {
 return false;
 }
 }
 
 
 */
