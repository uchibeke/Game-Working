public class Hero

{
  int x;
  int y;
  int r;
  int dx, dy;

  public Hero()
  {
    x = 300;
    y = 475;
    r = 50;
    dx = 0;
    dy = 0;
  }

  void drawHero()
  {
    fill(0);
    noStroke();
    ellipse(x, y, r, r);
    x = x + dx;
  } 

  void moveLeft()
  {
    dx = -3;
  }
  void moveRight()
  {
    dx = 3;
  }
}

