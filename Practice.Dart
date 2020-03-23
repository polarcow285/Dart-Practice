void main() {      
  String sentence1 = "I have 3 apples";   
  String sentence2 = "I have 5 pears"; 
  String sentence3 = "We have 7 apples";   
  String sentence4 = "5 pears are in my car";
  String sentence5 = "He has 678 grapes";
  String sentence6 = "She bought 2 pears yesterday";

  //print out the # of total fruit  
  
 
  //countFruitSimple(sentence1, sentence2);
  //countFruitSmart(sentence3, sentence4);
  //countFruitExtraSmart(sentence5, sentence6);
  //countFruitSuperSmart(sentence5, sentence6);
  fruitHelper(sentence5);
}

bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}



void fruitHelper(String str5){
  bool lastCharacterWasNumber = false; 
  var i = 0;
  String firstNumber = "";
  String firstFruit = "";
  
  for (i=0;i < str5.length;i++){               
    if (isNumeric(str5[i])){              
      
      firstNumber = firstNumber + str5[i];             
      lastCharacterWasNumber = true;     
    }                  
    if (str5[i]==" " && lastCharacterWasNumber == true) {
        break;
      
      // you are at the end of the number of fruits       
      // now start creating firstFruit string     
    }   
  }   
  for (i = i+1;i<str5.length; i++){
    if (str5[i] == " "){
      break;
    }
    else{
      firstFruit = firstFruit + str5[i];
    }
  }
  
  print (firstNumber + " " + firstFruit);
}





void countFruitSuperSmart(str5, str6){
  
  String firstNumber = "";
  String secondNumber = "";
  String firstFruit = "";
  String secondFruit = "";
  
  // option 1   
  bool lastCharacterWasNumber = false; 
  var i = 0;
  
  for (i=0;i < str5.length;i++){               
    if (isNumeric(str5[i])){              
      
      firstNumber = firstNumber + str5[i];             
      lastCharacterWasNumber = true;     
    }                  
    if (str5[i]==" " && lastCharacterWasNumber == true) {
        break;
      
      // you are at the end of the number of fruits       
      // now start creating firstFruit string     
    }   
  }   
  for (i = i+1;i<str5.length; i++){
    if (str5[i] == " "){
      break;
    }
    else{
      firstFruit = firstFruit + str5[i];
    }
  }
  
 lastCharacterWasNumber = false;

 for (i=0;i < str6.length;i++){
    
    if (isNumeric(str6[i])){
      secondNumber = secondNumber + str6[i]; 
      lastCharacterWasNumber = true;
    }
    if (str6[i] == " " && lastCharacterWasNumber == true){
      break;
    }
    
  }
  
 for (i = i+1;i<str6.length;i++){
   if (str6[i] == " "){
     break;
   }
   else{
     secondFruit = secondFruit + str6[i];
   }
 }
  
  int total = int.parse(firstNumber) + int.parse(secondNumber);
  
print ("There are a total of " + total.toString() + " " + firstFruit + " and " + secondFruit + ".");
}

  

void countFruitExtraSmart(str5, str6){  
  
  String firstNumber = "";
  String secondNumber = "";
  
  for (var i=0;i < str5.length;i++){
    
    if (isNumeric(str5[i])){
      firstNumber = firstNumber + str5[i]; 
      
    }
    
  }
  
  for (var i=0;i < str6.length;i++){
    
    if (isNumeric(str6[i])){
      secondNumber = secondNumber + str6[i]; 
      
    }
    
  }
  
  int total = int.parse(firstNumber) + int.parse(secondNumber);
  print (firstNumber);
  print (secondNumber);
  print ("There are " + total.toString() + " fruits.");
   
  
}


void countFruitSmart(String str3, String str4) {   
  int fruitNum, apples, pears;   
  apples = 0;   
  pears = 0; 
        
              
  //- code to get # of apples
  //parse the entire string and find the first integer
  for (var i=0;i < str3.length;i++) {
    
    if (isNumeric(str3[i])){
      apples = int.parse(str3[i]);
      break;
    }
    else{
      //keep going
    }  
    
  }  
  
  
  //-code to get # of pears
  //parse the entire string and find the first integer
  for (var i=0;i < str4.length;i++) {
    
    if (isNumeric(str4[i])){
      pears = int.parse(str4[i]);
      break;
    }
    else{
      //keep going
    }  
    
  }  
  
  fruitNum = apples + pears;
  print(str3);
  print(str4);
  print("There are " + fruitNum.toString() + "fruits.");   
}

                                                
                                                
  void countFruitSimple(String str1, String str2) {   
  int fruitNum, apples, pears;   
  apples = 0;   
  pears = 0; 
 
  //- code to get # of apples 
  //get the string representation of the number by referencing string index
  apples = int.parse(str1[7]);
  
  //convert string to integer
  
  //-code to get # of pears 
  //get the string representation of the number by referencing string index
  pears = int.parse(str2[7]);
  //convert string to integer
  
  
  fruitNum = apples + pears; 
  print (str1);
  print (str2);
  print("There are " + fruitNum.toString() + " fruits.");
}
