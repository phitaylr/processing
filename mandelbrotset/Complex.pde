

class Complex{
   float a, b;
   Complex(float a, float b){ //constructor
       this.a = a;
       this.b = b;
   }
   
   Complex add(Complex z){
     return new Complex(a + z.a, b + z.b);
   }
   
   Complex multiply(Complex z){
     return new Complex(a*z.a - b*z.b, b*z.a + a*z.b); 
   }
   
   float magnitude(){
     return sqrt(a*a+b*b);
   }
  
}
