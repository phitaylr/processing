

class Complex{
   double a, b;
   Complex(double a, double b){ //constructor
       this.a = a;
       this.b = b;
   }
   
   Complex add(Complex z){
     return new Complex(a + z.a, b + z.b);
   }
   
   Complex multiply(Complex z){
     return new Complex(a*z.a - b*z.b, b*z.a + a*z.b); 
   }
   
   double magnitude(){
     return Math.sqrt(a*a+b*b);
   }
  
}
