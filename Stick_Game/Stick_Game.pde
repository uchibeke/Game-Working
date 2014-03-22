Stick stick1, stick2;
PTimer timer;

void setup () {
  size (1000, 400);
  stick1 = new Stick ();
  stick2 = new Stick ();
  timer = new PTimer ();
  timer.callIn(1000);
  
}


void draw () {
  background(#8E0A0A);
  stroke(0);
  line(0, height/2, width, height/2);
  stick1.showStick();
  stick2.showStick();
  stick1.changePosition();
  stick2.changePosition();
  timer.checkTime();
   
    }
void callback () {
  stick1.showStick();
  stick2.showStick();
  timer.callIn(500);
}    


    
    

  
  



