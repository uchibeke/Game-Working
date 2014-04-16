public class Stick {
  float stickX;
  float stickY;
  float objectSize;
  float distance;

  boolean hidden;

  int t = 3000;

  public Stick (float x, float y, float w) {
    stickX = x;
    stickY = y;
    objectSize = w;
    hidden = false;
  }

  void changePosition () {

    hidden = false;
    fill(0);
    smooth();
    stickX = random(50, width - 50);
    stickY = random(50, height/2 - 50);
  }
  
  void drawStick()
  {
    if(hidden == false)
    {
      smooth();
      strokeWeight(3);
      stroke(palette[6]);
      fill(palette[5]);
      ellipse(stickX, stickY, objectSize, objectSize);
    }
    

  }

  void checkClick () {
    float distance = ((height/2) + ((height/2) - stickY)) ;

    if ( dist(mouseX,  mouseY, stickX, distance ) < objectSize/2  && hidden == false) {
      //200 - stickY
      stickScore++;
      stickCorrect.trigger();
      hidden = true;
    }
  }
}


