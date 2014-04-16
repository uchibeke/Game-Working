/*@ p j s preload="Jump-zanto.png";
@ p j s preload="Stand-zanto.png";
@ p j s preload="Run-zanto.png";
*/
PImage smallplatform;
PImage largeplat;
PImage mps;
PImage idle;
PImage running;
PImage jumping;
PImage dead;
PImage coursetile;
PImage grasstile;
PImage bricktile;
PImage backgroundA;
PImage backgroundB;
PImage block;
final int screenWidth = 800;
final int screenHeight = 600;
float playerVelocityY = 0;
float playerVelocityX = 0;
float gravity = .3;
float acceleration = 1;
boolean onGround;




void initialize() {
  frameRate(30);
  addScreen("level", new FirstLevel (4*width, height));  
  backgroundA = loadImage("landscdape.png");
  backgroundB = loadImage("rough_level.jpg");
  idle = loadImage("Idle-zanto.png"); //Stand-zanto.png
  jumping = loadImage("jump3.png"); //Jump-zanto.png
  running = loadImage("walk1.png");  //Run-zanto.png
  dead = loadImage("mushroom.gif");
  coursetile = loadImage("coursetile.png");
  grasstile = loadImage("b_floorA.png");
  bricktile = loadImage("bricktile.png");
  mps = loadImage("mps.png");
  largeplat = loadImage("largeplat.png");
  smallplatform = loadImage("smallplatform.png");
  block = loadImage("b_sewerback2.png");
  //bramble = loadImage("Desert_Thorn.png");
}
 
 //declare and construct Level class
 
class FirstLevel extends Level {
  FirstLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    addLevelLayer("layer", new MyLevelLayer(this));
   // addLevelLayer("background", new BackgroundLayer(this));
    setViewBox(0, 0, screenWidth, screenHeight);
  }
}



class MyLevelLayer extends LevelLayer {
  Phil ph;
  MyLevelLayer(Level owner) {
    super(owner);
    Sprite backgroundA = new Sprite("landscape.png");
    TilingSprite  background = new TilingSprite(backgroundA, 0, 0, width, height);
    addBackgroundSprite(background);
    addGround(-32,height-48, 1650,height);
    addGroundPlat(1031, height-300, 1110, height-100); 
    addGroundPlat(1200, height-300, 1320, height-100);
    addLongPlat(600, 490, 1030, height-70);
    addLongPlat(800, 430, 1030, height-140); 
    addLongPlat(1200, 430, 1430, height-140);
    addLongPlat(1200, 490, 1630, height-70);
    addLongPlat(2950, 430, 3430, height-140);
    addLongPlat(2900, 490, 3430, height-70);
    addLongPlat(3000, 365, 3430, height-210);
    addLongPlat(3050, 300, 3430, height-280);
    addBramble(1700,height - 100, 2900, height);
    ph = new Phil();
    ph.setPosition(100, height-200);
    addPlayer(ph);
    addSlant(3500, height-48);
    addSlant(530, height-48);
    addSlant(970, height-170);
    addSlant(1340, height-170);
    addPlat(2200, height-48);
    addPlat(1900, height-48);
    addPlat(1700, height-48);
    addPlat(2500, height-48);
    addThinPlat(2800, height-48);
    addThinPlat(2100, height-48);
    addThinPlat(2400, height-48);
    addThinPlat(2700, height-48);
   
  
    
    //levelboundry
    
    addBoundary(new Boundary(0, height-50, width - 1500, height-50));
    addBoundary(new Boundary(-1, 0, -1, height));
    addBoundary(new Boundary(width+1, height, width+1, 0));
   // showBoundaries = true;
  }
     void addSlant(float x, float y) {
       Sprite medslant = new Sprite("mps.png");
       medslant.align(LEFT, BOTTOM);
       medslant.setPosition(x, y);
       addBackgroundSprite(medslant);
       addBoundary(new Boundary(x-10, y + 20 - medslant.height, x +60, y - medslant.height));
    }
     void addPlat(float x, float y) {
       Sprite tallplat = new Sprite("largeplat.png");
       tallplat.align(LEFT, BOTTOM);
       tallplat.setPosition(x, y);
       addBackgroundSprite(tallplat);
       addBoundary(new Boundary(x, y - tallplat.height + 5, x + 100, y - tallplat.height + 5));
    }
     void addThinPlat(float x, float y) {
       Sprite thinplat = new Sprite("smallplatform.png");
       thinplat.align(LEFT, BOTTOM);
       thinplat.setPosition(x, y);
       addBackgroundSprite(thinplat);
       addBoundary(new Boundary(x, y - thinplat.height, x + 35, y - thinplat.height));
    }
    
      /*****************************************************************/
  
  // function for adding platforms and level aesthetics 
  
    void addGround(float x1, float y1, float x2, float y2) {
      Sprite grass = new Sprite("b_floorA.png");
      TilingSprite groundline = new TilingSprite(grass, x1, y1, x2, y1 + 1);
      addBackgroundSprite(groundline);
    }
    
    void addGroundPlat(float x1, float y1, float x2, float y2) {
      Sprite sub = new Sprite("b_sewerback2.png");
      TilingSprite subsoil = new TilingSprite(sub, x1, y1, x2, y2);
      addBackgroundSprite(subsoil);
      addBoundary(new Boundary(x1,y1,x2,y1));
      addBoundary(new Boundary(x1,y2+50,x1,y1));
      addBoundary(new Boundary(x2,y1,x2,y2+50));      
    }
    void addLongPlat(float x1, float y1, float x2, float y2) {
      Sprite lp = new Sprite("b_sewerback2.png");
      TilingSprite longplat = new TilingSprite(lp, x1, y1, x2, y2);
      addBackgroundSprite(longplat);
      addBoundary(new Boundary(x1,y1,x2,y1));
      addBoundary(new Boundary(x1,y2,x1,y1));
      addBoundary(new Boundary(x2,y1,x2,y2)); 
    }
     
    void addBramble(float x1, float y1, float x2, float y2) {
      Sprite brm = new Sprite("CrownofThorns-400.png");
      TilingSprite bramble = new TilingSprite(brm, x1, y1, x2, y2);
      addBackgroundSprite(bramble);
      //addBoundary(new Boundary(x1,y1,x2,y1));
     // addBoundary(new Boundary(x1,y2,x1,y1));
     // addBoundary(new Boundary(x2,y1,x2,y2)); 
    }
    // continuaously calls player tracker
    
     void draw() {
    super.draw();
    viewbox.track(parent, ph);
    
    }
}

     

// Our Character

class Phil extends Player {

  Phil() {
    super("Phillip");
    setPosition(x, y);
    setupStates();
    handleKey('W');
    handleKey('A');
    handleKey('D');
    setImpulseCoefficients(0.75, 0.75);
    setForces(0, playerVelocityY += gravity);
    setAcceleration(0, acceleration);
  }


  //character visual attributes
  
  void setupStates() {
    addState(new State("idle", "Idle-zanto.png")); //Stand-zanto.png
    addState(new State("jumping", "jump3.png")); //Jump-zanto.png
    addState(new State("running", "walk1.png")); //Run-zanto.png
    addState(new State("dead", "mushroom.gif"));
    State idle = new State ("idle", "Idle-zanto.png"); //Stand-zanto.png
    State jumping = new State ("jumping", "jump3.png"); //Jump-zanto.png
    State running = new State ("running", "walk1.png"); //Run-zanto.png
    State dead = new State ("dead", "mushroom.gif");
    addState (dead);
   //jumping.setDuration(30);   
    addState(jumping);
    setCurrentState("idle");
  }
  
 /*  void die(){
     setCurrentState("dead");
     setInteracting(false);
   }
   
   void handleStateFinished(State which) {
     if (which.name == "dead") {
       removeActor();
       reset();
     } else {
       setCurrentState("idle");
     } 
   

  //character control functions
   void reset() {   
    clearScreens();
    addScreen("level", new FirstLevel (4*width, height));
  } */
 
  void handleInput() {
    if (isKeyDown('W') && active.name!="jumping" && boundaries.size()>0 && iy == 0) { 
      addImpulse(0, - 40); 
      setCurrentState("jumping");
      
    }
 
    if (isKeyDown('A') || isKeyDown('D')) { 
      setCurrentState("running");
    }
      if (isKeyDown('A')) {
        setHorizontalFlip(true);
        addImpulse(-1.3, 0);
      }
      if (isKeyDown('D')) {
        setHorizontalFlip(false);
        addImpulse(1.3, 0);
      }  
    
      if (active.mayChange()) {
        if (isKeyDown('A') || isKeyDown('D')) { 
          setCurrentState("running");
        }
      else { setCurrentState("idle"); }
        
  }
        
        if (!isKeyDown('W') && !isKeyDown('D') && !isKeyDown('A')) {
          setCurrentState("idle");
        }
      }     
   }
 
 


