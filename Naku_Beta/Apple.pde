class Apple {
  float x, y; 
  float speed;
  boolean finished;

  public Apple() {
    x = random(30, width-30);
    y = 0;
    speed = random(1.2, 1.2+treeScore/4);
    finished = false;
    //println(x,y,speed);
  }

  void drawApple() {
    fill(palette[9]);
    strokeWeight(1);
    noStroke();
    ellipse(x, y, 30, 30);
  }

  void moveApple() {
    if (!finished) {
      if (y > height) {
        finished = true;
      } 
      else if(treeScore <= 5) {
        y += speed; 
        speed  *= 1.01;
      }
      else if (treeScore<= 10)
      {
        y += speed; 
        speed  *= 1.02;
      }
      else if (treeScore<= 15)
      {
        y += speed; 
        speed  *= 1.04;
      }
      else if (treeScore<= 20)
      {
        y += speed; 
        speed  *= 1.06;
      }
      
    }
  }
}

