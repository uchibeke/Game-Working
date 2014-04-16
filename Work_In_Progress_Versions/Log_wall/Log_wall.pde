ArrayList<Log> logs;
int i;
int j;
int limit;
int time;
int score;
int dead;
boolean loss;

void setup() {
    size(700, 500);
    i = 0;
    logs = new ArrayList<Log>();
    limit = 4;
    score = 0;
    time = 2400;
    loss = false;
    dead = 0;
    while (i < 4){
        logs.add(new Log(i));
        i += 1;
    }
    textSize(64);
}

void draw() {
    background(100,100,200);
    for (Log d: logs) {
        d.drawLog();
    }
    //timer
    fill (244, 0, 50);
    text(time/60, 130, 200);
    
    //dead loggs
      if (dead >= 1) {
        fill(200, 100, 60);
        strokeWeight(1);
        noStroke();
        ellipse(400, height, 100, 100); 
      }
      if (dead >= 2) {
        fill(200, 100, 60);
        strokeWeight(1);
        noStroke();
        ellipse(500, height, 100, 100);
      }
      if (dead >= 3) {
        fill(200, 100, 60);
        strokeWeight(1);
        noStroke();
        ellipse(600, height, 100, 100);
      }
        
    
    // remove destroyed logs
    for (i=0; i<logs.size(); i++) {
        if (logs.get(i).hurt) {
          background(100,100,200);
          fill (244, 0, 50);
          text("The falling log", 130, 200);
          text("pushed you back!", 100, 250);
          text("Press any key", 150, 350);
          if (keyPressed == true)
            exit();
        }
        if (logs.get(i).finished) {
            logs.remove(i);
            score += 1;
            dead += 1;
                for (j=0; j<logs.size(); j++) {
                    if (j>=i)
                        logs.get(j).moveDown();
                }
        }
    }
    if (score >= 4) {
      background(100,100,200);
      fill (244, 0, 50);
      text("Success!", 220, 200);
      text("Press any key", 150, 250);
      if (keyPressed == true)
        exit();
    }
    
    time -= 1;
    if (time <= 0) {
      background(100,100,200);
      fill (244, 0, 50);
      text("Guards arived, RUN!", 40, 200);
      text("Press any key to run", 40, 300);
      if (keyPressed == true)
        exit();
    }
}

void mousePressed() {
  float distance;
  for (i=0; i<logs.size(); i++) {
      distance = dist(mouseX, mouseY, logs.get(i).x, logs.get(i).y);
      if (distance < 50){
          logs.get(i).x += 20;
          for (j=0; j<logs.size(); j++) {
              logs.get(j).wiggle();
          }
      }
   }    
}
