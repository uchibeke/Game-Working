

/*              */
PImage collisionBackgroundA;
PImage backgroundA;
final int screenWidth = 800;
final int screenHeight = 600;
float playerVelocityY = 0;
float playerVelocityX = 0;
float gravity = .3;
float acceleration = 1;
boolean onGround;
boolean isRectOverlapping(float left, float top, float right, float bottom, 
float otherLeft, float otherTop, float otherRight, float otherBottom) {
  return !(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop);
}

void initialize() {
  frameRate(30);
  addScreen("level", new FirstLevel (10*width, height));  
  backgroundA = requestImage("landscape.png");
}
 //declare and construct Level class
 
class FirstLevel extends Level {
  FirstLevel(float levelWidth, float levelHeight) {
    super(levelWidth, levelHeight);
    
    // initializes player tracking within game screen
    
    addLevelLayer("background", new BackgroundLayer(this));
    addLevelLayer("layer", new MyLevelLayer(this));
    setViewBox(0, 0, screenWidth, screenHeight);
  }
}
 /*************** UPDATE THIS CODE *************/
class BackgroundLayer extends LevelLayer {
     BackgroundLayer(Level owner) {
      super(owner, owner.width, owner.height, 0, 0, 0.75, 0.75);
      setBackgroundColor(color(0, 100, 190));
      addBackgroundSprite(new TilingSprite(new Sprite("graphics/backgrounds/sky_2.gif"),0,0,width,height));
  }
}


class MyLevelLayer extends LevelLayer {
  Phil ph;
  MyLevelLayer(Level owner) {
    super(owner);
    addBackgroundSprite(new TilingSprite(new Sprite("graphics/backgrounds/sky.gif"),0,0,width,height));
    Sprite backgroundA = new Sprite("landscape.png");
    TilingSprite  background = new TilingSprite(backgroundA, 0, 0, width, height);
    addBackgroundSprite(background);
    ph = new Phil();
    ph.setPosition(40, height-100);
    addPlayer(ph);
    //addGround(-32,height-48, width+32,height);
    addBoundary(new Boundary(0, height-50, width, height-50));
    addBoundary(new Boundary(-1, 0, -1, height));
    addBoundary(new Boundary(width+1, height, width+1, 0));
    showBoundaries = true;
  }
  
  // function for adding platforms and level aesthetics 
  
    void addGround(float x1, float y1, float x2, float y2) {
      Sprite grass = new Sprite("");
      TilingSprite ground = new TilingSprite(grass, x1, y1, x2, y1 +16);
      addBackgroundSprite(ground);
      
      Sprite sub = new Sprite("");
      TilingSprite subsoil = new TilingSprite(subsoil, x1, y1+16, x2, y2);
      addBackgoundSprite(subsoil);
      
      addBoundary(new Boundary(x1,y1,x2,y2));
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
    setStates();
    handleKey('W');
    handleKey('A');
    handleKey('D');
    setImpulseCoefficients(0.75, 0.75);
    setForces(0, playerVelocityY += gravity);
    setAcceleration(0, acceleration);
  }

  //character visual attributes
  
  void setStates() {
    addState(new State("idle", "mushroom.gif"));
    addState(new State("jumping", "mushroom.gif"));
    addState(new State("running", "mushroom.gif"));
    addState(new State("dead", "mushroom.gif"));
    setCurrentState("idle");
    State jumping = new State ("jumping", "mushroom.gif");
    jumping.setDuration(30);   
    addState(jumping);
  }
  //character control functions
  
  void handleInput() {
    if (isKeyDown('W') && active.name!="jumping" && boundaries.size()>0) { 
      addImpulse(0, -35); 
      setCurrentState("jumping");
    }

    if (isKeyDown('A') || isKeyDown('D')) { 
      setCurrentState("running");

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
        else { 
          setCurrentState("idle");
        }
        //setCurrentState("running");
        if (!isKeyDown('W') && !isKeyDown('D') && !isKeyDown('A')) {
          setCurrentState("idle");
        }
      }
    }
  }
  void hit() {
    fill(255, 0, 0, 200);
    rect(x-10, y-10, 10, 10);
  }
}


