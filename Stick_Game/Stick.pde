public class Stick {
  float stickX;
  float stickY;
  int score;

  int t = 3000;

  //constructor
  public Stick ( ) {
    //    stickX = int(random(25, width - 25));
    //    stickY = int(random(25, height/2 - 25));
    score = 0;
  }

  void showStick () {
    stickX = int(random(25, width - 25));
    stickY = int(random(25, height/2 - 25));
    background(255);
    strokeWeight(5);
    line(0, height/2, width, height/2);
    fill(0);
    smooth();
    ellipse(stickX, stickY, 50, 50);
  }

  void changePosition () {
//
//    //    if (timer.isFinished()) {
    stickX = int(random(25, width - 25));
    stickY = int(random(25, height/2 - 25));
    background(0, 255, 0);
    strokeWeight(5);
    line(0, height/2, width, height/2);
    fill(0);
    smooth();
    ellipse(stickX, stickY, 50, 50);
    //      timer.start();
    //    }
  }
}




//  void giveScore () {
//    if ( (mouseY >= (height/2) + ((height/2) - stickY))) || mouseY <=   (10 + ((mouseY = (height/2) + ((height/2) - stickY)))) mouseY >=   (10 - ((mouseY = (height/2) + ((height/2) - stickY)))) {
//      score ++;
//    }
//  }

