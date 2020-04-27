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
  Nation nation;
  
  bool escape = false;
  static bool silentMode = false;

  List <String> backpack = new List();
  
  static int hands = 2;
  List <String> objectsInHand = new List();
  
  static var fruitPower = {'apple':1, 'strawberry':2, 'watermelon': 3, 'lychee': -2};
  static var vegetablePower = {'kale': 1, 'broccoli': 2, 'carrot': 4};
  static var weaponPower = {'fist': 1, 'baseball bat': 2, 'sword': 4, 'magical rays of fruit': 7};
  
  
  
  //constructor
  Person(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon, Nation nationObject) {
    name = nameString;
    age = ageNum;
    eyecolor = eyeString;
    height = heightNum;
    superpower = superpowerString;
    health = healthNum;
    defense = defenseNum;
    nation = nationObject;
    
    backpack.add("apple");
    backpack.add("broccoli");
    backpack.add(weapon);
    if (weapon != "fist"){
       backpack.add("fist");
    }
    
    
    
  }
  

  
  //method
  void printHelper(String sentence){
    if (silentMode == false){
      //prints name of the object then put quotes around the string
      print(this.name + "(Nation of " + this.nation.leader.name + "):" + '"' + sentence + '"');
    }
    else{
      //do nothing
    }
    
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
    if (silentMode == false) print("");
      
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
    if (silentMode == false) print("");
    
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
    if (silentMode == false) print("");
    
    human.introduce();
    human.printHelper("Give me your best shot!");
    if (silentMode == false) print("");
    
    for (int i=0; i < numberOfTimes; i++){
      if (escape == true){
        escape = false;
        break;
      }
      if (silentMode == false){
        print("Attack #" + (i+1).toString());
      }
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
  
  Superhero(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum, int defenseNum, String weapon, Nation nationObject, this.superMultiplier) : super(nameString, ageNum, eyeString, heightNum, superpowerString, healthNum*superMultiplier, defenseNum*superMultiplier, weapon, nationObject);
 
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
  var numberOfWeaponsMap  = new Map();

  List <Person> armyList = new List();
  static List <String> minionNames = ["Jerry", "Bobby", "Minion", "Moose", "Apple", "Daisy", "Vexx", "ZHC", "Pacon", "Texas Instruments"];
  static List <String> colorList = ["brown", "yellow", "black", "blue"];
  static List <String> superpowerList = ["flying", "eating", "invisibility", "super strength"];
  List<String> weaponList = new List();

  Nation(Person leaderPerson, String superheroName, int armyMembers){
    leader = leaderPerson;
    superhero = Superhero(superheroName, 22, "yellow", 8, "invisibility", 15, 10, "sword", this, 2);
    armySize = armyMembers;
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
  }

  void generateArmy(){
   for(int i = 0; i < armySize; i++){
    
    
    Random index = new Random();
    String name = minionNames[index.nextInt(minionNames.length)];
    int age = 234;
    String eyecolor = colorList[index.nextInt(colorList.length)];
    int height = index.nextInt(7)+1;
    String superpower = superpowerList[index.nextInt(superpowerList.length)];
    int health = 10;
    int defense = index.nextInt(11);
    
    String weapon = weaponList[index.nextInt(weaponList.length)];
    
    armyList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon, this));
     
   }
  }

  void nationInfo(){
    print("Leader name: " + leader.name);
    print("Army size: $armySize");
    print("Superhero: " + superhero.name);
    
    int nationHealth = 0;
    armyList.forEach((v)=> nationHealth = nationHealth + v.health);
    print("Toal Nation Health: $nationHealth");
    
    int nationDefense = 0;
    armyList.forEach((v)=> nationDefense = nationDefense + v.defense);
    print("Total Nation Defense: $nationDefense");

    //finds the number of weapons for each weapon
    for (Person p in armyList){
      //goes through p's backpack and finds their weapons
      for (String w in p.backpack){

        if(weaponList.contains(w)){
          //if this weapon has been added as a key to the Map before, then update the number of weapons
          if(numberOfWeaponsMap.containsKey(w)){
              numberOfWeaponsMap[w] = numberOfWeaponsMap[w] + 1;
          }
          //else create new key
          else{
              numberOfWeaponsMap[w] = 1;
          }

        }
      }
    }
    int nationPower = 0;
    numberOfWeaponsMap.forEach((k,v)=> nationPower = nationPower + v*(Person.weaponPower[k]));
    print("Total Nation Power: $nationPower");
    print("Weapons are: $numberOfWeaponsMap");
  }

  void nationAttack(Nation opponentNation){
    for (int i = 0; i <this.armyList.length; i++){
      this.armyList[i].attackSeveralTimes(opponentNation.armyList[i], 1);
      
    }
    this.nationInfo();
    opponentNation.nationInfo();

    for (int i = 0; i < this.armyList.length; i++ ){
      if ((i == this.armyList.length - 1){
        this.armyList[i].attackSeveralTimes(opponentNation.armyList[0], 1);
      }
      else{
        this.armyList[i].attackSeveralTimes(opponentNation.armyList[i+1], 1);
      }
      
    }
  }

}

void main () {
  
  /*Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10, 9, "sword");
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10, 7, "baseball bat");
  */
  
  

  print ("Hello and welcome to gamePerson! How many players will be joining?");
  int numberOfPlayers = int.parse(stdin.readLineSync());
  List <Person> personList = new List();
  
  for (int v = 0;v < numberOfPlayers; v++){
    print("Player ${v+1}, What is your name?");
    String name = stdin.readLineSync();
    Random index = new Random();
    int age = index.nextInt(100)+1;
    String eyecolor = Nation.colorList[index.nextInt(Nation.colorList.length)];
    int height = index.nextInt(7)+1;
    String superpower = Nation.superpowerList[index.nextInt(Nation.superpowerList.length)]; 
    int health = 10;
    int defense = index.nextInt(11);
  
    List<String> weaponList = new List();
    for(String w in Person.weaponPower.keys){
      weaponList.add(w);
    }
    String weapon = weaponList[index.nextInt(weaponList.length)];
    

    

    personList.add(Person(name, age, eyecolor, height, superpower, health, defense, weapon, null));
  }

  //Person person1 = Person(name, age, eyecolor, 5, "flying", 10, 9, "sword");
  for(int i = 0; i< personList.length; i++){
    personList[i].nation = Nation(personList[i], "bob", 10);
    personList[i].introduce();
    personList[i].nation.generateArmy();
    personList[i].nation.nationInfo();
    print("");
  
  }

 print("Player 1, what would you like to do? \nAttack or Fruit Storm or End Turn");
  
 if (stdin.readLineSync() == "Attack"){
    print("****************");
    Person.silentMode = true;
    personList[0].nation.nationAttack(personList[1].nation);
  }
  else{
    print("Unknown command");
  }
  
  
  



  
  
 
  
  
  
}
