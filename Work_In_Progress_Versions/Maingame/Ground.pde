public class Ground
{

color groundC;
color troundC;
color broundC;

  int groundX, groundY, lengthG, heightG;
  
  public Ground()
  {
    groundC = color(0,200,30);
    troundC = color(200,200,55);
    broundC = color(55,0,200);
    groundX = 0;
    groundY = 500;
    lengthG = 500;
    heightG = 100;
  }

  void drawGround()
  {
    fill(groundC);
    rect(groundX, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  
   void drawTround()
  {
    fill(troundC);
    rect(groundX + lengthG, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  
   void drawBround()
  {
    fill(broundC);
    rect(groundX + 2*lengthG, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  

}


