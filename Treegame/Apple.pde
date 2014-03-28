class Apple {
    float x, y; 
    float speed;
    boolean finished;

    public Apple() {
        x = random(30, width-30);
        y = 0;
        speed = random(1.0, 1.0+score/5);
        finished = false;
        //println(x,y,speed);
    }

    void drawApple() {
        fill(160, 0, 0);
        strokeWeight(1);
        noStroke();
        ellipse(x, y, 30, 30);
    }

    void moveApple() {
        if (!finished) {
            if (y > height) {
                finished = true;
            } 
            else {
                y += speed; 
                speed  *= 1.01;
            }
        }
    }
}


