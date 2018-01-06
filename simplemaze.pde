ball player;
wall[] walls; 
 
void setup() {
  size(750, 750);
  player = new ball(20,20);
  walls = new wall[5];
  walls[0] = new wall(0,100,40,40);
  walls[1] = new wall(100,200,40,40);
  walls[2] = new wall(200,300,40,40);
  walls[3] = new wall(300,400,40,40);
  walls[4] = new wall(400,500,40,40);
} 

void draw() {
  background(255, 255, 255); 
  noStroke(); 
  player.draw();
  player.move(walls);
  for(int i = 0; i < walls.length; i++){
    walls[i].draw();
  }
}

class ball {
  float x;
  float y;
  ball(float _x, float _y){
    x = _x;
    y = _y;
  }
  void draw(){
    fill(128);
    ellipse(x,y,25,25);
  }
  void move(wall[] walls){
    float possibleX = x;
    float possibleY = y;
    if (keyPressed==true) { 
      if (key=='a') { 
        possibleX= possibleX - 5;
      } 
      if (key=='d') { 
        possibleX = possibleX + 5;
      } 
      if (key=='w') { 
        possibleY = possibleY - 5;
      } 
      if (key=='s') { 
        possibleY = possibleY + 5;
      }
    }
    boolean didCollide = false;
    for(int i = 0; i < walls.length; i++){
      if(possibleX > walls[i].x && possibleX < (walls[i].x + walls[i].w) && possibleY > walls[i].y && possibleY < walls[i].y + walls[i].h){
        didCollide = true;
      }
    }
    if(didCollide == false){
      x = possibleX;
      y = possibleY;
    }
    if(didCollide == true){
      x = 20;
      y = 20;
    }
  }
}
 
class wall {
  float x;
  float y;
  float w;
  float h;
  wall(float _x, float _y, float _w, float _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  void draw(){
    fill(0);
    rect(x,y,w,h);
    //if (keyPressed == true) {
    //  if (key == 'z') {
    //    y -= 5;
    //  }
    //}
    y -= 1;
  }
}