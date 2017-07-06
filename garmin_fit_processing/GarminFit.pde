import com.garmin.fit.*;
import java.io.FileInputStream;
import java.io.InputStream;

class GarminFit {

  ArrayList<Entry> distance = new ArrayList();
  ArrayList<Entry> gyroscope = new ArrayList();
  ArrayList<Entry> accelerometer = new ArrayList();
  ArrayList<Entry> magnetometer = new ArrayList();
  ArrayList<Entry> gps = new ArrayList();

  GarminFit(String fitFile) {

    Decode decode = new Decode();

    MesgBroadcaster mesgBroadcaster = new MesgBroadcaster( decode );
    Listener listener = new Listener();
    FileInputStream in;

    String file =  sketchPath("") + "/" +  fitFile;//"/2017-05-13-17-09-44.fit";


    try {
      in = new FileInputStream(  file  );
    } 
    catch ( java.io.IOException e ) {
      throw new RuntimeException( "Error opening file " + args[0] + " [1]" );
    }

    try {
      if ( !decode.checkFileIntegrity( (InputStream) in ) ) {
        throw new RuntimeException( "FIT file integrity failed." );
      }
    } 
    catch ( RuntimeException e ) {
      System.err.print( "Exception Checking File Integrity: " );
      System.err.println( e.getMessage() );
      System.err.println( "Trying to continue..." );
    } 
    finally {
      try {
        in.close();
      } 
      catch ( java.io.IOException e ) {
        throw new RuntimeException( e );
      }
    }

    try {
      in = new FileInputStream( file );
    } 
    catch ( java.io.IOException e ) {
      throw new RuntimeException( "Error opening file " + args[0] + " [2]" );
    }

    mesgBroadcaster.addListener( (FileIdMesgListener) listener );
    mesgBroadcaster.addListener( (UserProfileMesgListener) listener );
    mesgBroadcaster.addListener( (DeviceInfoMesgListener) listener );
    mesgBroadcaster.addListener( (MonitoringMesgListener) listener );
    mesgBroadcaster.addListener( (RecordMesgListener) listener );
    mesgBroadcaster.addListener( (CameraEventMesgListener) listener );
    mesgBroadcaster.addListener( (GyroscopeDataMesgListener) listener );
    mesgBroadcaster.addListener( (AccelerometerDataMesgListener) listener );
    mesgBroadcaster.addListener( (MagnetometerDataMesgListener) listener );
    mesgBroadcaster.addListener( (GpsMetadataMesgListener) listener );

    decode.addListener( (DeveloperFieldDescriptionListener) listener );

    try {
      decode.read( in, mesgBroadcaster, mesgBroadcaster );
    } 
    catch ( FitRuntimeException e ) {
      // If a file with 0 data size in it's header  has been encountered,
      // attempt to keep processing the file
      if ( decode.getInvalidFileDataSize() ) {
        decode.nextFile();
        decode.read( in, mesgBroadcaster, mesgBroadcaster );
      } else {
        System.err.print( "Exception decoding file: " );
        System.err.println( e.getMessage() );

        try {
          in.close();
        } 
        catch ( java.io.IOException f ) {
          throw new RuntimeException( f );
        }

        return;
      }
    }

    try {
      in.close();
    } 
    catch ( java.io.IOException e ) {
      throw new RuntimeException( e );
    }

    System.out.println( "Decoded FIT file " + file + "." );
  }

  class Listener implements FileIdMesgListener, UserProfileMesgListener, DeviceInfoMesgListener, MonitoringMesgListener, RecordMesgListener, DeveloperFieldDescriptionListener, CameraEventMesgListener, GyroscopeDataMesgListener, AccelerometerDataMesgListener, MagnetometerDataMesgListener , GpsMetadataMesgListener {

    @Override
      public void onMesg( FileIdMesg mesg ) {
      System.out.println( "File ID:" );

      if ( mesg.getType() != null ) {
        System.out.print( "   Type: " );
        System.out.println( mesg.getType().getValue() );
      }

      if ( mesg.getManufacturer() != null ) {
        System.out.print( "   Manufacturer: " );
        System.out.println( mesg.getManufacturer() );
      }

      if ( mesg.getProduct() != null ) {
        System.out.print( "   Product: " );
        System.out.println( mesg.getProduct() );
      }

      if ( mesg.getSerialNumber() != null ) {
        System.out.print( "   Serial Number: " );
        System.out.println( mesg.getSerialNumber() );
      }

      if ( mesg.getNumber() != null ) {
        System.out.print( "   Number: " );
        System.out.println( mesg.getNumber() );
      }
    }

    @Override
      public void onMesg( UserProfileMesg mesg ) {
      System.out.println( "User profile:" );

      if ( ( mesg.getFriendlyName() != null ) ) {
        System.out.print( "   Friendly Name: " );
        System.out.println( mesg.getFriendlyName() );
      }

      if ( mesg.getGender() != null ) {
        if ( mesg.getGender() == Gender.MALE ) {
          System.out.println( "   Gender: Male" );
        } else if ( mesg.getGender() == Gender.FEMALE ) {
          System.out.println( "   Gender: Female" );
        }
      }

      if ( mesg.getAge() != null ) {
        System.out.print( "   Age [years]: " );
        System.out.println( mesg.getAge() );
      }

      if ( mesg.getWeight() != null ) {
        System.out.print( "   Weight [kg]: " );
        System.out.println( mesg.getWeight() );
      }
    }

    @Override
      public void onMesg( DeviceInfoMesg mesg ) {
      System.out.println( "Device info:" );

      if ( mesg.getTimestamp() != null ) {
        System.out.print( "   Timestamp: " );
        System.out.println( mesg.getTimestamp() );
      }

      if ( mesg.getBatteryStatus() != null ) {
        System.out.print( "   Battery status: " );

        switch ( mesg.getBatteryStatus() ) {

        case BatteryStatus.CRITICAL:
          System.out.println( "Critical" );
          break;
        case BatteryStatus.GOOD:
          System.out.println( "Good" );
          break;
        case BatteryStatus.LOW:
          System.out.println( "Low" );
          break;
        case BatteryStatus.NEW:
          System.out.println( "New" );
          break;
        case BatteryStatus.OK:
          System.out.println( "OK" );
          break;
        default:
          System.out.println( "Invalid" );
        }
      }
    }

    @Override
      public void onMesg( MonitoringMesg mesg ) {
      System.out.println( "Monitoring:" );

      if ( mesg.getTimestamp() != null ) {
        System.out.print( "   Timestamp: " );
        System.out.println( mesg.getTimestamp() );
      }

      if ( mesg.getActivityType() != null ) {
        System.out.print( "   Activity Type: " );
        System.out.println( mesg.getActivityType() );
      }

      // Depending on the ActivityType, there may be Steps, Strokes, or Cycles present in the file
      if ( mesg.getSteps() != null ) {
        System.out.print( "   Steps: " );
        System.out.println( mesg.getSteps() );
      } else if ( mesg.getStrokes() != null ) {
        System.out.print( "   Strokes: " );
        System.out.println( mesg.getStrokes() );
      } else if ( mesg.getCycles() != null ) {
        System.out.print( "   Cycles: " );
        System.out.println( mesg.getCycles() );
      }

      printDeveloperData( mesg );
    }

    @Override
      public void onMesg( CameraEventMesg mesg) {
      System.out.println( "Camera" );
    }

    @Override
      public void onMesg( GyroscopeDataMesg mesg) {

      //System.out.println( "Gyroscope" );
      int[] fields = new int[]{GyroscopeDataMesg.GyroXFieldNum, GyroscopeDataMesg.GyroYFieldNum, GyroscopeDataMesg.GyroZFieldNum};
      addMesgToList( mesg, GyroscopeDataMesg.TimestampFieldNum, fields, gyroscope );
    }
    
    @Override
      public void onMesg( AccelerometerDataMesg mesg) {

      int[] fields = new int[]{AccelerometerDataMesg.AccelXFieldNum, AccelerometerDataMesg.AccelYFieldNum, AccelerometerDataMesg.AccelZFieldNum};
      addMesgToList( mesg, AccelerometerDataMesg.TimestampFieldNum, fields, accelerometer );
    }
    
        @Override
      public void onMesg( MagnetometerDataMesg mesg) {

      int[] fields = new int[]{MagnetometerDataMesg.MagXFieldNum, MagnetometerDataMesg.MagYFieldNum, MagnetometerDataMesg.MagZFieldNum};
      addMesgToList( mesg, MagnetometerDataMesg.TimestampFieldNum, fields, magnetometer );
    }
    
        @Override
      public void onMesg( GpsMetadataMesg mesg) {

      int[] fields = new int[]{GpsMetadataMesg.PositionLongFieldNum, GpsMetadataMesg.PositionLatFieldNum, GpsMetadataMesg.HeadingFieldNum,GpsMetadataMesg.VelocityFieldNum};
      addMesgToList( mesg, GpsMetadataMesg.TimestampFieldNum, fields, gps   );
    }

    @Override
      public void onMesg( RecordMesg mesg ) {
     

      printValues( mesg, RecordMesg.HeartRateFieldNum );

      printValues( mesg, RecordMesg.CadenceFieldNum );

      //printValues( mesg, RecordMesg.DistanceFieldNum );
      int[] fields = new int[]{RecordMesg.DistanceFieldNum};
      addMesgToList( mesg, RecordMesg.TimestampFieldNum, fields, distance );


      //  addToList(distances, mesg, RecordMesg.DistanceFieldNum );


      // System.out.println( "SpeedFieldNum" );
      printValues( mesg, RecordMesg.SpeedFieldNum );

      printDeveloperData( mesg );

      
    }

    private void printDeveloperData( Mesg mesg ) {
      for ( DeveloperField field : mesg.getDeveloperFields() ) {
        if ( field.getNumValues() < 1 ) {
          continue;
        }

        if ( field.isDefined() ) {
          System.out.print( "   " + field.getName() );

          if ( field.getUnits() != null ) {
            System.out.print( " [" + field.getUnits() + "]" );
          }

          System.out.print( ": " );
        } else {
          System.out.print( "   Undefined Field: " );
        }

        System.out.print( field.getValue( 0 ) );
        for ( int i = 1; i < field.getNumValues(); i++ ) {
          System.out.print( "," + field.getValue( i ) );
        }

        System.out.println();
      }
    }

    @Override
      public void onDescription( DeveloperFieldDescription desc ) {
      System.out.println( "New Developer Field Description" );
      System.out.println( "   App Id: " + desc.getApplicationId() );
      System.out.println( "   App Version: " + desc.getApplicationVersion() );
      System.out.println( "   Field Num: " + desc.getFieldDefinitionNumber() );
    }

    private void printValues( Mesg mesg, int fieldNum ) {
      Iterable<FieldBase> fields = mesg.getOverrideField( (short) fieldNum );
      Field profileField = Factory.createField( mesg.getNum(), fieldNum );
      boolean namePrinted = false;

      if ( profileField == null ) {
        return;
      }

      for ( FieldBase field : fields ) {
        if ( !namePrinted ) {
          System.out.println( "   " + profileField.getName() + ":" );
          namePrinted = true;
        }

        if ( field instanceof Field ) {
          System.out.println( "      native: " + field.getValue() );
        } else {
          System.out.println( "      override: " + field.getValue() );
        }
      }
    }


    private long getFirstFieldValueAsLong( Mesg mesg, int fieldNum ) {
      Iterable<FieldBase> fields = mesg.getOverrideField( (short) fieldNum );
      for ( FieldBase field : fields ) {         
        return ((Number)field.getValue()).longValue();
      }
      return 0;
    }
    
    private int getFirstFieldValueAsInt( Mesg mesg, int fieldNum ) {
      Iterable<FieldBase> fields = mesg.getOverrideField( (short) fieldNum );
      
      for ( FieldBase field : fields ) {         
        return ((Number)field.getValue()).intValue();
      }
      
      return 0;
    }

    private void addMesgToList( Mesg mesg, int timestampField, int[] fields, ArrayList list ) {

      Field profileField = Factory.createField( mesg.getNum(), timestampField );
      if ( profileField == null ) {
        return;
      }

      long timestamp = getFirstFieldValueAsLong(mesg, timestampField) * 1000 + com.garmin.fit.DateTime.OFFSET;

      int[] data = new int[fields.length];

      for ( int i =0; i < fields.length; i ++ ) {
        data[i] = getFirstFieldValueAsInt(mesg, fields[i]);
      }

      list.add( new Entry( timestamp, data ) );
    }
  }

  public class Entry {

    int[] data; 
    long timestamp;

    Entry ( long timestamp, int[] data) {

      this.timestamp =  timestamp;
      this.data = data;
    }
  }
}