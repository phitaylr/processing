
class LSystem{
  
  String first;
  String current;
  HashMap<Character, String> rules;
  int level;
  float angle;
  float startx, starty;
  float dist;
  
  LSystem(){
    level = 0;
    first = "A";
    current = first;
    angle = PI/3;
    rules = new HashMap<>();
    rules.put('A', "B-A-B");
    rules.put('B', "A+B+A");
    rules.put('+', "+");
    rules.put('-', "-");
    startx = .1*width;
    starty = .85*height;
    dist = .8*width;
  }
  
  void increment(){
     level++;
     String next = "";
     for(int i = 0; i < current.length(); i++){
       next += rules.get(current.charAt(i));
     }
     current = next;
     dist *= .5;
     println(current);
  }
  
  void display(){
     strokeWeight(45./(3*level+1));
     stroke(0, 0, 40*level);
     pushMatrix();
     translate(startx, starty);
     for(int i = 0; i < current.length(); i++){
       char op = current.charAt(i);
       if(op == 'A' || op == 'B'){
         line(0, 0, dist, 0);  
         translate(dist, 0);
       }else if (op == '+'){
         rotate(-angle);  
       }else if (op == '-'){
         rotate(angle);
       }
       
     }
     
     popMatrix();
  }
  
  
}
