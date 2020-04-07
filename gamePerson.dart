import 'dart:math';
class Person {
  
  
  String name;
  int age;
  String eyecolor;
  int height;
  String superpower;
  int health;
  List <String> backpack = new List();
  
  static int hands = 2;
  List <String> objectsInHand = new List();
  
  static var fruitPower = {'apple':1, 'strawberry':2, 'watermelon': 3, 'lychee': -2};
  
  
  
  //constructor
  Person(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum) {
    name = nameString;
    age = ageNum;
    eyecolor = eyeString;
    height = heightNum;
    superpower = superpowerString;
    health = healthNum;
    backpack.add("apple");
    backpack.add("baseball bat");
    
    
  }
  
  //method
  bool isAlive(){
    if (health <= 0){
      print("I'm sorry but I am dead :(");
      return false;
    }
    else{
      return true;
    }
  }
  void introduce() { 
    if (isAlive() == true){
    
    print("Hi my name is " + name + ".  I am " + age.toString() + ".  I have " + eyecolor + " eyes!  I have " + hands.toString() + " hands! I am " + height.toString() + " feet tall and my superpower is " + superpower + ". My health is " + health.toString() + "."); 
    }
  }
  
  void eat(String fruit){
    if (isAlive() == true){
      if (backpack.contains(fruit)){
        health = health + fruitPower[fruit];
        print("I just ate a " + fruit + "! My health is now " + health.toString());
        backpack.remove(fruit);
      }
      else{
        print("I don't have a " + fruit);
      }
      if (health <= 0){
        print("You died!!");
      }
      }
  }
  void starve(){
    if (isAlive() == true){
    health = health - 1;
    print("I'm starving! My health is now " + health.toString());
   }
  }
  
  void checkBackpack(){
    print(backpack);
  }
  
  void equip(String item){
    if (objectsInHand.length == hands){
      print("My hands are full");
    }
    else if(backpack.contains(item)){
      backpack.remove(item);
      objectsInHand.add(item);
      print("Equiped " + item);
    }
    else{
      print("I don't have that.");
    }
      
  }
   
  void dropItemsInHand(){
    objectsInHand.removeRange(0,objectsInHand.length);
    print("Oh no I dropped all my items!");
  }  
  
  void revive(){
    health = 10;
    print("I have been revived!! :)");
  }
  
  void attack(Person name){
    name.introduce();
    print("Hello I am going to attack you");
  }
  static void fruitStorm(){
    
    fruitPower.forEach((k,v) => fruitPower[k] = (v.abs())*-1);
    print("FRUIT STORM!!!!! " + '${fruitPower}');
    
  }
  
  static void fruitParadise(){
    fruitPower.forEach((k,v) => fruitPower[k] = v.abs());
    print("FRUIT PARADISE!!! " + '${fruitPower}');
  }
  
  static void fruitChallenge(){
    Random fruitWeather = new Random();
    int number = fruitWeather.nextInt(2);
    if (number == 0){
      fruitStorm();
    }
    else{
    fruitParadise();
    }
  }
  
  void changehands(int h) {
    hands = h;
  }
 
}

void main () {
  
  Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10);
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10);
  
  natalie.checkBackpack();
  natalie.equip("baseball bat");
  natalie.dropItemsInHand();
  natalie.checkBackpack();
  
  natalie.attack(ed);
  
  /*natalie.eat("apple");
  natalie.eat("apple");
  
  natalie.checkBackpack();
  natalie.equip("baseball bat");
  */

  /*Person.fruitStorm();
  
  natalie.introduce();
  natalie.starve();
  natalie.starve();
  natalie.starve();
  natalie.eat("apple");
  natalie.eat("watermelon");
  natalie.eat("strawberry");
  natalie.eat("strawberry");
  natalie.revive();
  natalie.introduce();
  
  Person.fruitParadise();
  natalie.eat('lychee');
  Person.fruitChallenge();
  
  
  //natalie.changehands(3);
  
  //natalie.introduce();
  
  
  //ed.introduce();
 */
  
}
