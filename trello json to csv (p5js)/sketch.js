var data;
var stringArray = new Array();
var memberIdToName ={};
var listIdToName ={};

function preload() {

  data = loadJSON("trello.json");
}

function setup() {
  //createCanvas(600, 400);
  //noStroke();
  //textSize(20);
    
    
  // MEMBER IDS
   for (var m = 0; m < data.members.length; m++) {

    
       memberIdToName[data.members[m].id] = data.members[m].fullName;
  }
     
  // LIST IDS    
  for (var l = 0; l < data.lists.length; l++) {

    
       listIdToName[data.lists[l].id] = data.lists[l].name;
  }
    
  // PARSE CARDS
  for (var c = 0; c < data.cards.length; c++) {

    var due = (data.cards[c].due);
    if (due == null) {
      due = '0000-00-00';
    } else {
      due = due.substring(0, 10);
    }
      
   var cardMembers = "";      
      for ( var i =0; i < data.cards[c].idMembers.length; i++ ){
          if ( i > 0 ) cardMembers += "\,";
        cardMembers += memberIdToName[data.cards[c].idMembers[i]] ;
          
        
    } 
    //if ( cardMembers == "" ) cardMembers = "?";
      
  var cardList = listIdToName[data.cards[c].idList] ;
      
  var cardDescription = data.cards[c].desc;
      
   stringArray.push(due+","+cardList+",\""+data.cards[c].name+"\""+",\""+cardMembers+"\""+",\""+cardDescription+"\"") ;
   
  }
  
    var csvDivContent = "";
    for ( var l =0; l < stringArray.length; l++) {
        csvDivContent += stringArray[l];
        csvDivContent += "<br>";
    }
  
   csvDiv = createDiv(csvDivContent);
  //saveStrings(stringArray,"trello.csv","csv");

}

