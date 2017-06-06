<?php
// SET TO THE TARGET DIR :
 $target_dir = "storedjpegs/"; 

$uploadfile = "";
if(strlen(basename($_FILES["userfile"]["name"])) > 0) {
	$uploadfile = basename($_FILES["userfile"]["name"]);
	 //error_log($uploadfile);
	 $datum = mktime(date('H')+0, date('i'), date('s'), date('m'), date('d'), date('y'));

 	if(move_uploaded_file($_FILES["userfile"]["tmp_name"], $target_dir.date('Y_m_d_H_i_s', $datum)."_".$uploadfile)) {
 		//error_log($target_dir.date('Y_m_d_H_i_s', $datum)."_".$uploadfile);
 	 }
}
?>