Hero adam;
Ground ground;
Ground tround;
Ground bround;
boolean walkLeft;
boolean walkRight;
boolean jump;
boolean onGround;
int objectdx;
boolean jumping;
boolean onObject;



void setup()
{
ground = new Ground();
adam = new Hero();
tround = new Ground();
bround = new Ground();


  size(600, 600);
}

void draw()
{
  background(255);
  adam.drawHero();
  ground.drawGround();
  tround.drawTround();
  bround.drawBround();
 
  
}

void keyPressed() {
 
 {
  if (key == CODED) {
     if(keyCode == LEFT )
    {
       walkLeft = true;
       objectdx = 3;
    
       
    }
    else if(keyCode == RIGHT )
    {
      walkRight = true; 
      objectdx = -3;
     
    }
    else if(keyCode == UP )
      jumping = true;
  }
}
}


void keyReleased() {
  objectdx = 0;
  jumping = false;
  adam.dy = 0;
}





