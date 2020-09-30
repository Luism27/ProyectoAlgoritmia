import controlP5.*;
import java.text.DecimalFormat;
ControlP5 cp5;
float X, Y, desp, x;
//PVector loc, vel,loc2,vel2;
PVector vel[],loc[],vel0[];
int limite = 500;
int Bx=250, By=250,limx=300,limy=300;
int rad = 15;
int n = 0;
double press = 1,temp=0,R = 0.08205746 ; 
boolean stop = false;
void setup(){
  PFont font = createFont("arial",20);
  size(800,720);
  smooth(8);
  cp5 = new ControlP5(this);
  cp5.addTextfield("Número de particulas")
     .setPosition(Bx+20,100)
     .setSize(Bx,40)
     .setFont(font)
     .setFocus(false)
     .setText(""+n)
     .setColor(color(255,255,255))
     .setColorBackground(0)
     //.setColorActive(0,255,0)
     ;
  loc = new PVector[limite];
  vel = new PVector[limite];
  vel0 = new PVector[limite];
  config();
  X = width/2;
  Y = height/2;
}

void draw(){
  background(0);
  recipiente();
  particulas();
  cantidad();
}
void cantidad(){
  try{
  String text = cp5.get(Textfield.class,"Número de particulas").getText();
  n = Integer.parseInt(text);
  if (n > limite){
    n = limite;
    println("Limite alcanzado, no se puede crear mas de "+limite+" Particulas");
  }
  } catch(Exception e){
    print(e);
  }
}
void config(){
  for (int i = 0;i<limite;i++){
    int random1 = (int) Math.floor(Math.random()*70+1);
    int random2 = (int) Math.floor(Math.random()*70+1);
    float random3 = (float)  Math.floor(Math.random()*(3-1+1)+1);
    float random4 =  (float) Math.floor(Math.random()*(3-1+1)+1);
    loc[i]= new PVector(width/2 + random1 ,height/2 + random2);  
    vel[i] = new PVector(random3,random4);
    vel0[i] = new PVector(0.0,0.0);
    
  }
}
void particulas(){
  
  for(int i = 0;i<n;i++){
    if(!stop){
      loc[i].add(vel[i]);
    } else{
      loc[i].add(vel0[i]);
    }
    
    if ((loc[i].x >= Bx+limx-rad) || (loc[i].x <= Bx+rad)) {
    vel[i].x = vel[i].x * -1;
    }
    if ((loc[i].y > By+limy-rad)|| (loc[i].y< By+rad)) {
      vel[i].y = vel[i].y * -1; 
    }
  }
  noStroke();
  fill(255,0,0);
  for(int i = 0; i < n; i ++){
    circle(loc[i].x,loc[i].y,rad);
  } 
}

int manx = 200, many= 325, extx=50,exty=150;

void recipiente(){
  strokeCap(ROUND);
  strokeJoin(ROUND);
  strokeWeight(10);
  stroke(250);
  fill(0);
  rect(Bx,By, limx, limy, 7);
  strokeWeight(4);
  rect(manx,many,extx,exty);
  textSize(26);
  fill(255);
  double volumen = limx*limy*300;
  double litros = volumen*1*Math.pow(10,-6);
  DecimalFormat formato = new DecimalFormat("#.000");
  temp = (press*litros)/(n*R);
  text("Volúmen: ("+limx+"x"+limy+"x300)mm="+volumen+"mm^3="+formato.format(litros)+"L",25,600);
  text("Temperatura: "+formato.format(temp)+"K",25,650);
  text("Presión: "+press+"atm",25,700);
  
}
void mouseDragged(){
  if (mouseX >manx-10 && mouseX < manx+10 && mouseY > many-10 && mouseY < many+exty){
    stop = true;
    manx = mouseX;
    Bx = mouseX +50;
    limx = 550-Bx;
    println("ancho: "+limx);
    if(limx < 120){
        limx=120;
        Bx = 550-limx;
        manx = Bx-50;
    }
    if (limx > 500){
        limx=500;
        Bx = 550-limx;
        manx = Bx-50;
    }
  }
}
void mouseReleased(){
  stop = false;
  for (int i = 0; i<n;i++){
    while (loc[i].x <= Bx+15){
      loc[i].x = loc[i].x + 50;
    }
  }
}
