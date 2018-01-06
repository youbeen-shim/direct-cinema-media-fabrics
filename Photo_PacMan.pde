import processing.serial.*;

wall[] walls; 

Serial myPort;
String inString;
int lf = 10;

String[] photoSensorRead;
float n;

float radius2 = 50;
float radius = 15;
int direction = 1;
int direction2 = 0;
 
float x = 150;
float y = 150;
float speed = 5.0;
float speedtwo = 5.0;

ArrayList<Particle> poop = new ArrayList();
 
void setup() {
  size(1280, 720);
  ellipseMode(RADIUS);
  for (int i=0; i<50; i++) {
    Particle P = new Particle((int)random(width), (int)random(height));
    poop.add(P);
  }
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil(lf); 
  walls = new wall[11];
  walls[0] = new wall(0,100,40,40);
  walls[1] = new wall(300,400,40,40);
  walls[2] = new wall(400,400,40,40);
  walls[3] = new wall(500,600,40,40);
  walls[4] = new wall(600,200,40,40);
  walls[5] = new wall(700,600,40,40);
  walls[6] = new wall(800,100,40,40);
  walls[7] = new wall(900,500,40,40);
  walls[8] = new wall(1000,600,40,40);
  walls[9] = new wall(1100,100,40,40);
  walls[10] = new wall(1200,500,40,40);
}
 
void draw() {
  background(255);
  fill (0, 175, 255);
  smooth ();
  noStroke();
  render();
  for(int i = 0; i < walls.length; i++){
    walls[i].draw();
  }
  photoSensorRead = split(inString, '=');
  if (photoSensorRead.length > 1) {
   String num = photoSensorRead[1];
   n = float(Integer.parseInt(num.trim()));
  } 
  radius = map(n, 0.0, 1024.0, 0.0, 100.0);
  for (int i=0;i<poop.size();i++) {
    Particle Pn = (Particle) poop.get(i);
    Pn.display();
    if (dist(x, y, Pn.x, Pn.y)<radius) {
      poop.remove(i);
    }
  }
}
 
class Particle {
  int x, y;
  Particle(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void display() {
    noStroke();
    fill(#FCA900);
    ellipse(x, y, 10, 10);
  }
}

void serialEvent(Serial p) {
 inString = p.readString();
} 
 
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      x = x - 10;
      direction = -1;
      direction2 = 0;
    }
    else if (keyCode == RIGHT) {  
      x = x + 10;
      direction = 1;
      direction2 = 0;
    }
    else if (keyCode == UP) {
      y = y - 10;
      direction = 0;
      direction2 = -1;
    }
    else if (keyCode == DOWN) { 
      y = y + 10;
      direction = 0;
      direction2 = 1;
    }
       boolean didCollide = false;
    for(int i = 0; i < walls.length; i++){
      if(x > walls[i].x && x < (walls[i].x + walls[i].w) && y > walls[i].y && y < walls[i].y + walls[i].h){
        didCollide = true;
      }
    }
    if(didCollide == false){
      x = x;
      y = y;
    }
    if(didCollide == true){
      x = 150;
      y = 150;
    }
  }
}
 
 
void render() { //tge mouth moving
  for ( int i=-1; i < 2; i++) {
    for ( int j=-1; j < 2; j++) {
      pushMatrix();
      translate(x + (i * width), y + (j*height));
      if ( direction == -1) { 
        rotate(PI);
      }
      if ( direction2 == 1) { 
        rotate(HALF_PI);
      }
      if ( direction2 == -1) { 
        rotate( PI + HALF_PI );
      }
      arc(0, 0, radius, radius, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
      popMatrix();
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
    speed = map(n, 0.0, 1024.0, 0.0, 20.0);
    speedtwo = speed/3;
    y -= speedtwo;
    if (y < 0){
      y = height;
    }
  }
}