import controlP5.*;
float[] thingsX, thingsY;
int timer, level=1, tmr;
PImage balloon=requestImage("balloon.png");
PImage sky=requestImage("sky.png");
boolean menu=true, press;
PFont font;
ControlP5 cp5;
void setup() {
  fullScreen();
  frameRate(120);
  textSize(50);
  font=createFont("Arial", 20);
  cp5=new ControlP5(this);
  cp5.setFont(font);
  cp5.addButton("mode").setPosition(width-210, 10).setSize(200, 80)
    .setColorBackground(color(255, 224, 64)).setColorForeground(color(255, 255, 64));
  reset();
}
void draw() {
  background(160-timer/200, 190-timer/250, 255-timer/700);
  noStroke();
  fill(255, 0, 16);
  for (int i=0; i<70+level*20; i++) {
    circle(thingsX[i], thingsY[i]+timer/2, 40);
    if (dist(thingsX[i], thingsY[i])<60) reset();
  }
  fill(255, 0, 0, 160);
  circle(mouseX, height-250, 95);
  fill(255, 0, 0, 192);
  triangle(mouseX, height-210, mouseX-10, height-190, mouseX+10, height-190);
  if (timer>12000+level*1000) {
    level++;
    reset();
  }
  fill(255);
  text(timer/10+" m", 10, 60);
  text("Level "+level, 10, 120);
  timer+=15+level;
  if (menu) {
    menu();
    cp5.get(Button.class, "mode").setLabel("play");
  } else cp5.get(Button.class, "mode").setLabel("main menu");
  if (cp5.get(Button.class, "mode").isPressed()) {
    if (!press) menu=!menu;
    press=true;
  } else press=false;
}
void reset() {
  thingsX=new float[70+level*20];
  thingsY=new float[70+level*20];
  for (int i=0; i<70+level*20; i++) {
    thingsX[i]=random(0, width);
    thingsY[i]=random(-5000-level*500, -1000);
    timer=0;
  }
}
void menu() {
  image(sky, 0, -height/4.5, width, height+height/4.5);
  fill(255, 224, 64);
  text("С днём рождения, мой дорогой дядя!", 10, 10, 500, 1000);
  reset();
}
float dist(float x, float y) {
  return sqrt(sq(mouseX-x)+sq(height-250-y-timer/2));
}
