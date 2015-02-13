/*
  Created: Oct. 2014
  Goal:
  1. Evade normal raindrops
  2. Block acid/red raindrops
  3. block falling stars for +1 life(optional)
  
  add more functions:
  - make flowers the life counter, 
  dissapears when hit by acid rain - suggestion by bleachorage.
*/

import ddf.minim.*;

Minim minim;
AudioPlayer audio;
AudioPlayer starAudio;

Player player;
BackgroundObject object = new BackgroundObject();
RainDrop[] goodRain = new RainDrop[20];
RainDrop[] badRain = new RainDrop[20];
RainDrop[] star = new RainDrop[20];

float playerSize,boxSize;
float goodRainCount,badRainCount,level,starCount;
PImage farm,overlay,title,gameover;
PFont textFont;
boolean stat,play,onPause,tutorial;

void setup(){
  size(500,500);
  playerSize = width/10.0f;
  boxSize = width/20.0f;
  goodRainCount = 1.0f;
  badRainCount = 1.0f;
  starCount = 1.0f;
  stat = false;
  play = false;
  tutorial = true;
  level = 1.0f;
  
  minim = new Minim(this);
  audio = minim.loadFile("blop.mp3");
  starAudio = minim.loadFile("star_sound.mp3");
  
  textFont = loadFont("ShowCardGothic.vlw");
  gameover = loadImage("gameover.png");
  farm = loadImage("farm.png");
  title = loadImage("rain_drop.png");
  farm.resize(500,500);
  overlay = loadImage("overlay.png");
  
  
  player = new Player(0,height-(playerSize*2),playerSize,playerSize);
  //populate goodRain array object
  for(int i = 0; i < goodRain.length; i++){
    goodRain[i] = new RainDrop(i*boxSize,0,boxSize,boxSize+5,1);
  }
  //populate badRain array object
  for(int i = 0; i < badRain.length; i++){
    badRain[i] = new RainDrop(i*boxSize,0,boxSize,boxSize,2);
  }
  //populate stars
  for(int i = 0; i < star.length; i++){
    star[i] = new RainDrop(i*boxSize,0,boxSize,boxSize+5,3);
  }
  
}

void draw(){ 
 background(farm);
  
 if(play == false){
    menu();
 }else{
   if(tutorial == true){
     object.displayTutorial();
   }else{
     if(player.life > 0){
      playGame();
     }else{
      gameOver();
     }
   }
 }

  object.displayFlowersAndClouds();
}

void menu(){
  image(title,150,175);
  
  fill(0);
  textFont(textFont);
  text("Press 'Enter' to Play",130,300);
  
  if(keyPressed){
    if(key == ENTER){
      play = true;
    }
  }
   
}

void playGame(){

  //normal rain spawn code
  if(goodRainCount % 40 == 0){
    int goodRainRan = (int)random(20);
   
    goodRain[goodRainRan].isVisible = true;
    goodRainCount = 1;
  }else{
    goodRainCount++;
  }
    
  for(int i = 0; i < goodRain.length; i++){
    if(goodRain[i].isVisible == true){
      goodRain[i].display();
    }
  }

  //acid rain spawn code
  if(badRainCount % 150 == 0){  
    int badRainRan  = (int)random(20);

    badRain[badRainRan].isVisible = true;
    badRainCount = 1;   
  }else{
    badRainCount++;
  }
  
  for(int i = 0; i < badRain.length; i++){
    if(badRain[i].isVisible == true){
      badRain[i].display();
    }
  }
  
  //star spawn code
  //acid rain spawn code
  if(starCount % height == 0){  
    int starRan  = (int)random(20);

    star[starRan].isVisible = true;
    starCount = 1;   
  }else{
    starCount++;
  }
  
  for(int i = 0; i < star.length; i++){
    if(star[i].isVisible == true){
      star[i].display();
    }
  }
  
  player.display();
  update();
  
  //display stats if true
  if(stat == true){
    object.displayStat();  
  } 
}

void update(){
  //update normal rain
  for(int i = 0; i < goodRain.length; i++){   
    if(goodRain[i].isVisible == true){
      goodRain[i].yDrop += goodRain[i].speed;
      //Box collision code here
      if(goodRain[i].xDrop+goodRain[i].dropWidth > player.xPos && goodRain[i].xDrop < player.xPos+playerSize && goodRain[i].yDrop+goodRain[i].dropHeight > player.yPos && goodRain[i].yDrop < player.yPos+playerSize-10){
        goodRain[i].yDrop = 0;
        goodRain[i].isVisible = false;
        player.life--;
        audio.play();
        audio.rewind();
      }     
    }
    //update acid rain
    if(badRain[i].isVisible == true){
      badRain[i].yDrop += badRain[i].speed;
      //Box collision code here
      if(badRain[i].xDrop+badRain[i].dropWidth > player.xPos && badRain[i].xDrop < player.xPos+playerSize && badRain[i].yDrop+(badRain[i].dropHeight-10) > player.yPos && badRain[i].yDrop< player.yPos+ playerSize-10){
        badRain[i].yDrop = 0;
        badRain[i].isVisible = false;
        player.score++;
        audio.play();
        audio.rewind();
      }
    }
      //acid rain speed depends on game level and game leve increments per 5 score
     level = (player.score/5.0f)+1.0f;
     badRain[i].speed = level/2.0f;
     
     //update star
     if(star[i].isVisible == true){
      star[i].yDrop += (2*star[i].speed);
      //Box collision code here
      if(star[i].xDrop+star[i].dropWidth > player.xPos && star[i].xDrop < player.xPos+playerSize && star[i].yDrop+(star[i].dropHeight-10) > player.yPos && star[i].yDrop< player.yPos+ playerSize-10){
        star[i].yDrop = 0;
        star[i].isVisible = false;
        player.life += 1.0f;
        starAudio.play();
        starAudio.rewind();
      }
    }
    //check variables
    println("badRainSpeed: " + badRain[i].speed);    
    }
}

void keyPressed(){
   if(key == 'a' || key == 'A'){
      player.moveLeft();
    }else if(key == 'd' || key == 'D'){
      player.moveRight();
    }else if(key == TAB){
      stat = !stat;
    }
}

void gameOver(){
   image(gameover,120,100);
  
   fill(0);
   textFont(textFont);
   text("Level: " + (int)level,200,220);
   fill(0);
   textFont(textFont);
   text("Score: " + (int)player.score,200,250);
   fill(0);
   textFont(textFont);
   text("Press 'Esc' to return to menu",80,320);
   fill(0);
   textFont(textFont);
   text("Press 'Enter' to play again",100,350);
   
   if(keyPressed){
    if(key == ESC || key == ENTER){
      play = false;
      player.score = 0;
      player.life = 5;
      
      for(int i = 0; i < goodRain.length; i++){
        goodRain[i] = new RainDrop(i*boxSize,0,boxSize,boxSize+5,1);
      }
     
      for(int i = 0; i < badRain.length; i++){
        badRain[i] = new RainDrop(i*boxSize,0,boxSize,boxSize,2);
      }
      
    }
  }
     
}






