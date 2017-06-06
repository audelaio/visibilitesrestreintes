var ip="10.10.10.2";
var numR=0;
/*
numrR :
0=160x120
1=176x144
2=320x240
3=352x288
4=640x480
5=800x600
6=1024x768
7=1280x1024
8=1600x1200
*/
var taille=[];
// JavaScript Document
$(document).ready(function() {
	//redimension
	"use strict";
	 $(window).resize(function(){
	ResizeIt();
	 });
	 ResizeIt();
	 $( "body" ).click(function() {
  		toggleFullScreen();
	});
	capture();
	//gestionratio
	if(numR===0){
		taille=[160,120];
	}
	if(numR===1){
		taille=[176,144];
	}
	if(numR===2){
		taille=[320,240];
	}
	if(numR===3){
		taille=[352,288];
	}
	if(numR===4){
		taille=[640,480];
	}
	if(numR===5){
		taille=[800,600];
	}
	if(numR===6){
		taille=[1024,768];
	}
	if(numR===7){
		taille=[1280,1024];
	}
	if(numR===8){
		taille=[1600,1200];
	}
});
///////////////////////////////////////////////////////////////////////////////////////
//          capture                                                                  //
///////////////////////////////////////////////////////////////////////////////////////
  function capture(){
	  "use strict";
	  $.get("http://" + ip + "/?plen=" +
     $("#cameraPLEN").val()+"&ql="+numR+"&t=" + Math.random(), function(result){
		  if (result.indexOf("Server is running!") === -1){
		  }else{
     $("#capturePic").attr("src", "http://" + ip + "/stream");
	   $("#capturePic").attr("width", "auto");
          $("#capturePic").attr("height", "auto");
			  }
	  });
  }
///////////////////////////////////////////////////////////////////////////////////////
//          Resize                                                                   //
///////////////////////////////////////////////////////////////////////////////////////
function ResizeIt() { 
	"use strict";
	var ratio=taille[0]/taille[1];
	var body_width = $(window).width(); 
	//var body_height = $(window).height();
	$("#capturePic").css({
		'width':body_width+'px',
		'height':body_width/ratio+'px'
	});
		
}
////////////////////////FULLSCREEN
function toggleFullScreen() {
	"use strict";
  if (!document.fullscreenElement &&    // alternative standard method
      !document.mozFullScreenElement && !document.webkitFullscreenElement && !document.msFullscreenElement ) {  // current working methods
	  $("*").css({
		'cursor': 'none'});
	  
	if (document.documentElement.requestFullscreen) {
      document.documentElement.requestFullscreen();
    } else if (document.documentElement.msRequestFullscreen) {
      document.documentElement.msRequestFullscreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.documentElement.mozRequestFullScreen();
    } else if (document.documentElement.webkitRequestFullscreen) {
      document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
    }
  } else {
	  $("*").css({
		'cursor': 'auto'});
    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.msExitFullscreen) {
      document.msExitFullscreen();
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) {
      document.webkitExitFullscreen();
    }
  }
}