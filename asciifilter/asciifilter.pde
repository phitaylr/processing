PImage img;
String chars = "  \"\\-\'+*#%@";  


void setup(){
  img = loadImage("perry.png");
  img.resize(80, 40);
  //img.filter(GRAY);
  //img.filter(THRESHOLD);
  surface.setSize(img.width, img.height);
  noLoop();
}

void draw(){
  image(img, 0,0);
  for(int y = 0; y < height; y++){
    for(int x= 0; x < width; x++){
     
        color pcolor = get(x, y);
        int value = (int) (red(pcolor) + green(pcolor) + blue(pcolor))/3;
                //int value = (int) max(red(pcolor) , green(pcolor) , blue(pcolor));
        //int value = (int)red(pcolor);
        char pix = chars.charAt((int)map(value, 0, 255,0,chars.length()-1));
        print(pix);
     }
     print("\n");
  }
  
}
