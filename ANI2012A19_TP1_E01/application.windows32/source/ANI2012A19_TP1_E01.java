import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Iterator; 
import processing.video.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ANI2012A19_TP1_E01 extends PApplet {

// TP1 prog principal 2019
// Nancy Dodier, Jean-Philippe Dufour, David Martin Pierre Sévigny



// images fixe machine,ecran,distributeur

String file = "background Photo.jpg";//  background 
PImage img;// background
PShape machine;//SVG machine
PShape distributeur; //SVG distributeur
PShape ecran; // SVG ecran de controle
PShape affichage;// SVG panneau affichage
// video---------------------------


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


Minim minim;
AudioSample machineon;
AudioSample bruitagetapis;
AudioSample bruitagemachine;
AudioSample bruitsourd;
AudioSample portique;
AudioSample rangeboite;
AudioSample manette;
AudioSample manette2;
AudioSample approuve;
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
int greenButon = color(0, 255, 0);
int redButon =   color(100, 0, 0);

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

// Particule
int count = 500;
int colorBack = 0;
int type;
ParticleSystem ps3;
int son;


public void setup() {
     // full hd
  img= loadImage("background_photo.jpg"); //load background-image 
  frameRate(30); // 30 images seconde
  ess=1;
  bouge=480;
  bras=50;
  tmpo = 0;
  currentVitesseY = orgVitesseY;
  vitesseX=20;
  chariotOrgPosX = chariotPos.x;

  policeONOFF = loadFont("ArialMT-45.vlw");  //Police de caractère pour le bouton ON/OFF (
  policeMoniteur = loadFont("Georgia-20.vlw");  //Police de caractère pour le moniteur
  son=1;

  // --------affichage image fixe-----------

  machine = loadShape("machine.svg");//SVG machine
  distributeur = loadShape("distributeur.svg");//SVG distributeur
  ecran = loadShape("ecran.svg");//SVG ecran de controle
  affichage = loadShape("affichage.svg");//panneau affichage
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
  approuve= minim.loadSample("approuve.mp3");
  //----typo
  f=createFont("Lato-Regular.ttf", 20);
  
  //Particule
    type = ParticleSystem.PARTICLE_TYPE_SNOW;
  ps3 = new ParticleSystem(count, type);

}

//******************************************

public void draw() {

  pushMatrix();
  imageMode(CORNER);//  background
  tint(90);
  image(img, 0, 0, width, height);
  filter(GRAY);

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
    poussiere();
  }
  if (bouge==380) {
    bras=bras-15;
  }
  if (bras<-150) {
    bras=-150;
  }  
  if (bras>120) {
    bras=120;
    poussiere();
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
    poussiere();
    bouge=480;
    touche=1;
  } else {
    bouge=380;
    touche=0;
  }

  //-------- Écran de controle -------
  shape(ecran, 10, -350, 700, 700);

    //--------panneau d'affichage-------
  shape(affichage, 1300, 60, 500, 600);// affichage panneau

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
  fill(0xffFFD52E);
  text("Production #", width/1.51f, height/1.155f);
  textFont(f);
  fill(0xffE82D2C);
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
  //fumee();
}

// Called every time a new frame is available to read

public void movieEvent(Movie m) {
  m.read();
}

// Boite

public void Boite()
{
  pushMatrix();
  shape(boite, currentPosBoite.x, currentPosBoite.y, 250, 250);
  BoiteMouvement();
  popMatrix();
}

public void BoiteMouvement() 
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
      son=1;
    }
  } else
  {

    if (currentPosBoite.x <= 1180 && tapisIsOn)
    {
     currentPosBoite.x += vitesseX;
      textFont(f);
      son=1;
      fill(238, 81, 72);
      textSize(50);
      text("ATTENTION", 1407, 390);
    } else if (brasCanMoveBox)
    {
      textFont(f);
      fill(70, 200, 121);
      textSize(50);
     text("APPROUVÉE", 1400,390);
      if (son==1){
      approuve.trigger();
      son=0;
     }
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
public void Pontroulant() 
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

public void AnimPontRoulant() {

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

public void Moteur(float x, float speed)
{
  pushMatrix();
  translate(x, p3.y);
  rotate(radians(-frameCount * speed % 360));
  rect((height / 22.0f)*-1, -1, height / 11.0f, 2);
  rect(-1, (height / 22.0f)*-1, 2, height / 11.0f);
  popMatrix();
}

public void BoutonOnOff()
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

public void LumiereMarche()
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

public void BoutonBrasMechanique()
{
  pushMatrix();
  stroke(0xff000000);
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

public void BrasMechanique()
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

public PVector NewBoutonPosAfterMove(PVector baseVector, float moveValue)
{
  PVector newVector = baseVector;
  newVector.x += moveValue;
  newVector.y += moveValue;
  newVector.z += moveValue;
  return newVector;
}

// Controle

public void mousePressed()
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

public boolean MouseSquareCollider(PVector basePos, PVector size)
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

public boolean RedButonCollider(PVector basePos, PVector size)
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

public void SonAmbiant()
{
  if (tapisIsOn)
  {
    machineon.trigger();
    bruitagetapis.trigger();
    bruitagemachine.trigger();
  } else
  {
    machineon.stop();
    bruitagetapis.stop();
    bruitagemachine.stop();
  }

  if (currentPosBoite.x >=645 && currentPosBoite.x <= 660) 
  { 
    bruitsourd.trigger();
  }
}

public void fade(float decay)
{
  rectMode(CORNER);
  noStroke();
  fill(colorBack, decay);
  rect(0, 0, width, height);
}

public void poussiere(){
    fade(32);
    ps3.update();
}
// fin
// ANI2012A19_Particles/Particle.pde
// Classe de type Particle.

class Particle
{
  ParticleSystem ps;

  Vector position;

  int colorDiffuse;

  boolean isExpired;

  float lifetime;

  float timer;

  float timeStart;
  float timeFrame;
  float timeElapsed;
  float timeActive;

  Particle()
  {
    position = new Vector();

    colorDiffuse = 0xffFFFFFF;

    isExpired = true;
  }

  public void setPosition(float x, float y, float z)
  {
    position.x = x;
    position.y = y;
    position.z = z;
  }

  public void randomize(float x, float y, float z)
  {
    position.x = random(0.0f, 1.0f) * x - x / 2.0f;
    position.y = random(0.0f, 1.0f) * y - y / 2.0f;
    position.z = random(0.0f, 1.0f) * z - z / 2.0f;
  }

  public void init()
  {
    isExpired = false;

    timer = 0;
    timeStart = millis();
    timeFrame = timeStart;
    timeActive = 0;
  }

  public void update()
  {
    timeElapsed = (millis() - timeFrame) / 1000.0f;
    timer += timeElapsed;

    if (timer > lifetime)
      isExpired = true;

    timeFrame = millis();
    timeActive = timeFrame - timeStart;
  }

  public void render()
  {
    fill(colorDiffuse, 127);
    ellipse(position.x, position.y, 32, 32);
  }

}
// ANI2012A19_Particles/ParticlePhysic.pde
// Classe de type ParticlePhysic, qui hérite de la classe Particle.

class ParticlePhysic extends Particle
{
  final static float probabilitySpawn = 0.618f;

  Vector force;
  Vector acceleration;
  Vector velocity;
  Vector noise;

  float mass;
  float speed;
  float speedMax;
 
  ParticlePhysic()
  {
    super();

    colorDiffuse = 0xff9900DD;

    lifetime = 5.0f;

    mass = 1.0f;
    speed = 0.0f;
    speedMax = 999.0f;

    force = new Vector(0.0f, 0.0f, 0.0f);
    acceleration = new Vector(0.0f, 0.0f, 0.0f);
    velocity = new Vector(0.0f, 0.0f, 0.0f);
    noise = new Vector(1.0f, 1.0f, 0.0f);
  }

  public void init()
  {
    super.init();

    ps.space.x = width;
    ps.space.y = height;

    position.x = ps.origin.x + random(0.0f, 1.0f) * ps.space.x - ps.space.x / 2.0f;
    position.y = ps.origin.y + random(0.0f, 1.0f) * ps.space.y - ps.space.y / 2.0f;

    force.set(0.0f, 0.0f, 0.0f);
    acceleration.set(0.0f, 0.0f, 0.0f);
    velocity.set(0.0f, 0.0f, 0.0f);
    applyForce(random(-noise.x, noise.x), random(-noise.y, noise.y), 0.0f);
  }

  public void update()
  {
    super.update();

    acceleration.set(
      force.x * timeElapsed,
      force.y * timeElapsed,
      force.z * timeElapsed
    );

    acceleration.divide(mass);

    velocity.add(acceleration);

    if (velocity.magnitude() > speedMax)
    {
      velocity.normalize();
      velocity.scale(speedMax);
    }

    if (position.y < height)
    {
      position.add(velocity);
    }
  }

  public void render()
  {
    fill(colorDiffuse,127);
    ellipse(position.x, position.y, 16, 16);
  }

  public void setVelocity(float x, float y, float z)
  {
    velocity.set(x, y, z);
    speed = velocity.magnitude();
  }

  public void setAcceleration(float x, float y, float z)
  {
    acceleration.set(x, y, z);
    force.copy(acceleration);
    force.multiply(mass);
  }

  public void setForce(float x, float y, float z)
  {
    force.set(x, y, z);
    acceleration.set(force.x, force.y, force.z);
    acceleration.divide(mass);
  }

  public void applyForce(float x, float y, float z)
  {
    force.add(x, y, z);
  }

  public void applyForce(Vector v)
  {
    force.add(v);
  }
}
// ANI2012A19_Particles/ParticleSnow.pde
// Classe de type ParticleSnow, qui hérite de la classe ParticlePhysic.

class ParticleSnow extends ParticlePhysic
{
  final static float probabilitySpawn = 0.618f;

  ParticleSnow()
  {
    super();

    colorDiffuse = 0xffFFFFFF;

    lifetime = 2.0f;

    mass = 1.0f;
    speed = 0.0f;
    speedMax = 5.0f;

    noise.set(0.01f, 0.0f, 0.0f);
  }

  public void init()
  {
    super.init();

    ps.space.x = 50;
    ps.space.y = 32;

    position.x = ps.origin.x + random(0.0f, 1.0f) * ps.space.x  - ps.space.x / 2.0f;
    position.y = ps.origin.y + random(0.0f, 1.0f) * ps.space.y;

    force.set(0.0f, 0.0f, 0.0f);
    acceleration.set(0.0f, 0.0f, 0.0f);
    velocity.set(0.0f, 0.0f, 0.0f);
    applyForce(0.0f, 1.0f, 0.0f);
  }

  public void update()
  {
    applyForce(random(-noise.x, noise.x), 0.0f, 0.0f);
    super.update();
  }

  public void render()
  {
    fill(colorDiffuse, 127);
    ellipse(position.x, position.y, 2, 2);
  }
}
// ANI2012A19_Particles/ParticleSystem.pde
// Classe de type ParticleSystem.

class ParticleSystem
{
  final static int PARTICLE_TYPE_SNOW    = 3;


  int index;

  int count;
  int type;

  int activeParticleCount;

  float timeStart;
  float timeLastFrame;
  float timeElapsed;

  float timeScale = 1.0f;

  float probabilitySpawn;

  ArrayList<Particle> system;

  ArrayList<Particle> particleActive;
  ArrayList<Particle> particleReady;

  Iterator<Particle> iterator;

  Vector space;
  Vector origin;

  Particle particle;

  ParticleSystem()
  {
    count = 10;
    type = PARTICLE_TYPE_SNOW;
    init();
  }

  ParticleSystem(int size, int type)
  {
    count = size;
    this.type = type;
    init();
  }

  public void init()
  {
    system = new ArrayList<Particle>();

    particleActive = new ArrayList<Particle>();
    particleReady = new ArrayList<Particle>();

    origin = new Vector(890, 530, 0.0f);
    space = new Vector();

    for (index = 0; index < count; ++index)
    {
      switch (type)
      {


        case PARTICLE_TYPE_SNOW:
          particle = new ParticleSnow();
          probabilitySpawn = ParticleSnow.probabilitySpawn;
          break;

      }

      particle.ps = this;
      particle.position.copy(origin);

      system.add(particle);
      particleReady.add(particle);
    }

    timeStart = millis();
    timeLastFrame = timeStart;
  }

  public void update()
  {
    timeElapsed = (millis() - timeLastFrame) / 1000.0f;
    timeLastFrame = millis();

    emiter();

    activeParticleCount = particleActive.size();

    if (activeParticleCount > 0)
    {
      for (index = 0; index < particleActive.size(); ++index)
      {
        particle = particleActive.get(index);

        if (!particle.isExpired)
          particle.update();
        else
          recycle(particle);
      }

      iterator = particleActive.iterator();

      while (iterator.hasNext())
      {
        particle = iterator.next();

        if (!particle.isExpired)
          particle.render();
      }
    }
  }

  public void add(float positionX, float positionY)
  {
    if (particleReady.size() > 0)
    {
      particle = particleReady.get(0);

      particle.init();

      particle.position.x = positionX;
      particle.position.y = positionY;

      particleReady.remove(0);
      particleActive.add(particle);
    }
    else
      print("particles system overload");
  }

  public void emiter()
  {
    if (random(0.0f, 1.0f) < probabilitySpawn)
    {
      if (particleReady.size() > 0)
      {
        particle = particleReady.get(0);

        particle.init();

        particleReady.remove(0);
        particleActive.add(particle);
      }
      else
        print("sytem overload");
    }
  }

  public void recycle(Particle p)
  {
    particleActive.remove(p);
    particleReady.add(p);
  }

  public void print(String tag)
  {
    println("particle system " + tag + " (" + particleActive.size() + " " + particleReady.size() + " " + count + ")");
  }
}
// ANI2012A19_Particles/Vector.pde
// Classe de type Vector (vecteur 3D).

class Vector
{
  float x;
  float y;
  float z;

  Vector()
  {
    x = y = z = 0.0f;
  }

  Vector(float valueX, float valueY, float valueZ)
  {
    x = valueX;
    y = valueY;
    z = valueZ;
  }

  public void set(float valueX, float valueY, float valueZ)
  {
    x = valueX;
    y = valueY;
    z = valueZ;
  }

  public void copy(Vector v)
  {
    x = v.x;
    y = v.y;
    z = v.z;
  }

  public Vector clone()
  {
    Vector v = new Vector();

    v.x = x;
    v.y = y;
    v.z = z;

    return v;
  }

  public void randomize(float rangeX, float rangeY, float rangeZ, boolean centered)
  {
    if (centered)
    {
      x = random(0.0f, 1.0f) * rangeX - rangeX / 2.0f;
      y = random(0.0f, 1.0f) * rangeY - rangeY / 2.0f;
      z = random(0.0f, 1.0f) * rangeZ - rangeZ / 2.0f;
    }
    else
    {
      x = random(0.0f, 1.0f) * rangeX;
      y = random(0.0f, 1.0f) * rangeY;
      z = random(0.0f, 1.0f) * rangeZ;
    }
  }

  public void add(float valueX, float valueY, float valueZ)
  {
    x += valueX;
    y += valueY;
    z += valueZ;
  }

  public void add(Vector v)
  {
    x += v.x;
    y += v.y;
    z += v.z;
  }

  public void minus(float valueX, float valueY, float valueZ)
  {
    x -= valueX;
    y -= valueY;
    z -= valueZ;
  }

  public void minus(Vector v)
  {
    x -= v.x;
    y -= v.y;
    z -= v.z;
  }

  public void divide(float value)
  {
    if (value != 0)
    {
      x /= value;
      y /= value;
      z /= value;
    }
  }

  public void multiply(float value)
  {
    x *= value;
    y *= value;
    z *= value;
  }

  public void factor(float valueX, float valueY, float valueZ)
  {
    x *= valueX;
    y *= valueY;
    z *= valueZ;
  }

  public float magnitude()
  {
    return sqrt(x * x + y * y + z * z);
  }

  public float distance(Vector v)
  {
    float deltaX = v.x - x;
    float deltaY = v.y - y;
    float deltaZ = v.z - z;

    return sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);
  }

  public void normalize()
  {
    float length = magnitude();

    if (length > 0)
      divide(length);
  }

  public void scale(float length)
  {
    normalize();
    multiply(length);
  }

  public boolean isNull()
  {
    return x == 0 && y == 0 && z == 0;
  }

  public void rotateZ(float angle)
  {
    float tmp = x;
    x = x   * cos(angle) - y * sin(angle);
    y = tmp * sin(angle) + y * cos(angle);
  }

  public float angleBetween(Vector v)
  {
    if (isNull() || v.isNull())
      return 0;

    float phi = magnitude() * v.magnitude();
    float theta = dot(v);

    theta /= phi;

    return acos(theta);
  }

  public float heading()
  {
    return atan2(y, x);
  }

  public float dot(Vector v)
  {
    return x * v.x + y * v.y + z * v.z;
  }

  public Vector cross(Vector v)
  {
    Vector u = new Vector();

    u.x = y * v.z - z * v.y;
    u.y = z * v.x - x * v.z;
    u.z = x * v.y - y * v.x;

    return u;
  }

  public void print(String tag)
  {
    println(tag + " = (" + x + " " + y + " " + z +")");
  }
}
  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ANI2012A19_TP1_E01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
