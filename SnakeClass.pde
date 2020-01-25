public class Board{
  
  final color PINK = (#FF31FC);
  final color ORANGE = (#FF9531);
  final color FAZE_BLUE = (#8888FF);
  final color FAZE = (#004444);
  
  int size;
  int tileSize;
  int score;
  int highscore;
  int speed;
  int initSpeed;
  int maxSpeed;
  ArrayList<Tile> snake;
  PVector food;
  //BufferedReader reader;
  
  Board(int s, int is, int ms){
    size = (s >= 3) ? s : 3;
    tileSize = round(600 / size);
    initSpeed = is;
    maxSpeed = ms;
    snake = new ArrayList<Tile>();
  }
  
  void initialize(){
    speed = initSpeed;
    score = 0;
    int startPoint = (int)Math.ceil(size/2);
    snake.add(new Tile());
    snake.get(0).setPos(new PVector(startPoint, startPoint));
    makeFood();
    if (!new File(highScoreFile).exists()) {
     saveBytes(highScoreFile, new byte[1]);
    }
    highscore = int(loadBytes(highScoreFile)[0]);
  }
  
  void makeFood(){
   int x = round(random(0, size-1));
   int y = round(random(0, size-1));
   food = new PVector(x, y);
  }
  
  //Make the snake orange and pink lol
  void render(){
    background(0);
    fill(255);
    rect(0,0, width, height-width);
    for (int i = 0; i < snake.size(); ++i){
      color fill = (i % 2 == 0) ? color(ORANGE) : color(PINK);
      //Snake
      int pointX = (int)snake.get(i).getPos().x * tileSize;
      int pointY = (int)snake.get(i).getPos().y * tileSize + (height-width);
      fill(fill);
      rect(pointX, pointY, tileSize, tileSize);
    }
    
    //Food
    fill(FAZE_BLUE);
    int pointX = (int)food.x * tileSize;
    int pointY = (int)food.y * tileSize + (height-width);
    rect(pointX, pointY, tileSize, tileSize);
    
    //UI
    textSize(45);
    fill(0);
    text("Score: " + score, width/5, 45);
    int modSpeed = (speed*-1) + initSpeed + 1;
    text("Speed: " + modSpeed, width/1.5, 45);
    
  }
  
  void renderLost(){
   textSize(50);
   fill(ORANGE + FAZE);
   text("Oof! You Lost!", width/3, height/2);
   
   textSize(30);
   
   text(("Your Score: " + score + "\nHigh Score: " + highscore), width/3, height/2+50);
   
   if (score > highscore) {
     byte[] tempHighScore = {byte(score)};
     saveBytes(highScoreFile, tempHighScore);
     fill(PINK + FAZE);
     text("A new high score! Congratulations!", width/3, height/2+170);
     fill(ORANGE + FAZE);
   }
   
   text("Press enter to try again!", width/3, height/2+240);
   
  }
  
  void processMove(int k){
    
    PVector newDir;
    PVector oldDir = snake.get(0).getDir();
    
    switch (k){
     case LEFT:
     case 'A':
       newDir = new PVector(-1, 0);
       break;
     case UP:
     case 'W':
       newDir = new PVector(0, -1);
       break;
     case RIGHT:
     case 'D':
       newDir = new PVector(1, 0);
       break;
     case DOWN:
     case 'S':
       newDir = new PVector(0, 1);
       break;
     default:
       return;
    }
    
    if (newDir.x + oldDir.x == 0 && newDir.y + oldDir.y == 0){
     return; 
    }
    
    snake.get(0).setNextDir(newDir);
    
  }
  
  boolean makeMove(){
    for (int i = 0; i < snake.size(); ++i){
      snake.get(i).setDir(snake.get(i).getNextDir());
      PVector p = snake.get(i).getPos();
      PVector m = snake.get(i).getDir();
      if (!moveIsValid(p, m)){
        return true;
      }
      snake.get(i).setPos(new PVector(p.x + m.x, p.y + m.y));
      if (i != 0){
       PVector newDir = snake.get(i-1).getDir();
       snake.get(i).setNextDir(newDir);
       
      }
    }
    
    if (snake.get(0).getPos().x == food.x && snake.get(0).getPos().y == food.y){
     int l = snake.size() - 1;
     PVector endDir = snake.get(l).getDir();
     PVector endPos = snake.get(l).getPos();
     PVector newPos = new PVector(endPos.x - endDir.x, endPos.y - endDir.y);
     snake.add(new Tile(newPos, endDir));
     makeFood();
     speed = (speed - 3 >= maxSpeed) ? speed - 3 : maxSpeed;
     ++score;
    }
    
    return false;
    
  }
  
  boolean moveIsValid(PVector p, PVector m){
   for (int i = 1; i < snake.size(); ++i){
     if (snake.get(0).getPos().x == snake.get(i).getPos().x && snake.get(0).getPos().y == snake.get(i).getPos().y){
       return false;
     }
   }
   return (p.x * tileSize + m.x * tileSize < 0 || p.x * tileSize + m.x * tileSize > width-tileSize) 
   || (p.y * tileSize + m.y * tileSize < 0 || p.y * tileSize + m.y * tileSize > height-(height-width)-tileSize) 
   ? false : true;
  }
  
  boolean reset(int k){
   if (k == ENTER){
     snake = new ArrayList<Tile>();
     initialize();
     return true;
   }
   return false;
  }
  
  int getSpeed(){
   return speed;
  }
  
}

public class Tile{
  PVector position;
  PVector direction;
  PVector nextDirection;
  
  Tile(){
    direction = new PVector(0,0);
    nextDirection = new PVector(0, 0);
  }
  
  Tile(PVector p, PVector d){
   position = p;
   direction = d;
   nextDirection = d;
  }
  
  
  PVector getDir(){
   return direction; 
  }
  
  void setDir(PVector d){
   direction = d; 
  }
  
  PVector getPos(){
   return position; 
  }
  
  void setPos(PVector p){
   position = p; 
  }
  
  PVector getNextDir(){
   return nextDirection; 
  }
  
  void setNextDir(PVector d){
    nextDirection = d;
  }
  
}
