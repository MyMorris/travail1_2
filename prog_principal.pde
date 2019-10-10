// TP1 prog principal


// affichage background  david
String file = "background photo.jpg";
 PImage img;
// fin



void setup() {
 size(1920,1080); // full hd
 }
 
 
 void draw()
{
 // affichage background   david
imageMode(CORNER);
img= loadImage("background photo.jpg");
image(img, 0, 0, width , height);
// fin

  
 
}
  
 
