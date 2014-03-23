public class Ground
{
  int groundX, groundY, lengthG, heightG;
  
  public Ground()
  {
    groundX = 0;
    groundY = 500;
    lengthG = 2000;
    heightG = 100;
  }

  void drawGround()
  {
    fill(0, 200, 30);
    rect(groundX, groundY, lengthG, heightG);
  }
}



