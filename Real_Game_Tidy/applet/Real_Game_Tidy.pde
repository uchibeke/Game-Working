//Conditionals to change between different mini games and the main game
boolean mainGame;
boolean stickGame;
boolean treeGame;
boolean treeGameText;
boolean logGame;

//initializations of variables and Libraries

//Sound Library
import ddf.minim.*;
Minim minim;
AudioPlayer[] player = new AudioPlayer[3];

//Image Library
PImage stick, tree; 

//Color palette setup
// Darkest to brighter, Last is dark red, second last is white
color [] darkTheme = {
  #010712, #13171F, #1C1F26, #24262D, #31353D, #445878, #92CDCF, #EEEFF7, #961227
};
color [] palette = darkTheme;

//Screen size
int screenWidth;
int screenHeight;

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
String welcomeScreen;



//stickGame Variables
Stick stick1, stick2, stick3, stick4, stick5 ;
//stickGame Onscreen Text variables
String s, inst, chal;
int stickScore;

//stickGame Conditional to start the game
boolean start;
//stickGame Timer
int m;
int startTime;
int errorY, errorX;

//StickGame Sound variables
AudioSample stickCorrect;
AudioSample stickIncorrect;


//treeGame Variables
ArrayList<Apple> apples;
PTimer timer;
Basket bas;
int i;
int treeScore;

//appleGame sound variables
AudioSample appleCatch;
AudioSample appleMiss;

//logGame variables
ArrayList<Log> logs;
int logI;
int logJ;
int limit;
int logTime;
int logScore;
int dead;
boolean loss;

//logGame Sound Variable
AudioSample logBreak;




void setup () {
  //Setting up of the screen
  screenWidth = 700;
  screenHeight =  800;
  size (displayWidth, displayHeight);
  background (palette[0]);

  minim = new Minim(this); // initialaizing minim object

  //Initial Game setup at startup
  stickGame = false;
  treeGame = false;
  logGame = false;
  mainGame = true;


  //Maingame
  ground = new Ground();
  adam = new Hero();
  tround = new Ground();
  bround = new Ground();
  welcomeScreen = "CLICKY: The Game";
  //mainGame sound
  player[1] = minim.loadFile("Apple_Dark_Background.wav");


  //stickGame
  {
    s = "Accuracy and speed are key winning." ;
    chal = "Transfer Life Source!";
    inst = "Click on this side of the screen to get objects on opposite the side.";
    startTime = 6000;
    errorY = -1000;
    errorX = -1000;

    start = false;

    //Changing of position randomly by stickGame
    stick1 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
    stick2 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
    stick3 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
    stick4 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
    stick5 = new Stick (random(25, width - 25), random(25, height/2 - 25), 50);
    //Sound in stickGame
    player[0] = minim.loadFile("Locally_Sourced.mp3", 300); // load file in audio player array loadFile ( "FILE NAME"); 
    //  println ("song length is approx. " + player[0].length() / 1000 + " s.");
    stickCorrect = minim.loadSample( "Correct.mp3", 512 );
    stickIncorrect = minim.loadSample( "Incorrect.mp3", 512);
  }

  //TreeGame
  {
    tree = loadImage("tree.jpg");
    apples = new ArrayList<Apple>();
    bas = new Basket();
    timer = new PTimer();
    timer.callIn(1000);
    treeScore = 0;
    textSize(64);
    treeGameText = false;
    //Sound treeGame
    player[2] = minim.loadFile("Tree_Background.wav");
    appleCatch = minim.loadSample( "Apple_Catch.wav", 512 );
    appleMiss = minim.loadSample( "Apple_Miss.wav", 512 );
  }

  //logGame
  {
    logI = 0;
    logs = new ArrayList<Log>();
    limit = 4;
    logScore = 0;
    logTime = 2400;
    loss = false;
    dead = 0;
    while (logI < 4) {
      logs.add(new Log(logI));
      logI += 1;
    }
    textSize(64);
    logBreak = minim.loadSample( "Log_Break.wav", 512 );
  }
}


void draw () {
  //For mainGame
  if (mainGame == true) {
    adam.drawHero();
    ground.drawGround();
    tround.drawTround();
    bround.drawBround();
    smooth();
    textSize(50);
    fill(palette[6]);
    text(welcomeScreen, width/7, height/5);

    if (!player[1].isPlaying()) {
      player[1].rewind();
      player[1].play();
    }
  }


  //For stickGame
  if (stickGame == true)

  {
    background(palette[1]);

    //Correct this. Timer needs to start at 0.
    //Since game already started, millis starts to count
    m = millis();

    if (start == false)
    {
      stroke(palette[7]);
      textSize(30);
      text( chal, width/4, height/4);
      textSize(20);
      text( s, width/4, height/2);
      textSize(20);
      text( inst, width/20, height*0.9);
    }
    else
    {
      //stroke and color for line
      strokeWeight(10);
      stroke(palette[4]);
      line(0, height/2, width, height/2);
      //ellipse following the mouse
      noStroke();
      ellipse(mouseX, mouseY, 50, 50);
    }

    if (m > startTime)
    {

      startTime = m + 2000;
      start = true;
      smooth();

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
      text( inst, width/30, height-10);
    }
    //ellipse showing error opposite the clicks
    stroke(palette[8]);
    noFill();
    ellipse(errorX, errorY, 50, 50);
    //text size and color for score following errot ellipse
    textSize(30);
    fill(palette[6]);
    String score1 = "Score is  " + stickScore;
    text(score1, errorX+25, errorY+25);

    if (!player[0].isPlaying()) {
      player[0].rewind();
      player[0].play();
    }

    //To increase speed of random change of the figure 
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



  //for treeGame
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
      text("A <= ", 20, 670);
      text("=> D", 520, 670);
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
    if (!player[2].isPlaying()) {
      player[2].rewind();
      player[2].play();
    }
  }

  //for logGame
  if (logGame == true) { 
    background(palette[0]);
    for (Log d: logs) {
      d.drawLog();
    }

    //timer
    fill (244, 0, 50);
    text(logTime/60, 130, 200);

    //dead logs
    if (dead >= 1) {
      fill(palette[0]);
      strokeWeight(1);
      stroke(palette[3]);
      ellipse(400, height, 100, 100);
    }
    if (dead >= 2) {
      fill(palette[0]);
      strokeWeight(1);
      stroke(3);
      ellipse(500, height, 100, 100);
    }
    if (dead >= 3) {
      fill(palette[1]);
      strokeWeight(1);
      stroke(3);
      ellipse(600, height, 100, 100);
    }


    // remove destroyed logs
    for (logI=0; logI<logs.size(); logI++) {
      if (logs.get(logI).hurt) {
        background(palette[5]);
        fill (palette[7]);
        text("The falling log", 130, 200);
        text("pushed you back!", 100, 250);
        text("Press any key", 150, 350);
        if (keyPressed == true)
          exit();
      }
      if (logs.get(logI).finished) {
        logs.remove(logI);
        logScore += 1;
        dead += 1;
        for (logJ=0; logJ<logs.size(); logJ++) {
          if (logJ>=logI)
            logs.get(logJ).moveDown();
        }
      }
    }
    if (logScore >= 4) {
      background(palette[5]);
      fill (palette[7]);
      text("Success!", 220, 200);
      text("Press any key", 150, 250);
      if (keyPressed == true)
        exit();
    }

    logTime -= 1;
    if (logTime <= 0) {
      background(palette[5]);
      fill (palette[7]);
      text("Guards arived, RUN!", 40, 200);
      text("Press any key to run", 40, 300);
      if (keyPressed == true)
        exit();
    }
  }
}



void mouseClicked () {
  //for stickGame
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


//for treeGame
void callback() {
  if (treeGame == true) {
    apples.add(new Apple());
    timer.callIn(1000-treeScore*4);
  }
}



void keyPressed() { 
  //for treeGame
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

  //for mainGame and to swtich between games
  if (mainGame == true)
  {
    if (key == 't' && mainGame == true) {
      mainGame = false;
      stickGame = false;
      logGame = false;
      treeGame = true;
    }
    else if (key == 's' && mainGame == true) {
      mainGame = false;
      logGame = false;
      treeGame = false;
      stickGame = true;
    }
    else if (key == 'l' && mainGame == true) {
      mainGame = false;
      treeGame = false;
      stickGame = false;
      logGame = true;
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

void mousePressed () {
  //for logGame
  if (logGame == true ) {
    //    println("mouseX: " +mouseX);
    float logDistance;
    for (logI=0; logI<logs.size(); logI++) {
      logDistance = dist(mouseX, mouseY, logs.get(logI).x, logs.get(logI).y);
      if (logDistance < 50) {
        logs.get(logI).x += 20;
        logBreak.trigger();
        for (logJ=0; logJ<logs.size(); logJ++) {
          logs.get(logJ).wiggle();
        }
      }
    }
  }
}


void keyReleased() { 
  //for treeGame 
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

