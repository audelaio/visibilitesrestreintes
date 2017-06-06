<html>
<head>
 <meta charset="UTF-8"> 
<title>ArduCAM</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:700' rel='stylesheet' type='text/css'>
<script src="randomColor.js"></script>
<style>
.item {
	width:100%; 
	height:100%;
	margin:auto;	
	text-align:center; 
	font-size:100px;

}
/* unvisited link */

a:link {
    color: #000000;
}

/* visited link */
a:visited {
    color: #000000;
}

/* mouse over link */
a:hover {
    color: #000000;
}

/* selected link */
a:active {
    color: #000000;
}

 </style>

 </head>

 <body style="font-family: 'Roboto', sans-serif;background: white;">

<div >
<?php
$dir = opendir('.');
$data = array();

// GET DIR DATA
while ($read = readdir($dir)) {

  if ($read!='.' && $read!='..' && $read!='index.php'){
   // if ( is_dir ( $read  ) ) {
      //if ( file_exists($read .'/index.php') || file_exists($read .'/index.htm') ||  file_exists($read .'/index.html')   ) {
        $data[] = $read;
        //echo '<li><a href="2016/'.$read.'">'.$read.'</a></li>';
        
      //}
    //}
  }
}
closedir($dir); 

// DO SOMETHING WITH DIR DATA
$count = count($data);
$height = 100/$count;
$fontheight = 10;//100/($count+1);
foreach ($data as &$value) {
    //echo '<div style="height:'. $height . '%"><div style="font-size:'.$fontheight .'vmin" >'; //echo '<div>'; 
    echo '<a href="' . $value . '">'. $value .'</a>';
    echo '<br>';
    //echo '</div></div>';
}

echo('</div>');
?>

</div>

<script>
/*
  window.fitText( document.getElementById("fit1") );
  window.fitText( document.getElementById("fit2") );
  window.addEventListener("resize", function() { 
	  window.fitText( document.getElementById("fit1") );
	  window.fitText( document.getElementById("fit2") );});
	  */
</script>
<script type="text/javascript">
  var color = randomColor({luminosity: 'dark', count: 1});
  //var container = document.getElementById('wikibody');
  var links = document.getElementsByTagName("a"); //container.getElementsByTagName("a");
   for(var i=0;i<links.length;i++)
   {
       if(links[i].href)
       {
           links[i].style.color = color;
       }
   }
</script>
 </body>
</html>