public class Ground
{

color groundC;
color troundC;
color broundC;

  int groundX, groundY, lengthG, heightG;
  
  public Ground()
  {
    groundC = color(palette[6]);
    troundC = color(palette[5]);
    broundC = color(palette[4]);
    groundX = 0;
    groundY = 500;
    lengthG = 500;
    heightG = 100;
  }

  void drawGround()
  {
    smooth();
    fill(groundC);
    rect(groundX, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  
   void drawTround()
  {
    smooth();
    fill(troundC);
    rect(groundX + lengthG, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  
   void drawBround()
  {
    smooth();
    fill(broundC);
    rect(groundX + 2*lengthG, groundY, lengthG, heightG);
    if(walkLeft = true)
    groundX = groundX + objectdx;
    if(walkRight = true)
    groundX = groundX + objectdx;
  }
  

}

