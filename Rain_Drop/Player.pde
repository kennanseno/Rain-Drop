class Player{
  
  String Name;
  float score = 0;
  float life = 5.0f;
  float xPos;
  float yPos;
  float playerWidth;
  float playerHeight; 
  float speed = 4;
  PImage playerUmbrella;
  
  //constructor
  Player(float xpos, float ypos, float w, float h){
    xPos = xpos;
    yPos = ypos;
    playerWidth = w;
    playerHeight = h;
  }   
  void moveLeft(){
    xPos = xPos - speed;
    if(xPos < -playerWidth){
      xPos = width;
    }
  }
  void moveRight(){
      xPos = xPos + speed;
      if(xPos > width+playerWidth){
        xPos -= (xPos+playerWidth);
      }
  }  
  void display(){
   playerUmbrella = loadImage("umbrella.png");
   
   image(playerUmbrella,xPos,yPos);
  } 
}
