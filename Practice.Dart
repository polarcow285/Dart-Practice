







var fruitPrices = new Map();
  
void main() {      
  String sentence1 = "I have 3 apples";   
  String sentence2 = "I have 10 pears"; 
  String sentence3 = "We have 2 peaches";   
  String sentence4 = "7 strawberries are in my car";
  String sentence5 = "32 starfruits were stolen yesterday";
  String sentence6 = "The dog bought 22 pineapples";
  String sentence7 = "Where did my 6 pears go";
  String sentence8 = "give me 18 watermelons";
  

  //print out the # of total fruit 
  
 
  //countFruitSimple(sentence1, sentence2);
  //countFruitSmart(sentence3, sentence4);
  //countFruitExtraSmart(sentence5, sentence6);
  //countFruitSuperSmart(sentence5, sentence6);
  List<String> myList = new List();
  myList.add(sentence1);
  myList.add(sentence2);
  myList.add(sentence3);
  myList.add(sentence4);
  myList.add(sentence5);
  myList.add(sentence6);
  myList.add(sentence7);
  myList.add(sentence8);
  
  fruitPrices['apples'] = .50;
  fruitPrices['peaches'] = .7;
  fruitPrices['pears'] = 1.0;
  fruitPrices['oranges'] = 1.5;
  fruitPrices['watermelons'] = 2.0;
  fruitPrices['pineapples'] = 3.0;
  fruitPrices['strawberries'] = 1.0;
  fruitPrices['starfruits'] = 3.0;
  
  /*print(fruitPrices);
  
  print(fruitPrices.keys);
  
  print(fruitPrices.containsKey('apples'));
  
  print ("4 apples cost " + (4*fruitPrices['apples']).toString());
*/
  countFruitLists(myList);
  
}

//isNumeric goes through a string and returns whether or not it is a number
bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 if (s == "-"){
   return true;
 }
 return double.tryParse(s) != null;
}

String moneyMaker(double v1) {
  String price;
  price = v1.toString();
  
  if (price.contains('.')){
    int index = (price.indexOf('.'));
    int length = price.length;
    int digitsAfterDecimal = length-index-1;
     
    if (digitsAfterDecimal > 2){
      price = price.substring(0, length-digitsAfterDecimal+3);
  
      var thousandthsPlace = price.substring(price.length-1,price.length);
      var hundredthsPlace = price.substring(price.length-2, price.length-1);
      
      if (int.parse(thousandthsPlace) >= 5){
        hundredthsPlace = '${int.parse(hundredthsPlace)+1}';
        price = price.substring(0,length-digitsAfterDecimal+1) + hundredthsPlace;
      }
      else{
        price = price.substring(0,length-digitsAfterDecimal+2);
      }
    }
    else if (digitsAfterDecimal == 2){
      //do nothing
    }
    else if(digitsAfterDecimal ==1){
      price = v1.toString()+'0';
    }
  }
  else{
    price = price + ".00";
  }
  
  String finalPrice = '\$'+ price;
  return (finalPrice);
}



//this function finds the number and the name of the fruit and puts them in a list
List<String> fruitHelper(String str5){
  bool lastCharacterWasNumber = false; 
  var i = 0;
  String firstNumber = "";
  String firstFruit = "";
  
  //goes through the sentence to find the number of fruits
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
  //goes through the sentence beginnning after the number to find the name of the fruit
  for (i = i+1;i<str5.length; i++){
    if (str5[i] == " "){
      break;
    }
    else{
      firstFruit = firstFruit + str5[i];
    }
  }
  
  List<String> fruitHelper = new List(2);
  fruitHelper[0] = firstNumber;
  fruitHelper[1] = firstFruit;
  return fruitHelper;
}

//this function will print the total number of fruits with the name of the fruit
//the input of this function is a list of sentences

void countFruitLists(List<String> lst){
  int totalFruits = 0;
  List<String> namesOfFruit = new List();
  
  var fruitCountMap = new Map();
  //the loop goes through every sentence and gets the number of fruit and the name of the fruit using fruitHelper and finds the total amount of fruit and puts that into a list called fruitAndNumber
  
  int currentFruitCount = 0;
  int initialFruitCount = 0;
  for(int i=0;i<lst.length;i++){
    List<String> fruitAndNumber = new List(2);
    fruitAndNumber = fruitHelper(lst[i]);
    totalFruits = totalFruits + int.parse(fruitAndNumber[0]);
        
    if (namesOfFruit.contains(fruitAndNumber[1])){
      //if the fruit is already inside namesOfFruit, do nothing
      
      initialFruitCount = fruitCountMap[fruitAndNumber[1]];
      currentFruitCount = initialFruitCount + int.parse(fruitAndNumber[0]);
      fruitCountMap[fruitAndNumber[1].toString()] = currentFruitCount;
  
    }
    else{
      namesOfFruit.add(fruitAndNumber[1]);
      fruitCountMap[fruitAndNumber[1].toString()] = int.parse(fruitAndNumber[0]);
    }
  }
  String stringFruit = "";
  for(int i=0;i<namesOfFruit.length;i++){
    if(namesOfFruit.length == 1){
      stringFruit = namesOfFruit[0] + ".";
      break;
    }
    if (i == namesOfFruit.length - 1){
      stringFruit = stringFruit + "and " + namesOfFruit[i] + ".";
    }
    else{
      stringFruit = stringFruit + namesOfFruit[i] + ", ";
    }
     
  }
  
  print("There are "+ totalFruits.toString() + " " + stringFruit + "\n");
  
  for(int i=0; i<namesOfFruit.length;i++){
    if (fruitPrices.containsKey(namesOfFruit[i])){
      //print(namesOfFruit[i] + ": \$" + fruitPrices[namesOfFruit[i]].toString());
    }
                                 
  }
  fruitCountMap.forEach((k,v) => print('${v}' + ' x ' + k + ' @ \$' + '${fruitPrices[k]}' + ' = ' + moneyMaker(v*fruitPrices[k])));
  
  
  double totalAmount = 0;
  fruitCountMap.forEach((k,v) => totalAmount = totalAmount + v*fruitPrices[k]);
  print ("\nYour total amount is " + moneyMaker(totalAmount));
  
}

void countFruitSuperSmart(str5, str6){
  
  List<String> fruitHelper1 = new List (2);
  fruitHelper1 = fruitHelper(str5);
  
  List<String> fruitHelper2 = new List (2);
  fruitHelper2 = fruitHelper(str6);
  
  int totalFruits = int.parse(fruitHelper1[0]) + int.parse(fruitHelper2[0]);
  
  print("There are " + totalFruits.toString() + " " + fruitHelper1[1] + " and " + fruitHelper2[1] + ".");
  
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
