class PTimer {
  int callbackTime;
  boolean active;

  public PTimer() {
    active = false;
  }

  void callIn(int ms) {
    callbackTime = millis() + ms;
    active = true;
  }
  
  void cancel() {
     active = false; 
  }

  void checkTime() {
    if (active && millis() > callbackTime) {
      active = false;
      callback();
    }
  }
}

