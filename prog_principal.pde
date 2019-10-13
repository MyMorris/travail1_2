// TP1 prog principal 2019
// Nancy Dodier, Pierre Sévigny, Myriam Morris, David Martin, Jean-Philippe Dufour

// images fixe machine,ecran,distributeur
String file = "background photo.jpg";//  background 
 PImage img;// background
PShape bouton;//SVG machine
PShape distributeur; //SVG distributeur
PShape ecran; // SVG ecran de controle

// images en mouvement ou animé------------------
PShape chariot; // chariot
//PShape boite;// boite
//PShape boite support;// support 
//PShape gyroscopeon; //gryroscope allume
PShape gyroscopeoff;
//PShape lumier rouge;
//PShape lumiere verte


//------tapis roulant-------------------
  PVector p3 = new PVector(200, 0, 00);
PVector p4 = new PVector(800, 0, 00);

//-----------------------------------------------------------------

void setup() {
 size(1920,1080); // full hd
 
 // --------affichage image fixe-----------
 bouton = loadShape("bouton (1).svg");//SVG machine
 distributeur = loadShape("distributeur.svg");//SVG distributeur
 ecran = loadShape("ecran.svg");//SVG ecran de controle
 
 //---------affichage image mouvement -------
 chariot= loadShape("chariot portique.svg");
 gyroscopeoff= loadShape("gyroscope off.svg");
// gyroscopeon= loadShape("gyroscope on.svg");
 }
 
 //----------------------------------------------------------------
 
 void draw()
{

imageMode(CORNER);//  background
img= loadImage("background photo.jpg");
image(img, 0, 0, width , height);//fin background

shape(bouton, -450, 400, 1200, 800);//SVG machine
 shape(distributeur,150,10,1500,900);//SVG distributeur
 shape(ecran,10,-350,700,700);// ecran de controle
 
 //-------support avant et arriere tapis roulant
 fill (74,187,183);// couleur bleu moodboard
 rect (1250,900,150,100);// support arriere
 rect (387,900,130,100); // support avant
 
 //-------chariot portique-----
  fill (112,108,105);//couleur portique gris moonboard
  rect (1200,510,750,60);// portique 
  shape(chariot,900,500,850,200);// chariot du portique
  
  //--------gyroscope-------
 
  shape(gyroscopeoff,642,290,200,200);//gyroscope off
  //shape(gyroscopeon,642,290,200,200);//gyroscope on
  
  
//--------tapis roulant ----------------
  Pontroulant();
  AnimPontRoulant();
 
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

  
 

  
 
