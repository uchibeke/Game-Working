//Conditionals to change between different mini games and the main game
boolean mainGame;
boolean stickGame;
boolean treeGame;
boolean treeGameText;
boolean logGame;

//Starts the main stickGame
boolean stickGameStart;
boolean stickGameStart2;
boolean logGameStart;

//switch images
boolean displayImage1 = false;
boolean displayImage2 = false;
boolean displayImage3 = false;
boolean displayImage4 = false;


PImage startBackground;

int mouseIndex;
//initializations of variables and Libraries

//Sound Library
import ddf.minim.*;
Minim minim;
AudioPlayer[] player = new AudioPlayer[6];

//Image Library
PImage stick, tree; 
//PImage 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12;

//Color palette setup
// Darkest to brighter, Last is dark red, second last is white
color [] darkTheme = {
  #010712, #13171F, #1C1F26, #24262D, #31353D, #445878, #92CDCF, #EEEFF7, #961227, #BF4904
};
color [] palette = darkTheme;

PImage [] images;
PImage newImage;




//Screen size
int screenWidth;
int screenHeight;

//MainGame Variables
//Hero adam;
//Ground ground;
//Ground tround;
//Ground bround;
//boolean walkLeft;
//boolean walkRight;
//boolean jump;
//boolean onGround;
//int objectdx;
//boolean jumping;
//boolean onObject;
//String welcomeScreen;

float playerX, playerY;
float xPos, yPos;
float mainSmooth;
float mainX, mainY;
PImage map;
PImage zanto;



//stickGame Variables
Stick stick1, stick2, stick3, stick4, stick5 ;
//stickGame Onscreen Text variables
String s, inst, chal;
int stickScore;

String score1;

//stickGame Conditional to start the game
boolean start;
//stickGame Timer
int m;
int startTime;
int errorY, errorX;
int stickTime;

//StickGame Sound variables
AudioSample stickCorrect;
AudioSample stickIncorrect;

AudioSample failTone;


//treeGame Variables
ArrayList<Apple> apples;
PTimer timer;
Basket bas;
int i;
int treeScore;

int treeTime;

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

  //An array of images. Hold all the background images
  images = new PImage[13];
  for ( int imageIndex = 0; imageIndex< images.length; imageIndex++ )
  {
    images[imageIndex] = loadImage( imageIndex + ".png" );   // make sure images "0.jpg" to "11.jpg" exist
  }
  PImage [] slideImages = images;


  //Setting up of the screen
  screenWidth = 700;
  screenHeight =  680;
  size (screenWidth, screenHeight);
  if (frame != null) {
    frame.setResizable(true);
  }


  images[0].resize(width, height);
  background(images[0]);

  minim = new Minim(this); // initialaizing minim object

  //Initial Game setup at startup
  stickGame = false;
  treeGame = false;
  logGame = false;
  mainGame = false;

  stickGameStart =  false;
  stickGameStart2 =  false;

  logGameStart = false;


  //mainGame sound
  player[5] = minim.loadFile("Dramatic_Drums.wav");
  player[1] = minim.loadFile("Apple_Dark_Background.wav");
  //  player[3] = minim.loadFile("Possessed.wav");

  failTone = minim.loadSample( "Voice_Fail.mp3", 512 );


  {
    frameRate(60);
    zanto = loadImage("walk4_2.png");
    map = loadImage("game_map_3.jpg");
    image(map, 0, 0);
    map.resize(width, height);
    playerX = 215;
    playerY = 455;
    xPos = 0;
    yPos = 0;
    mainSmooth = 0.05;
  }

  //stickGame
  {
    s = "Accuracy and speed are key winning." ;
    chal = "Transfer Life Source!";
    inst = "Click on this part of the screen to get life source from other half.";
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

    score1 =  stickScore + "Life Sources Transfered ";

    stickTime = 3600;
  }

  //TreeGame
  {
    tree = loadImage("Tree_of_Life.jpg");
    apples = new ArrayList<Apple>();
    bas = new Basket();
    timer = new PTimer();
    timer.callIn(1000);
    treeScore = 0;
    textSize(64);
    treeGameText = false;

    //Sound treeGame
    //    player[2] = minim.loadFile("Tree_Background.wav");
    player[4] = minim.loadFile("Fear_Theme.wav");
    appleCatch = minim.loadSample( "Apple_Catch.wav", 512 );
    appleMiss = minim.loadSample( "Apple_Miss.wav", 512 );

    treeTime = 2300;
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

  startBackground = map;
  
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void draw () {

  fill(palette[7]);


  image(startBackground, 0, 0, width, height);
  textSize(30);
  text("1>>>>    2>>>>    3> >>    4> >>     5> >>", width-680, 80);
  image(images[0], width-650, 50, 50, 50);
  image(images[1], width-500, 50, 50, 50);
  image(images[2], width-350, 50, 50, 50); 
  image(images[3], width-200, 50, 50, 50);
  image(map, width-50, 50, 50, 50);  

  float pX = (xPos - playerX) * mainSmooth;
  float pY = (yPos - playerY) * mainSmooth;

  playerX += mainX;
  playerY += mainY;
  if (!player[4].isPlaying()) {
    player[4].rewind();
    player[4].play();
  }



  //default position of charcter at start and end of game
  xPos = playerX;
  yPos = playerY;


  //For mainGame
  if (mainGame == true) {

    //pause other background sounds
    player[4].pause();

    background(map);
    xPos = 215;
    yPos = 455;

    /*if (dist(playerX, playerY, xPos, yPos) < 1) {
     xPos = 450;
     yPos = 312;
     }
     */
    textSize(20);
    image(zanto, playerX, playerY);
    text ("Click Me to collect life source from tree of life", xPos+ 40, yPos+10);

    //Background Music for start up Game
    if (!player[5].isPlaying()) {
      player[5].rewind();
      player[5].play();
    }
  }



  //for treeGame
  if (treeGame == true)
  {
    player[5].pause();
    xPos = 410;
    yPos = 370;

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
    //    fill (244, 200, 50);
    //    text(treeScore, 20, 100);
    textSize(20);
    smooth();
    noFill();
    strokeWeight(5);
    rect(10, 50, 200, 10);

    fill(palette[9]);
    noStroke();
    rect(10, 50, treeScore*10, 10);
    fill (palette[7]);
    textSize(30);

    text("Time left: " + treeTime/60, 10, height-40);
    if (treeScore == 0) {
      fill (244, 200, 50);
      text("A <= ", 20, 670);
      text("=> D", 520, 670);
    }

    //check the score and move to next game/level
    if (treeScore >= 20 && treeTime >= 0)
    {
      player[0].pause();
      background(palette[1]);
      fill (palette[7]);
      text("You Collected Life Source", 80, 200);
      player[0].pause();
      text("Press space key to transfer life source", 100, 300);
      treeGame = false;
      resetStickGame();
      if (keyPressed == true) {
        resetStickGame();
      }
    }



    fill(palette[6]);
    treeTime -= 1;

    //check score and reset game if score is not up to 20 and time is finished
    if (treeTime <= 0 && treeScore < 20) {
      //      failTone.trigger();
      appleCatch.stop();
      appleMiss.stop();
      treeScore = 0;
      background(palette[8]);
      fill (palette[7]);
      text("Time's up. START AGAIN!", 250, 200);

      //change to player for treeGame
      text("Press space key to start again", 200, 300);
      if (keyPressed == true) {
        resetGame();
        failTone.trigger();
      }
    }
  }


  //For stickGame
  /////////////////////////
  if (stickGame == true)
  {
    //    player[5].pause();
    //    startBackground = images[4];
    image(startBackground, 0, 0, width, height);
    textSize(30);
    text("1>>>>    2>>>>    3> >>    4> >>     5> >>", width-680, 80);
    image(images[4], width-650, 50, 50, 50);
    image(images[5], width-500, 50, 50, 50);
    image(images[6], width-350, 50, 50, 50); 
    image(images[7], width-200, 50, 50, 50);
    image(map, width-50, 50, 50, 50);  

    //background sound for game
    if (!player[4].isPlaying()) {
      player[4].rewind();
      player[4].play();
    }
  }

  if (stickGameStart == true) {
    background(map);
    textSize(20);
    xPos = 212;
    yPos = 310;
    image(zanto, xPos, yPos);
    text ("Click Me to transfer Life source", xPos+ 40, yPos+10);
    if (!player[5].isPlaying()) {
      player[5].rewind();
      player[5].play();
    }
  }



  if (stickGameStart2 == true) {
    fill(palette[6]);
    background(palette[3]);

    //Timer
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
    stroke(palette[9]);
    noFill();
    ellipse(errorX, errorY, 50, 50);
    //text size and color for score following errot ellipse
    textSize(25);
    fill(palette[6]);

    score1 =  stickScore +" Life source(s) transfered";
    text(score1, errorX+25, errorY+25);

//    if (!player[0].isPlaying()) {
//      player[0].rewind();
//      player[0].play();
//    }

    //stick_Timer
    if (stickScore <=0 && start == true) {
      textSize(20);
      text( inst, width/30, height-10);
    }
    smooth();
    noFill();
    stroke(palette[7]);
    rect(10, 50, 200, 10);

    fill(palette[9]);
    rect(10, 50, stickScore*10, 10);
    fill (palette[7]);
    textSize(20);

    text("Time left: " + stickTime/60, 10, 40);

    //To increase speed of random change of the figure 
    if (stickScore >= 5)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 10)
    {
      startTime = startTime-10;
    }
    if (stickScore >= 15)
    {
      startTime = startTime-6;
    }
    if (stickScore >= 19)
    {
      startTime = startTime-10;
      score1 = "You need one more. Score is  " + stickScore;
      //      text(score1, errorX+25, errorY+25);
    }

    //check score if its up tp 20 within the time and proceed to next game
    if (stickScore >= 20 && stickTime != 0)
    {
      player[0].pause();
      background(map);
      textSize(50);
      fill (palette[1]);
      text("YOU SAVED THE WORLD", 80, 200);
      player[0].pause();
      textSize(30);
      text("Play the 2015 Edition of NAKU next year to Dethrone The King", 100, 300);
      if (keyPressed == true) {
        exit();
      }
    }

    fill(palette[6]);
    stickTime -= 1;

    //check if score is not up to 20 and time is finished then player starts again from the beginning
    if (stickTime <= 0 && stickScore < 20) {
      player[4].pause();
      player[5].pause();
      stickScore = 0;
      background(palette[8]);
      fill (palette[7]);
      text("Time's up. START AGAIN!", 250, 200);
      player[0].pause();
      text("Press space key to start again", 200, 300);
      if (keyPressed == true) {
        resetGame();
        failTone.trigger();
      }
    }
  }

  //End of stickGame
  ///////////////////////



  //for logGame
  if (logGame == true) { 

    //    startBackground = images[4];
    image(startBackground, 0, 0, width, height);
    image(images[8], width-650, 50, 50, 50);
    image(images[9], width-500, 50, 50, 50);
    image(images[10], width-350, 50, 50, 50); 
    image(images[11], width-200, 50, 50, 50);
    image(map, width-50, 50, 50, 50);  

    xPos = 440;
    yPos = 200;

    if (logGameStart == true) {
      background(palette[0]);
      for (Log d: logs) {
        d.drawLog();
      }

      //timer
      fill (244, 0, 50);
      text(logTime/60, 130, 200);

      //dead logs
      if (dead >= 1) {
        fill(palette[1]);
        strokeWeight(1);
        stroke(3);
        ellipse(400, height, 100, 100);
      }
      if (dead >= 2) {
        fill(palette[1]);
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
            if (keyPressed == true) {
              mainGame = true;
              logGame = false;
              treeGame = false;
              stickGame = false;
            }
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
        text("you can now exit", 150, 250);
        if (keyPressed == true) {
          mainGame = true;
          logGame = false;
          treeGame = false;
          stickGame = false;
        }
      }

      logTime -= 1;
      if (logTime <= 0) {
        background(palette[5]);
        fill (palette[7]);
        text("Guards arived, RUN!", 40, 200);
        text("Press any key to run", 40, 300);
        if (keyPressed == true) {
          mainGame = true;
          logGame = false;
          treeGame = false;
          stickGame = false;
        }
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

  // if your mouse is within the x and y values of the thumbnail image, switch the background image.
  if ( (mouseX > width-650 && mouseX < height-600) && (mouseY > 50 && mouseY < 100) ) { //actual values may differ
    startBackground = images[0];
  } 
  else if ((mouseX > width-500 && mouseX < height-450) && (mouseY > 50 && mouseY < 100) ) {
    startBackground = images[1];
  } 
  //  else if ((mouseX > 0 && mouseX < height) && (mouseY > 50 && mouseY < 100) && (startBackground == images[0]) ) {
  //    startBackground = images[1];
  //  } 
  else if ((mouseX > width-350 && mouseX < height-300) && (mouseY > 50 && mouseY < 100) ) {
    startBackground = images[2];
  }
  else if ((mouseX > width-200 && mouseX < height-150) && (mouseY > 50 && mouseY < 100) ) {
    startBackground = images[3];
  } 
  else if ((mouseX > width-50 && mouseX < height-0) && (mouseY > 50 && mouseY < 100) ) {
    startBackground = map;
    mainGame = true;
  }
  if ((mainGame == true) && (mouseX > xPos-50 && mouseX < xPos + 50) && (mouseY > yPos - 50 && mouseY < yPos +50)) { //actual values may differ
    treeGame = true;
  }

  //Displays another series of images after lifeSource is collected
  if ((stickGame == true)) {
    startBackground = images[4];
    if ( (mouseX > width-650 && mouseX < height-600) && (mouseY > 50 && mouseY < 100) ) { 
      startBackground = images[4];
    } 
    else if ((mouseX > width-500 && mouseX < height-450) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[5];
    } 
    else if ((mouseX > width-350 && mouseX < height-300) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[6];
    }
    else if ((mouseX > width-200 && mouseX < height-150) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[7];
    } 
    else if ((mouseX > width-50 && mouseX < height-0) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = map;
      stickGameStart = true;
    }
    else if ((stickGame == true) && (mouseX > xPos-50 && mouseX < xPos + 50) && (mouseY > yPos - 50 && mouseY < yPos +50)) {
      stickGameStart2 = true;
    }
  }
  //Displays another series of images after lifeSource is trasnfered
  if ((logGame == true)) {
    if ( (mouseX > width-650 && mouseX < height-600) && (mouseY > 50 && mouseY < 100) ) { 
      startBackground = images[8];
    } 
    else if ((mouseX > width-500 && mouseX < height-450) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[9];
    } 
    else if ((mouseX > width-350 && mouseX < height-300) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[10];
    }
    else if ((mouseX > width-200 && mouseX < height-150) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = images[10];
    } 
    else if ((mouseX > width-50 && mouseX < height-0) && (mouseY > 50 && mouseY < 100) ) {
      startBackground = map;
      stickGameStart = true;
    }
    else if ((stickGame == true) && (mouseX > xPos-50 && mouseX < xPos + 50) && (mouseY > yPos - 50 && mouseY < yPos +50)) {
      stickGameStart = true;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void resetGame () {
  player[0].pause();
  //  player[2].pause();
  setup();
  draw();
  mainGame = true;
}

void resetTreeGame () {
  player[0].pause();
  player[1].pause();
  //  setup();
  draw();
  treeGame = true;
}


void resetStickGame () {
  //  if (treeScore >= 20) 
  //  {
  player[1].pause();
  //  player[2].pause();
  //    setup();
  draw();
  stickGame = true;
}

void resetLogGame () {
  //  if (treeScore >= 20 && stickScore >= 20) {
  player[1].pause();
  //  player[2].pause();
  player[0].pause();
  draw();
  logGame = true;
}


//always runs in fullscreen
boolean sketchFullScreen() {
  return true;
}

