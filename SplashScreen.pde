public class Splash implements Scene{
  
  int next;
  
  public void init(){
    next = 0;
  }
  
  public void onDraw(){
    background(0);
    tint(cycleColor());
    image(logo, 100, height/2-180, 900, 140);
    fill(255);
    textSize(60);
    text("Press Any Key to Begin", width/5-70, height/2+70);
    textSize(40);
    text("Controls: WASD or Arrow Keys to move", width/10, height/2+150);
  }
  
  public void onMouse(int b){
    next = 1;
  }

  public void onKey(int k){
    next = 1;
  }
  
  public int nextScene(){
    return next;
 
  }

color cycleColor() {
  color newColor;
  int cycle = frameCount*3 % 255;
  newColor = color(cycle, 255-cycle, cycle);
  
  return newColor;
}

}
