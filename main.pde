class Game implements Scene{
  
  Board board;
  boolean lost;
  int time;
  int nextTime;
  
  Game(int size, int is, int ms){
    board = new Board(size, is, ms);
    lost = false;
    time = millis();
  }
  
  public void init(){
    board.initialize();
    nextTime = millis() + board.getSpeed();
  }
  
  public void onDraw(){
    board.render();
    time = millis();
    if (!lost){
      if (time >= nextTime){
        lost = board.makeMove();
        nextTime = millis() + board.getSpeed();
      }
    }else{
      board.renderLost();
    }
  }
  
  
  //Unused
  public void onMouse(int b){
    return;
  }
  //Will get input and return the thing
  public void onKey(int k){
    if (!lost){
      board.processMove(k);
    }else{
      if (board.reset(k)){
        lost = false;
      }
    }
  }
  
  public int nextScene(){
    return 1;
  }
  
}
