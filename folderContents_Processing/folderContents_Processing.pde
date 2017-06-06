
FolderContents folder;


void setup() {

  size(480, 360);
  
  // GET THE CONTENTS OF A FOLDER
  folder = new FolderContents( sketchPath() +"/data/");
  
  // PRINT TO THE CONSOLE THE CONTENTS OF THE FOLDER
  println("PRINT TO THE CONSOLE THE CONTENTS OF THE FOLDER");
  folder.print();
  
  // PRINT FOLDER FILE COUNT
  println("PRINT FOLDER FILE COUNT");
  println ( folder.count() );
  
  // GET AND PRINT FILE ABSOLUTE PATHS
  println("GET AND PRINT FILE ABSOLUTE PATHS");
  for ( int i =0; i < folder.count() ; i++ ) {
    
    String absolutePath = folder.getFileAbsolutePath( i );
    println( absolutePath );
  }
  
    // GET AND PRINT FILE NAMES 
  println("GET AND PRINT FILE NAMES");
  for ( int i =0; i < folder.count() ; i++ ) {
    
    String absolutePath = folder.getFileName( i );
    println( absolutePath );
  }

}

void draw() {
  background(0);
  
}