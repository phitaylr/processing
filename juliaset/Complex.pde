

public class Complex {

  float a, b;

  public Complex(float real, float imag) {
    a = real;
    b = imag;
  }

  public Complex squared() {
    return new Complex(a*a-b*b, 2*a*b);
  }
  
  public Complex add(Complex c){
    return new Complex(a+c.a, b + c.b);
  }
  
  public float abs(){
     return dist(a, b, 0, 0); 
  }
  
}
