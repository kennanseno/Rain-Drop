class BackgroundObject{
  
  
  
  
  void displayFlowersAndClouds(){
    
  PImage cloud = loadImage("cloud.png");
  PImage red_flower = loadImage("red_flower.png");
  PImage blue_flower = loadImage("blue_flower.png");
  PImage pink_flower = loadImage("pink_flower.png");
  
 //display flowers
  image(red_flower,0,450);
  image(blue_flower,50,450);
  image(pink_flower,100,450);
  image(red_flower,150,450);
  image(blue_flower,200,450);
  image(pink_flower,250,450);
  image(red_flower,300,450);
  image(blue_flower,350,450);
  image(pink_flower,400,450);
  image(red_flower,450,450);
  
  //display clouds
  image(cloud,0,-25);
  image(cloud,75,-30);
  image(cloud,180,-10);
  image(cloud,240,-30);
  image(cloud,360,-15); 
  image(cloud,450,-5);
  image(cloud,550,-25);
}

  void displayStat(){
    tint(255,126);
    overlay.resize(200,200);
    image(overlay,150,150);
    noTint();
 
   fill(0);
   textFont(textFont);
   text("Level: " + (int)level,200,210);
   fill(0);
   textFont(textFont);
   text("Score: " + (int)player.score,200,250);
   fill(0);
   textFont(textFont);
   text("Life: " + (int)player.life,200,290);   
  }
void displayTutorial(){
   tint(255,126);
   overlay.resize(300,200);
   image(overlay,100,150);
   noTint();
   
   fill(0);
   textFont(textFont);
   text("Controls: ",110,170);
   fill(0);
   textFont(textFont);
   text("'A' to move left",160,210);
   fill(0);
   textFont(textFont);
   text("'D' to move right",160,240);
   fill(0);
   textFont(textFont);
   text("'TAB' to view score",160,270);
   
   fill(0);
   textFont(textFont);
   text("Press 'Space' to continue",110,340);
   
   if(keyPressed){
     if(key == ' '){
       tutorial = false;
     }
   }
   
  
}  

}
