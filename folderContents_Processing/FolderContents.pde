import java.io.File;

class FolderContents {

  File [] files;
  File dir;
  String path;

  FolderContents(String path) {
    this.path = path;
    dir = new File(path);

    files = dir.listFiles();
  }

  int count() {
    return files.length;
  }


  String getFileAbsolutePath(int index) {
    return files[index].getAbsolutePath();
  }
  
  
  String getFileName(int index) {
    return files[index].getName();
  }

  void print() {
    for ( int i =0; i < folder.count(); i++ ) {
      println( folder.getFileName(i));
    }
  }
  
}