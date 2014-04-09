//Nobody Scores 40 Mini Game

//We have the main mecahnics done. We had a challenge getting the click function
//We have are still working on implementing the mechanic of the agme game accepting clicks
//and chnaging score.

//initializations of variables
import ddf.minim.*;
Minim minim;
AudioPlayer[] player = new AudioPlayer[1];

PImage stick; 

AudioSample correct;
AudioSample incorrect;

Stick stick1, stick2, stick3, stick4, stick5 ;
//Timer timer;
String s, inst, chal;

int score;
int br, bg, bb;

int textColorR, textColorG, textColorB;

boolean start;


int m;
int startTime;

int errorY, errorX;

int screenWidth;
int screenHeight;


void setup () {
  screenWidth = 1800;
  screenHeight =  600;
  size (screenWidth, screenHeight);
  s = "Accuracy and speed are key winning. Show 'em what You've got..." ;
  chal = "Nobody scores 40!";
  inst = "Click on this side of the screen to get objects on opposite the side. Accuracy and Speed are Key!";
  startTime = 6000;

  br = int(random(0, 47));
  bg = int(random(0, 170));
  bb = int(random(0, 7));

  errorY = -1000;
  errorX = -1000;

  start = false;

  stick1 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick2 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick3 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick4 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
  stick5 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);


  minim = new Minim(this); // initialaizing minim object
  player[0] = minim.loadFile("Locally_Sourced.mp3"); // load file in audio player array loadFile ( "FILE NAME");
  println ("song length is approx. " + player[0].length() / 1000 + " s.");

  correct = minim.loadSample( "Correct.mp3", 512  );
  incorrect = minim.loadSample( "Incorrect.mp3", 512 );

  stick = loadImage("Stick.png");
}


void draw () {
  background(br, bg, bb);

  m = millis();

  if (start == false)
  {
    textSize(47);
    text( s, 25, height/2);
    stroke(255, 0, 0);
    textSize(60);
    text( chal, width/3, height/4);
    textSize(30);
    text( inst, width/15, height*0.9);
  }
  else
  {
    strokeWeight(10);
    stroke(#E38007);
    line(0, height/2, width, height/2);
    ellipse(mouseX, mouseY, 50, 50);
  }

  if (m > startTime)
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


  if (start == true && millis()<10000) {
    textSize(20);
    text( inst, width/4, height-10);
  }

  stroke(255, 0, 0);
  noFill();
  ellipse(errorX, errorY, 50, 50);
  textSize(40);
  fill(255 - br, 255 -bg, 255 -bb);
  String score1 = "Score is  " + score;

  text(score1, errorX+25, errorY+25);

  if (!player[0].isPlaying()) {
    player[0].rewind();
    player[0].play();
  }

  if (score >= 5)
  {
    startTime = startTime-5;
  }
  if (score >= 10)
  {
    startTime = startTime-5;
  }
  if (score >= 15)
  {
    startTime = startTime-5;
  }
  if (score >= 20)
  {
    startTime = startTime-10;
  }
  if (score >= 25)
  {
    startTime = startTime-5;
  }
  if (score >= 30)
  {
    startTime = startTime-5;
  }
  if (score >= 35)
  {
    startTime = startTime-5;
  }
  if (score >= 40)
  {
    startTime = startTime-10;
  }
}

void mouseClicked () {
  if (start == true) {
    incorrect.trigger();
    stick1.checkClick() ;

    stick2.checkClick();

    stick3.checkClick();

    stick4.checkClick();

    stick5.checkClick();

    errorX = mouseX;
    errorY = height-mouseY;
  }
}


//Use if(dist(x,y, OGx, OGy)) 

//Use this to model the distance between mouseX, mouseY and then the stickX and stickY)

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
    
    //timer.start();
  }
  
  void drawStick()
  {
    if(hidden == false)
    {
      stroke(0);
      fill(0);
//      image(stick, stickX , stickY , stick.width/5, stick.height/5);
      ellipse(stickX, stickY, objectSize, objectSize);
    }
  }

  void checkClick () {
    float distance = ((height/2) + ((height/2) - stickY)) ;
//    println(distance);
//    println(objectSize/2);
//    //    if ( mouseY <=   10 + distance || mouseY >= distance - 10) {
    if ( dist(mouseX,  mouseY, stickX, distance ) < objectSize/2  && hidden == false) {
      //200 - stickY
      score++;
      correct.trigger();
      hidden = true;
    }
  }
}



