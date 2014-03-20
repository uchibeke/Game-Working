

class  Hero

{

  Hero () {
    int x = 400;
    int y = 400;
    int r = 50;
  }

  void drawHero()
  {
    smooth();
    fill(148, 0, 211);
    ellipse(x, y, r, r);
  }
}

/* moveLeft()
 {
 x=x+1;
 }
 moveRight()
 {
 x=x-1;
 }
 
 
 }*/

