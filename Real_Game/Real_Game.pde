//Conditionals to change between different mini games and the main game
boolean mainGame;
boolean stickGame;
boolean treeGame;
boolean treeGameText;

//initializations of variables and Libraries

//Sound Library
import ddf.minim.*;
Minim minim;
AudioPlayer[] player = new AudioPlayer[1];

//Image Library
PImage stick, tree; 

//MainGame Variables
Hero adam;
Ground ground;
Ground tround;
Ground bround;
boolean walkLeft;
boolean walkRight;
boolean jump;
boolean onGround;
int objectdx;
boolean jumping;
boolean onObject;


//StickGame Sound variables
AudioSample stickCorrect;
AudioSample stickIncorrect;


//stickGame Variables
Stick stick1, stick2, stick3, stick4, stick5 ;
String s, inst, chal;

int stickScore;
int br, bg, bb;

boolean start;


int m;
int startTime;

int errorY, errorX;

int screenWidth;
int screenHeight;

//treeGame
ArrayList<Apple> apples;
PTimer timer;
Basket bas;
int i;
int treeScore;





void setup () {

  //Game setup
  stickGame = false;
  treeGame = false;
  mainGame = true;


  //Maingame
  if (mainGame == true) {
    background(150);
    ground = new Ground();
    adam = new Hero();
    tround = new Ground();
    bround = new Ground();
  }
  //Stick
  screenWidth = 700;
  screenHeight =  700;
  size (screenWidth, screenHeight);
  s = "Accuracy and speed are key winning." ;
  chal = "Transfer Life Source!";
  inst = "Click on this side of the screen to get objects on opposite the side.";
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

  stickCorrect = minim.loadSample( "Correct.mp3", 512  );
  stickIncorrect = minim.loadSample( "Incorrect.mp3", 512 );

  stick = loadImage("Stick.png");

  //TreeGame
  tree = loadImage("tree.jpg");
  apples = new ArrayList<Apple>();
  bas = new Basket();
  timer = new PTimer();
  timer.callIn(1000);
  treeScore = 0;
  textSize(64);
  treeGameText = false;
}


void draw () {

  if (mainGame == true) {
    background(150);
    adam.drawHero();
    ground.drawGround();
    tround.drawTround();
    bround.drawBround();
  }

  if (stickGame == true)

  {
    background(br, bg, bb);

    m = millis();

    if (start == false)
    {
      textSize(20);
      text( s, 25, height/2);
      stroke(255, 0, 0);
      textSize(30);
      text( chal, width/5, height/4);
      textSize(20);
      text( inst, width/5, height*0.9);
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

    if (start == true) {
      stick1.drawStick();
      stick2.drawStick();
      stick3.drawStick();
      stick4.drawStick();
      stick5.drawStick();
    }



    if (start == true && millis()<10000) {
      textSize(20);
      text( inst, width/4, height-10);
    }

    stroke(255, 0, 0);
    noFill();
    ellipse(errorX, errorY, 50, 50);
    textSize(30);
    fill(255 - br, 255 -bg, 255 -bb);
    String score1 = "Score is  " + stickScore;

    text(score1, errorX+25, errorY+25);

    if (!player[0].isPlaying()) {
      player[0].rewind();
      player[0].play();
    }

    if (stickScore >= 5)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 10)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 15)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 20)
    {
      startTime = startTime-15;
    }
    if (stickScore >= 25)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 30)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 35)
    {
      startTime = startTime-10;
    }
    if (stickScore >= 40)
    {
      startTime = startTime-10;
    }
  }

  //treeGame
  if (treeGame == true)
  {
    image(tree, 0, 0);
    timer.checkTime();

    // remove used apples
    for (i=0; i<apples.size(); i++) {
      if (apples.get(i).finished) {
        apples.remove(i);
      }
    }    

    for (Apple d: apples) {
      if (bas.checkCatch(d)) {
        treeScore++;
        d.finished = true;
      }
      if (bas.checkCatch(d) == false && d.finished == true) {
        treeScore--;
        d.finished = true;
      }

      d.moveApple();
      d.drawApple();
    }

    bas.moveBasket();
    bas.drawBasket();

    // draw score
    fill (244, 200, 50);
    text(treeScore, 20, 100);

    if (treeScore == 0) {
      fill (244, 200, 50);
      text("A <- ", 20, 670);
      text("-> D", 520, 670);
    }

    if (treeScore >= 20) {
      background(0);
      fill (244, 0, 50);
      treeGameText = true;

      if (treeGameText == true)
      {
        text("Success!", 220, 400);
        text("Press any key", 150, 450);
      }

     
    }
  }
}

//stickGame
void mouseClicked () {

  if (stickGame == true) {
    if (start == true) {
      stickIncorrect.trigger();
      stick1.checkClick() ;

      stick2.checkClick();

      stick3.checkClick();

      stick4.checkClick();

      stick5.checkClick();

      errorX = mouseX;
      errorY = height-mouseY;
    }
  }
}

//treeGame
void callback() {
  if (treeGame == true) {
    apples.add(new Apple());
    timer.callIn(1000-treeScore*4);
  }
}

//treeGame
void keyPressed() { 
  if (treeGame == true) { 
    if (key == 'a') {
      bas.left();
    }
    if (key == 'd') {
      bas.right();
    }
     if (key == ' ' && treeGame == true &&treeGameText == true) {
        treeGameText = false;
        treeGame = false;
        mainGame = true;
        treeScore = 0;
      }
  }

  if (mainGame == true)
  {
    if (key == 'g' && mainGame == true) {
      mainGame = false;
      treeGame = true;
    }
    else if (key == 'h' && mainGame == true) {
      mainGame = false;
      stickGame = true;
    }
    if (mainGame == true) {
      {
        if (key == CODED) {
          if (keyCode == LEFT )
          {
            walkLeft = true;
            objectdx = 3;
          }
          else if (keyCode == RIGHT )
          {
            walkRight = true; 
            objectdx = -3;
          }
          else if (keyCode == UP )
            jumping = true;
        }
      }
    }
  }
}

//treeGame
void keyReleased() {  
  if (treeGame == true) 
  {
    if (key == 'a') {
      bas.stopLeft();
    }
    if (key == 'd') {
      bas.stopRight();
    }
  }
  if (mainGame == true) {
    {
      if (key == CODED) {
        if (keyCode == LEFT )
        {
          walkLeft = false;
          objectdx = 3;
        }
        else if (keyCode == RIGHT )
        {
          walkRight = false; 
          objectdx = -3;
        }
        else if (keyCode == UP )
          jumping = false;
      }
    }
  }
}


//Use if(dist(x,y, OGx, OGy)) 

//Use this to model the distance between mouseX, mouseY and then the stickX and stickY)

