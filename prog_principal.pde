// TP1 prog principal 2019
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
//PShape boite;// boite
//PShape boite support;// support 
//PShape gyroscopeon; //gryroscope allume
PShape gyroscopeoff; // gyroscope eteind
//PShape lumierrouge;//lumiére rouge
PShape lumiereverte; //lumiére verte
PShape brasmecanique;// bras mecanique


//------tapis roulant-------------------
PVector p3 = new PVector(200, 0, 00);
PVector p4 = new PVector(800, 0, 00);

//-----------------------------------------------------------------

void setup() {

 policeONOFF = loadFont("ArialMT-45.vlw");  //Police de caractère pour le bouton ON/OFF (
 policeMoniteur = loadFont("Georgia-20.vlw");  //Police de caractère pour le moniteur
 
 size(1920,1080); // full hd
 img= loadImage("background_photo.jpg"); //load background-image 
 frameRate(30); // 30 images seconde
 
 
 // --------affichage image fixe-----------
 machine = loadShape("machine.svg");//SVG machine

 distributeur = loadShape("distributeur.svg");//SVG distributeur
 ecran = loadShape("ecran.svg");//SVG ecran de controle
 
 //---------affichage image mouvement -------
 chariot= loadShape("chariot portique.svg");
 
 //--------affichage image animé------------
 lumiereverte= loadShape("lumiere verte.svg");// lumiere machine on
// lumiererouge= loadShape("lumiere rouge.svg");// lumiere machine off
 
 gyroscopeoff= loadShape("gyroscope off.svg"); 
// gyroscopeon= loadShape("gyroscope on.svg");

//--------affichage bras mecanique---------

brasmecanique= loadShape("bras mecanique.svg");

//----------affichage video--------------
video = new Movie(this, "video surveillance.mov");
video.frameRate(30);
video.loop();
 }
 
 //----------------------------------------------------------------
 
 void draw()
{
imageMode(CORNER);//  background

tint(50);
image(img, 0, 0, width , height);
filter(GRAY);//fin background

 //-------support avant et arriere tapis roulant
 fill (74,187,183);// couleur bleu moodboard
 rect (1250,900,150,100);// support arriere
 rect (387,900,130,100); // support avant
 
 //-------chariot portique-----
  fill (112,108,105);//couleur portique gris moonboard
  rect (1200,480,750,60);// portique 
  
  shape(chariot,900,400,850,300);// chariot du portique
  
  //--------gyroscope-------
  shape(gyroscopeoff,642,290,200,200);//gyroscope off
  //shape(gyroscopeon,642,290,200,200);//gyroscope on
  
  //-------lumiére rouge-----------
  shape(lumiereverte,64,483,200,150);//lumiére verte machine ouverte
 // shape(lumiereverte,64,483,200,150);//lumiére rouge machine fermé
 
 //---------animation bras mecanique-----
 
 shape(brasmecanique,309,100,1200,1400);
 
 //----- Machine -------
 shape(machine, -450, 400, 1200, 800);
 //-------- Distributeur -----
 shape(distributeur,150,10,1500,900);
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
//textSize(45);
fill(65, 61, 60);
text("ON", 122, 660); 
text("OFF", 110, 800); 
  
//--------tapis roulant ----------------
  Pontroulant();
  AnimPontRoulant();

 
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

  
 

  
 
