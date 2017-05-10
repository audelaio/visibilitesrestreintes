
var vid;

var trackingTable; 
var trackingTableRowCount = 0;


function preload() {
   trackingTable = loadTable("assets/keyFrames_tracking.csv", "CSV","header");
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  // specify multiple formats for different browsers
  vid = createVideo('assets/fingers.mov');
  vid.loop(); // set the video to loop and start playing
  vid.hide(); // by default video shows up in separate dom
                  // element. hide it and draw it to the canvas
                  // instead
   
    
  trackingTableRowCount = trackingTable.getRowCount();
   
    
}

function draw() {
   
    // ATTENDRE QUE LE FICHIER A TERMINÉ 
    if (  isNaN( vid.duration() ) ) {
        print("loading");
    
    
    } else {
        
        image(vid,0,0,width,height  ); // draw the video frame to canvas

        // this.allTheData.getNum(this.lastRowSampled, "VALUE")
        fill(255);
        noStroke();
       var progress = vid.time()/vid.duration();
       text("Progress: "+Math.round(progress*100)+"%",30,30);
       var frame = Math.floor(progress*(trackingTableRowCount-1));
       text("Frame: "+frame,30,60);

       var x = trackingTable.getNum(frame, "x");
       var y = trackingTable.getNum(frame, "y"); 
       var percent = trackingTable.getNum(frame, "percent"); 
         
        fill(255);
        
        ellipse(x,y,percent);


    }
   
   
  
}

function windowResized() {
  resizeCanvas(windowWidth,windowHeight);
  

}
