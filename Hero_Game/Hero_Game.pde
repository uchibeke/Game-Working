Hero adam;
boolean walkLeft;
boolean walkRight;
boolean jump;
boolean onGround;

void setup()
{

  adam = new Hero();
  size(600, 600);
}

void draw()
{
  background(255);
  adam.drawHero();
    adam.x += adam.dx;
  adam.y += adam.dy;
  
}

void keyPressed() {
 
 {
  if (key == CODED) {
     if(keyCode == LEFT )
    {
       adam.moveLeft(); 
    
       
    }
    else if(keyCode == RIGHT )
    {
       adam.moveRight(); 
     
    }
  }
}
}


void keyReleased() {
  adam.dx = 0;
  adam.dy = 0;
}

