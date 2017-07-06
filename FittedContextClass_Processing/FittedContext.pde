class FittedContext {
  
  float width, height;
  float scale;
  private float scaleX,scaleY;
  private float left,top;
  float windowLeft,windowTop;
  float windowBottom,windowRight;
  float windowWidth, windowHeight;
  float mouseX, mouseY;
  PApplet parent;
  //float width,height;
  
  
  FittedContext(PApplet parent, float originalWidth, float originalHeight) {
    this.parent = parent;
    this.width = originalWidth;
    this.height = originalHeight;
    calculate();
  }
  
   private void calculate() {
     scaleX = parent.width/this.width;
     scaleY = parent.height/this.height;
     scale = min(scaleX, scaleY);
     left = 0;
     top = 0;
     windowLeft = -((parent.width/scale)-this.width)*0.5;;
     windowTop = -((parent.height/scale)-this.height)*0.5;
     windowWidth = parent.width / scale;
     windowHeight= parent.height / scale;
     windowBottom = windowHeight + windowTop;
     windowRight = windowWidth + windowLeft ;
     
     
  }
  
  
  void enter() {
    pushMatrix();
    calculate();
    scale(scale);
    translate(-windowLeft,-windowTop);
    this.mouseX = parent.mouseX / scale + windowLeft;
    this.mouseY = parent.mouseY / scale + windowTop;
  }
  
  
  void exit() {
    popMatrix();
  }
  
  
 
}