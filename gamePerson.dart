import 'dart:math';
class Person {
  
  
  String name;
  int age;
  String eyecolor;
  int height;
  String superpower;
  int health;
  int defense;

  List <String> backpack = new List();
  
  static int hands = 2;
  List <String> objectsInHand = new List();
  
  static var fruitPower = {'apple':1, 'strawberry':2, 'watermelon': 3, 'lychee': -2};
  static var vegetablePower = {'kale': 1, 'broccoli': 2, 'carrot': 4};
  static var weaponPower = {'fist': 1, 'baseball bat': 2, 'sword': 4};
  
  
  
  //constructor
  Person(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon) {
    name = nameString;
    age = ageNum;
    eyecolor = eyeString;
    height = heightNum;
    superpower = superpowerString;
    health = healthNum;
    defense = defenseNum;
    
    backpack.add("apple");
    backpack.add("fist");
    backpack.add(weapon);
    backpack.add("broccoli");
    
    
  }
  
  //method
  static void printHelper(String sentence, Person person){
    //prints name of the object then put quotes around the string
    print(person.name + ":" + '"' + sentence + '"');
  }
  
  bool isAlive(){
    if (health <= 0){
      Person.printHelper("I died!", this);
      return false;
    }
    else{
      return true;
    }
  }
  void introduce() { 
    if (isAlive() == true){
    
    Person.printHelper("Hi my name is " + name + ".  I am " + age.toString() + ".  I have " + eyecolor + " eyes!  I have " + hands.toString() + " hands! I am " + height.toString() + " feet tall and my superpower is " + superpower + ". My health is " + health.toString() + " and my defense is " + defense.toString(), this); 
    }
  }
  
  bool checkFruit(food){
    if (fruitPower.containsKey(food)){
      return true;
    }
    else{
      return false;
    }
  }
  
  void eat(String food){
    if (isAlive() == true){
      if (backpack.contains(food) && checkFruit(food)){
        health = health + fruitPower[food];
        Person.printHelper("I just ate a " + food + "! My health is now " + health.toString(),this);
        backpack.remove(food);
      }
      else if (backpack.contains(food) && !checkFruit(food)){
        defense = defense + vegetablePower[food];
        Person.printHelper("I just ate a " + food + "! My defense is now " + defense.toString(), this);
        backpack.remove(food);
      }
      else{
        Person.printHelper("I don't have a " + food, this);
      }
      if (health <= 0){
        Person.printHelper("I died!!", this);
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
    if (objectsInHand.contains(item)){
     Person.printHelper("I took out my " + item + ".", this);
    }
    else if (objectsInHand.length == hands){
      Person.printHelper("My hands are full", this);
    }
    else if(backpack.contains(item)){
      backpack.remove(item);
      objectsInHand.add(item);
      Person.printHelper("I took out my " + item + ".", this);
    }
    else{
      Person.printHelper("I don't have that.", this);
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
 
  void defend(String weapon){
    this.introduce();
    Person.printHelper("Give me your best shot!", this);
    int damageTaken = defense - weaponPower[weapon];
    if (damageTaken >= 0){
      Person.printHelper("I was able to defend the attack!", this);
    }
    else{
      health = health - damageTaken.abs();
      Person.printHelper("I wasn't able to defend the attack! I took " + damageTaken.toString() + " damage and my health is now " + health.toString(), this);
    }
    if (isAlive() == true){
      defense = defense - weaponPower[weapon];
      if (defense <= 0){
        defense = 0;
      }
      Person.printHelper("My defense is now " + defense.toString(), this);
    }else{
      //uses boolean isAlive
    }
    
    print("");
  }
  
  void attack(Person human, String weapon){
    this.introduce();
    Person.printHelper("PREPARE TO DIE", this);
    this.equip(weapon);
    Person.printHelper("Say hello to my little friend", this);
    print("");
    human.defend(weapon);
    
    
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
  
  Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10, 8, "sword");
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10, 7, "baseball bat");
  
  natalie.attack(ed, "sword");
  ed.attack(natalie, "fist");
  ed.eat("broccoli");
  ed.eat("broccoli");
  ed.eat("broccoli");
  
  
  
}
