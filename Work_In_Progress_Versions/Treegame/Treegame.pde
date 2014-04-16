/* @pjs preload="tree.jpg"; */ 
ArrayList<Apple> apples;
PImage img;
PTimer timer;
Basket bas;
int i;
int score;

void setup() {
    size(700, 700);
    img = loadImage("tree.jpg");
    apples = new ArrayList<Apple>();
    bas = new Basket();
    timer = new PTimer();
    timer.callIn(1000);
    score = 0;
    textSize(64);
}

void draw() {
    image(img, 0, 0);
    timer.checkTime();

    // remove used apples
    for (i=0; i<apples.size(); i++) {
        if (apples.get(i).finished) {
            apples.remove(i);
        }
    }    

    for (Apple d: apples) {
        if (bas.checkCatch(d)) {
            score++;
            d.finished = true;
        }
        d.moveApple();
        d.drawApple();
    }

    bas.moveBasket();
    bas.drawBasket();

    // draw score
    fill (244, 200, 50);
    text(score, 20, 100);
    
    if (score == 0) {
      fill (244, 200, 50);
      text("A <- ", 20, 670);
      text("-> D", 520, 670);
    }
    
    if (score >= 20) {
      background(0);
      fill (244, 0, 50);
      text("Success!", 220, 400);
      text("Press any key", 150, 450);
      if (keyPressed == true)
        exit();
    }
}

void callback() {
    apples.add(new Apple());
    timer.callIn(1000-score*4);
}

void keyPressed() {  
    if (key == 'a') {
        bas.left();
    }
    if (key == 'd') {
        bas.right();
    }
}

void keyReleased() {  
    if (key == 'a') {
        bas.stopLeft();
    }
    if (key == 'd') {
        bas.stopRight();
    }

}

