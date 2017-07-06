


FittedContext context;

void setup() {
  
   // SET ANY SCREEN SIZE, EVEN FULLSCREEN
  size(1500,700);
  //fullScreen();
  // AND THE CONTEXT OF 1376x448 PIXELS WILL FIT (SCALE AND TRANSLATE KEEPING RATIO) TO IT
   context = new FittedContext(this,1376,448);
  
  
}

void draw() {
  
  // ENTER THE FITTED CONTEXT
  context.enter();
  
  // FILL THE WHOLE WINDOW
  fill(255,0,0);
  rect(context.windowLeft, context.windowTop, context.windowWidth, context.windowHeight);
  
  // FILL ONLY THE FITTED AREA
  fill(0,255,0);
  rect(0, 0, context.width, context.height);
  
  // DRAW ON THE AREA WITH A FIXED RESOLUTION OF 1375 BY 448
  fill(0,0,255);
  textAlign(CENTER,CENTER);
  textSize(64);
  text("CENTER TO AREA OF 1376x448", 1375*0.5, 448*0.5); 
  
 
  // EXIT THE FITTED CONTEXT
  context.exit();
  
}