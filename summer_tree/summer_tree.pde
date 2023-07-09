

void setup(){
  size(1080, 1080);
  
}

void branch(float len, float initheight){
  strokeWeight(max(len/10., 1));
  stroke(255);
  line(0,0,0, len);
  if(len > 1){
    float rot = PI*pow(sin(frameCount/100.0), 2);
    float dir = .15*pow(cos(frameCount/100.0),2);;
    float newlen = map(initheight, height/5. - 30, height/5. + 30, .5, .7);
    pushMatrix();
    translate(0, len);
    rotate(PI/4 + rot);
    branch(len*(newlen+dir), initheight);
    popMatrix();
    pushMatrix();
    translate(0, len);
    rotate(-PI/4 - rot);
    branch(len*(newlen-dir), initheight);
    popMatrix();
  }
}

void draw(){
  float coldiff=30*sin(frameCount/100.);
  float hdiff = 25*pow(cos(frameCount/500.), 2);
  background(0, 100-coldiff, 225+30*sin(frameCount/100.));
  translate(width/2.7, height);
  rotate(PI);
  branch((float)height/4.2 + hdiff, (float)height/6 + hdiff);
  if(frameCount/500. < 2*PI){
     saveFrame("frames/######.png");
     println("saved frame "+ frameCount);
  }
}
