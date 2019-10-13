// TP1 prog principal 2019
// Nancy Dodier, Pierre Sévigny, Myriam Morris, David Martin, Jean-Philippe Dufour

// images fixe machine,ecran,distributeur
String file = "background photo.jpg";//  background  david
 PImage img;// background
PShape bouton;//SVG machine
PShape distributeur; //SVG distributeur
PShape ecran; // SVG ecran de controle

// images en mouvement------------------


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
