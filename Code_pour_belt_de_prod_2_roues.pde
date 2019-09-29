PVector p3 = new PVector(200, 0, 00);
PVector p4 = new PVector(800, 0, 00);
void setup()
{
  size(1500, 900);
  background(140,205,233);
}
void draw(){
  scale(1.0f, -1.0f);
  stroke(155, 102, 0);
  translate(200,-800);
  arc(p3.x, p3.y,height / 10.0f,height / 10.0f,0.0f,radians(360.0f));  
  arc(p4.x, p4.y,height / 10.0f,height / 10.0f,0.0f,radians(360.0f));    
  strokeWeight(5); 
  stroke(74, 74, 74); 
   if (frameCount % 2 == 0)
    fill(224, 224, 224);
    pushMatrix();
 //position moteur 1
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
  line(200,height / 20.0f,800,height / 20.0f); 
  line(200,-height / 20.0f,800,-height / 20.0f);   
}   
