class RainDrop{
  float xDrop;
  float yDrop;
  float dropWidth;
  float dropHeight;
  boolean isVisible = false;
  PImage rainDrop;
  int rainDropType;
  float speed = 1.0f;
  
  RainDrop(float x, float y, float w, float h, int t){
    xDrop = x;
    yDrop = y;
    dropWidth = w;
    dropHeight = h;
    rainDropType = t;
    
  }
  void display(){
    if(rainDropType == 1){
      rainDrop = loadImage("good_raindrop.png");  
    }else if(rainDropType == 2){
      rainDrop = loadImage("bad_raindrop.png");
    }else if(rainDropType == 3){
      rainDrop = loadImage("star.png");
    }
   
    image(rainDrop,xDrop,yDrop);   
    if(yDrop > height){
      yDrop = -yDrop;
      if(rainDropType == 1){
        goodRain[(int)xDrop/ (int)dropWidth].isVisible = false; 
      }else if(rainDropType == 2){
        player.life--;
        badRain[(int)xDrop/ (int)dropWidth].isVisible = false; 
      }else if(rainDropType == 3){
         star[(int)xDrop/ (int)dropWidth].isVisible = false; 
      }
    }    
  }
}
