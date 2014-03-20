public class Stick {
  float stickX;
  float stickY;

  //constructor
  public Stick () {
    stickX= int(random(25, width - 25));
    stickY = int(random(25, height/2 - 25));
  }

  void showStick () {
    fill(0);
    smooth();
    ellipse(stickX, stickY, 50, 50);
  }
  
  void changePosition () {
    
    
  }
}

