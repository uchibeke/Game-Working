Stick stick1, stick2;
Timer timer;

void setup () {
  size (1000, 400);
  stick1 = new Stick ();
  stick2 = new Stick ();
  timer = new Timer(5000);

  timer.start();
}

void draw () {
  stick1.showStick();
  stick2.showStick();

  if (timer.isFinished()) {
    stick1.changePosition();
    stick2.changePosition();
    timer.start();
  }
}

