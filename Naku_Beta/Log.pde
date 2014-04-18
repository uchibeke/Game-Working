class Log {
    float x, y; 
    boolean finished;
    boolean hurt;
    float rand;

    public Log(int i) {
        x = 300;
        y = height-50-(i*100);
        finished = false;
        //println(x,y,speed);
    }

    void drawLog() {
        fill(palette[3]);
        strokeWeight(1);
        noStroke();
        ellipse(x, y, 100, 100);
    }
    
    void wiggle() {
        rand = random(-1, 1);
        if (rand >= 0) {
            x += 20;
        } else {
            x -= 20;
        }
        if (x>360)
            finished = true;
        if (x<240)
            hurt = true;
    }
    
    void moveDown() {
        y += 100;
    }
}
