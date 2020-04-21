import 'dart:io';
import 'dart:math';
class Person {
  
  
  String name;
  int age;
  String eyecolor;
  int height;
  String superpower;
  int health;
  int defense;
  
  bool escape = false;

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
    backpack.add("broccoli");
    backpack.add(weapon);
    if (weapon != "fist"){
       backpack.add("fist");
    }
    
    
    
  }
  

  
  //method
  void printHelper(String sentence){
    //prints name of the object then put quotes around the string
    print(this.name + ":" + '"' + sentence + '"');
  }
  
  bool isAlive(){
    if (health <= 0){
      this.printHelper("I died!");
      return false;
    }
    else{
      return true;
    }
  }
  void introduce() { 
    if (isAlive() == true){
    
    this.printHelper("Hi my name is " + name + ".  I am " + age.toString() + ".  I have " + eyecolor + " eyes!  I have " + hands.toString() + " hands! I am " + height.toString() + " feet tall and my superpower is " + superpower + ". My health is " + health.toString() + " and my defense is " + defense.toString()); 
   
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
        this.printHelper("I just ate a " + food + "! My health is now " + health.toString());
        backpack.remove(food);
      }
      else if (backpack.contains(food) && !checkFruit(food)){
        defense = defense + vegetablePower[food];
        this.printHelper("I just ate a " + food + "! My defense is now " + defense.toString());
        backpack.remove(food);
      }
      else{
        this.printHelper("I don't have a " + food);
      }
      if (health <= 0){
        this.printHelper("I died!!");
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
     this.printHelper("I took out my " + item + ".");
    }
    else if (objectsInHand.length == hands){
      this.printHelper("My hands are full");
    }
    else if(backpack.contains(item)){
      backpack.remove(item);
      objectsInHand.add(item);
      this.printHelper("I took out my " + item + ".");
    }
    else{
      this.printHelper("I don't have that.");
    }
    print("");
      
  }
   
  void dropItemsInHand(){
    objectsInHand.removeRange(0,objectsInHand.length);
    print("Oh no I dropped all my items!");
  }  
  
  void revive(){
    health = 10;
    print("I have been revived!! :)");
  }
 
  String findWeaponInHand(){
    String weapon;
    weaponPower.forEach((k,v) => objectsInHand.contains(k)? weapon = k: weapon = weapon);
    
    return weapon;
  }

  
  void attack(Person human){
   
    if(human.health <= 3){
      if (checkSuperpower()){
          human.printHelper("I used my superpower to escape!");
          return;
        }
    }
   
    String weapon = this.findWeaponInHand();
     if (weapon == null){
       this.equip("fist");
       weapon = "fist";
    }
    int damageTaken = human.defense - getPower(weapon);
    if (damageTaken >= 0){
      human.printHelper("I didn't take any damage! I was able to defend the attack! My health is now " + human.health.toString());
    }
    else{
      human.health = human.health - damageTaken.abs();
      human.printHelper("I wasn't able to defend the attack! I took " + damageTaken.toString() + " damage and my health is now " + human.health.toString());
    }
    if (isAlive() == true){
      human.defense = human.defense - getPower(weapon);
      if (human.defense <= 0){
        human.defense = 0;
      }
      human.printHelper("My defense is now " + human.defense.toString());
    }else{
      //uses boolean isAlive
    }
    print("");
    
  }
  
  bool checkSuperpower(){
    if (this.superpower == "flying"){
      Random superpowerProbability = new Random();
      int number = superpowerProbability.nextInt(101);
      if(number < 20){
        escape = true;
        return true;
      }
      else{
        return false;
      }
    }
    else{
      return false;
    }
  
  }
  
  void criticalAttack(Person human){
    for (int i=0; i<human.objectsInHand.length;i++){
      this.backpack.add(human.objectsInHand[i]);
    }
    human.dropItemsInHand();
    
  }
  int getPower(weapon){
    return weaponPower[weapon];
  }
  
  void attackSeveralTimes(Person human, int numberOfTimes){
    this.introduce();
    this.printHelper("PREPARE TO DIE");
    print("");
    
    human.introduce();
    human.printHelper("Give me your best shot!");
    print("");
    
    for (int i=0; i < numberOfTimes; i++){
      if (escape == true){
        escape = false;
        print("you got here");
        break;
      }
      print("Attack #" + (i+1).toString());
      this.attack(human);
      
      if (human.health <= 0){
        print("Attack stopped because " + human.name + " died.");
        print(this.name + " is victorious!");
        break;
      }
      human.attack(this);
      
      if (this.health <= 0){
        print("Attack stopped because " + this.name + " died.");
        print(human.name + " is victorious!");
        break;
      }
    }
    
    if (human.health > 0 && this.health > 0){
      if (human.health > this.health){
        human.printHelper("I won this battle, I'll get you next time.");
      } 
      else if (this.health > human.health){
        this.printHelper("I won this battle, I'll get you next time.");
      }
      else{
        this.printHelper("This was a draw, I'll see you next time.");
      }
    }
    
    
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

class Superhero extends Person{
  
  int superMultiplier;
  
  Superhero(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon, this.superMultiplier) : super(nameString, ageNum, eyeString, heightNum, superpowerString, healthNum*superMultiplier, defenseNum*superMultiplier, weapon);
 
  @override void introduce(){
    super.introduce();
    this.printHelper("I am a superhero! My Supermultiplier is " + superMultiplier.toString());
  }
  
  @override int getPower(weapon){

    return super.getPower(weapon)*superMultiplier;

  }
  
}

class Nation {
  Person leader;
  Superhero superhero;
  int armySize;

  List <Person> armyList = new List();

  Nation(Person leaderPerson, Superhero superheroPerson, int armyMembers){
    leaderPerson = leader;
    superheroPerson = superhero;
    armySize = armyMembers;
  }

  void generateArmy(){
   for(int i = 0; i < armySize; i++){
    
    
   
    String name = "minion";
    int age = 234;
    Random index = new Random();
    //String eyecolor = colorList[index.nextInt(5)];
    String eyecolor = "brown";
    int height = index.nextInt(7)+1;
    //String superpower = superpowerList[index.nextInt(3)];
    String superpower = "flying";
    int health = 10;
    int defense = index.nextInt(11);
    String weapon = "sword";
    /*List<String> weaponList = new List();
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
    String weapon = weaponList[index.nextInt(3)];
    */
    armyList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon));
    

     
   }
  }

  

}


void main () {
  
  /*Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10, 9, "sword");
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10, 7, "baseball bat");
  */
  Person bob = Superhero("Bob", 22, "yellow", 8, "invisibility", 15, 10, "sword", 2);
  

  print ("Hello and welcome to gamePerson! How many players will be joining?");
  int numberOfPlayers = int.parse(stdin.readLineSync());
  List <Person> personList = new List();
  List <String> colorList = new List(5);
  colorList[0] = "brown";
  colorList[1] = "yellow";
  colorList[2] = "black";
  colorList[3] = "blue";

  List <String> superpowerList = ["flying", "eating", "invisibility", "super strength"];
  
  for (int v = 0;v < numberOfPlayers; v++){
    print("Player ${v+1}, What is your name?");
    String name = stdin.readLineSync();
    print("What is your age?");
    int age = int.parse(stdin.readLineSync());
    //print("What is your eye color?");
    //String eyecolor = stdin.readLineSync();
    Random index = new Random();
    String eyecolor = colorList[index.nextInt(5)];
    int height = index.nextInt(7)+1;
    String superpower = superpowerList[index.nextInt(3)]; 
    int health = 10;
    int defense = index.nextInt(11);
    
    List<String> weaponList = new List();
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
    String weapon = weaponList[index.nextInt(3)];
    

    

    personList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon));
  }

  

  //Person person1 = Person(name, age, eyecolor, 5, "flying", 10, 9, "sword");
  for(int i = 0; i< personList.length; i++){
    personList[i].introduce();
    
  }

  Nation personNation = Nation(personList[0], bob, 10);
  print (personNation);



  
  
 
  
  
  
}
