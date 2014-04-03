class Basket {
    float x;
    float moveAmount;
    boolean left, right;

    public Basket() {
        x = width/2;
        moveAmount = 8;
        left = false;
        right = false;
    } 

    void left() {
        left = true;
    }

    void right() {
        right = true;
    }

    void stopLeft() {
        left = false;
    }

    void stopRight() {
        right = false;
    }

    void moveBasket() {
        if (left) {
            x -= moveAmount;
        }
        if (right) {
            x += moveAmount;
        }
    }

    void drawBasket() {
        //println("  draw:: " + millis());  
        strokeWeight(1);
        fill(200, 100, 60);
        rect(x-70, height-15, 140, 30);
        stroke(200, 100, 60);
        strokeWeight(10);
        line(x-70, height-15, x-90, height-25);
        line(x+70, height-15, x+90, height-25);
    }

    boolean checkCatch(Apple d) {
        if (d.y > height) {
            if (d.x > x-70 && d.x < x+70) {
                //score++;
                return true;
            } 
            else {
                return false;
           
            }
            //d.finished = true;
        }
        return false;
    }
}


