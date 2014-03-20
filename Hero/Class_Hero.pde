
Hero hero;




void setup()
{
  size(800,600);
  
  hero = new Hero();

  
}

void draw()
{
background(0);

hero.drawHero();



  

}


/*void keyPressed()
{
  if (key == CODED) {
    if (keyCode == LEFT) {
  hero.moveLeft();
  
  if(keyPressed == RIGHT)
  hero.moveRight();
}
