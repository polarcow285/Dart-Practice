class Person {
  
  
  String name;
  int age;
  String eyecolor;
  int height;
  String superpower;
  int health;
  static int hands = 2;
  static var fruitPower = {'apple':1, 'strawberry':2, 'watermelon': 3, 'lychee': -2};
  
  
  
  //constructor
  Person(String nameString, int ageNum, String eyeString, int heightNum, String superpowerString, int healthNum) {
    name = nameString;
    age = ageNum;
    eyecolor = eyeString;
    height = heightNum;
    superpower = superpowerString;
    health = healthNum;
    
    
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
    health = health + fruitPower[fruit];
    print("I just ate a " + fruit + "! My health is now " + health.toString());
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
  
  void revive(){
    health = 10;
    print("I have been revived!! :)");
  }
  static void fruitStorm(){
    print("FRUIT STORM!!!!!");
    fruitPower.forEach((k,v) => fruitPower[k] = v*-1);
  }
  
  void changehands(int h) {
    hands = h;
  }
 
}

void main () {
  
  Person natalie = Person("Natalie", 14, "brown", 5, "flying", 10);
  Person ed = Person("Ed", 37, "brown", 5, "eating", 10);
  
  Person.fruitStorm();
  
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
  natalie.eat('lychee');
  
  //natalie.changehands(3);
  
  //natalie.introduce();
  
  
  //ed.introduce();
 
  
}
