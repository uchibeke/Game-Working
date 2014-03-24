Stick stick1, stick2;
Timer timer;
String s = "Welcome to the AliOne Random Game";


void setup () {
  size (1000, 400);
  background(0,0,255);
  stick1 = new Stick ();
  stick2 = new Stick ();
  timer = new Timer(2000);
  textSize(32);
  text( s, width/4, height/2);
  

  timer.start();
}

void draw () {
  //        stickX = int(random(25, width - 25));
  //      stickY = int(random(25, height/2 - 25));
  //
  //      stickX = int(random(25, width - 25));
  //    stickY = int(random(25, height/2 - 25));
  //  stick1.showStick();
  //  stick2.showStick();

  if (timer.isFinished()) {
    {
      stick1.changePosition();

    }

    {

      stick2.changePosition();
    }
    timer.start();
  }}

