PShape distributeur;

void setup(){
size(1280, 1024);
distributeur=loadShape("distributeur.svg");
}
void draw(){
  background(#ffffff);
  brasmecanique();
  gyroscope();
   boite();
   boiteSupport();
   bouton();
   chariot();
   shape(distributeur,300, 150,600,500);
}

void brasmecanique(){
  pushMatrix();
  translate(50,350);
  noStroke();
  fill(112, 108, 105);
  rect(510,200,80,10);
  rect(525,190,50,10);
  rect(545,80,10,110);
  popMatrix();
}
void gyroscope(){
noStroke();
fill(246, 130, 103);
stroke(0, 0, 0);
strokeWeight(3);
beginShape();
vertex(204.2, 260.4);
vertex(204.2, 206.8);
bezierVertex(204.2, 184.3, 221, 166.1, 241.8, 166.1);
vertex(258.3, 166.1);
bezierVertex(279.1, 166.1, 295.9, 184.3, 295.9, 206.8);
vertex(295.9, 260.4);
endShape();
noStroke();
fill(65, 61, 60);
rect(202.8, 260, 94.5, 29.1);
}
void boite(){
  pushMatrix();
  scale(0.5);
  textSize(32);
  text("boite", 113, 150); 
  noStroke();
  fill(204, 203, 74);
  stroke(0, 0, 0);
  rect(113, 150.4, 266.7, 177.8);
  noStroke();
  fill(112, 108, 105);
  stroke(0, 0, 0);
  rect(125, 282.2, 45, 35, 11);
  rect(177.4, 282.2, 29.6, 34.1);
  noStroke();
  fill(252, 252, 252);
  stroke(0, 0, 0);
  rect(127, 236.3, 53.3, 20);
  noStroke();
  fill(252, 252, 252);
  stroke(0, 0, 0);
  rect(293.7, 178.5, 68.9, 19.3);
  noStroke();
  fill(238, 81, 72);
  stroke(0, 0, 0);
  rect(233, 150.4, 30.4, 58.5);
  popMatrix();
}

void boiteSupport(){
  pushMatrix();
  scale(0.5);
  translate(700,0);
  textSize(32);
text("boiteSupport", 542, 320); 
noStroke();
fill(74, 187, 183);
rect(542, 320, 196, 80);
popMatrix();
}

void bouton(){
  pushMatrix();
  scale(0.5);
  translate(-350,1000);
  noStroke();
  fill(238, 81, 72);
  ellipse(640,90, 100, 110);
  rect(605,110,70,30);
  fill(0);
  noFill();
  stroke(234, 127, 127);
  strokeWeight(5);
  beginShape();
  vertex(625, 94.1);
  bezierVertex(627.6, 93.2, 629.2, 94, 629.8, 96.6);
  bezierVertex(632.6, 100.3, 635, 100.7, 636.9, 96.6);
  bezierVertex(639.5, 93.1, 641.9, 92.4, 644, 96.6);
  bezierVertex(646.5, 100, 648.9, 101, 650.9, 96.6);
  bezierVertex(651.9, 93.4, 653.5, 92.8, 655.5, 94.1);
  endShape();
  noStroke();
  fill(112, 108, 105);
  rect(599.5, 135.8, 81.2, 27.8);
  fill(74, 187, 183);
  rect(532.6, 163.6, 214.8, 372.6);
  rect(743.1, 393.2, 142.2, 143);
  fill(21, 104, 51);
  ellipse(640.1, 303.4, 26.6, 26.6);
  fill(181, 54, 51);
  ellipse(640, 386.6, 26.6, 26.6);
  popMatrix();
}
void chariot(){
  pushMatrix();
  scale(0.5);
  translate(1000,800);
  text("chariot", 748, 419);
  noStroke();
  fill(74, 187, 183);
  stroke(0, 0, 0);
  rect(748.5, 419.8, 415.4, 242.3);
  fill(112, 108, 105);
  rect(913.8, 489, 84.6, 101.9);
  triangle(878.4,489.6,793.7,534.8,878.4,590.9);
  triangle(1034.3,590.6,1034.3,488.7,1118.9,539.8);
  noStroke();
  fill(74, 187, 183);
  stroke(0, 0, 0);
  rect(801.3, 661.2, 315.1, 65.9);
  popMatrix();
}
