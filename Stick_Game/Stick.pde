public class Stick {
  float stickX;
  float stickY;
  int score;
  int m;
  int t = 2000;
  boolean checkTime = false;


  //constructor
  public Stick () {
    stickX= int(random(25, width - 25));
    stickY = int(random(25, height/2 - 25));
    score = 0;
  }

  void showStick () {
    fill(0);
    smooth();
    ellipse(stickX, stickY, 50, 50);
    checkTime = true;
    m = millis();
  }

  void changePosition () {
    if (checkTime == true) {
      smooth();
      ellipse(stickX, stickY, 50, 50);
      m = m + t ;
      
    }}

    //    for (int duration = 100; duration = millis(); duration = duration +1) { 
    //    if duration = millis() {
    //      redraw();
  }

//  void giveScore () {
//    if ( (mouseY >= (height/2) + ((height/2) - stickY))) || mouseY <=   (10 + ((mouseY = (height/2) + ((height/2) - stickY)))) mouseY >=   (10 - ((mouseY = (height/2) + ((height/2) - stickY)))) {
//      score ++;
//    }
//  }





