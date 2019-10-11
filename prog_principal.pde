// TP1 prog principal 2019
// Nancy Dodier, Pierre Sévigny, Myriam Morris, David Martin, Jean-Philippe Dufour


String file = "background photo.jpg";//  background  david
 PImage img;// background
PShape bouton;//SVG machine
PShape distributeur; //SVG distributeur



void setup() {
 size(1920,1080); // full hd
 bouton = loadShape("bouton (1).svg");//SVG machine
 distributeur = loadShape("distributeur.svg");//SVG distributeur


 }
 
 
 void draw()
{

imageMode(CORNER);//  background
img= loadImage("background photo.jpg");
image(img, 0, 0, width , height);//fin background
shapeMode(CORNER);
 shape(bouton, -450, 400, 1200, 800);//SVG machine
 shape(distributeur,150,10,1500,900);//SVG distributeur
 
 
}
 
// fin
