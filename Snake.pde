int scene = 0;
final int SIZE = 12;
final int INIT_SPEED = 100;
final int MAX_SPEED = 30;
static String highScoreFile;
PImage logo;

Game gameScene = new Game(SIZE, INIT_SPEED, MAX_SPEED);
Splash menu = new Splash();
Scene[] scenes = {menu, gameScene};
Scene cScene;

void setup(){
  size(900,950);
  cScene = scenes[0];
  highScoreFile = dataPath("highscore.dat");
  logo = loadImage("logo.png");
}

void draw(){
  cScene.onDraw();
  
  int next = cScene.nextScene();
  if (next != scene){
   scene = next;
   cScene = scenes[scene];
   cScene.init();
  }
  
}

void keyPressed(){
  cScene.onKey(keyCode);
}

void mousePressed(){
 cScene.onMouse(mouseButton); 
}
