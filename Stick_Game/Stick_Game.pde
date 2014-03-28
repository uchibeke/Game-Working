//RanClick Mini Game

//We have the main mecahnics done. We had a challenge getting the click function
//We have are still working on implementing the mechanic of the agme game accepting clicks
//and chnaging score.

//initializations of variables
Stick stick1, stick2, stick3, stick4, stick5 ;
//Timer timer;
String s;

int score;
int br, bg, bb;
boolean start;

int m;
int startTime;

int errorY, errorX;

void setup () {
  size (1000, 400);
  //timer = new Timer(2000);
  s = "Click on the opposite side to transfer life";
  startTime = 2000;

  br = int(random(0, 100));
  bg = int(random(100, 200));
  bb = int(random(200, 255));
  
  errorY = -1000;
  errorX = -1000;
  
  start = false;

  stick1 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick2 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick3 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick4 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick5 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  
  //timer.start();
}

void draw () {
  background(br, bg, bb);
  
  m = millis();
  
  if(start == false)
  {
//    println("here");
    textSize(32);
    text( s, width/4, height/2);
  }
  else
  {//println("else");
    String score1 = "Your score is : " + score;

    text(score1, 50, 40);
    strokeWeight(5);
    stroke(0);
    line(0, height/2, width, height/2);
  }

  if (m > startTime)//timer.isFinished()) 
  {
    
    startTime = m + 2000;
    start = true;
    smooth();
    
    br = int(random(0, 100));
    bg = int(random(100, 200));
    bb = int(random(200, 255));
    
    stick1.changePosition() ;

    stick2.changePosition();

    stick3.changePosition();

    stick4.changePosition();

    stick5.changePosition();
    }
    stick1.drawStick();
    stick2.drawStick();
    stick3.drawStick();
    stick4.drawStick();
    stick5.drawStick();
    
    stroke(255, 0, 0);
    noFill();
    ellipse(errorX, errorY, 50, 50);
}

void mouseClicked () {
   stick1.checkClick() ;

    stick2.checkClick();

    stick3.checkClick();

    stick4.checkClick();

    stick5.checkClick();
    
    errorX = mouseX;
    errorY = height-mouseY;
}

 
 
//Use if(dist(x,y, OGx, OGy)) 

//Use this to model the distance between mouseX, mouseY and then the stickX and stickY)


