const isFun: boolean = false;

// there is no int or float, everything is number to JS/TS
const pie: number = 3.14;

// strings can use single or double quotes
const fullName: string = "Bob Bobbington";

// template string, using backticks
const greet: string = `Salutations ${fullName}!`

// symbol
// note that both variables have what seems to be the same value
const firstName: symbol = Symbol("name");
const secondName: symbol = Symbol("name");
// if we check their equality, it will always return false & TS will give us an error
if (firstName === secondName) {
 // cannot ever happen as each Symbol is a globally unique reference
}

// bigint
// creation via the BigInt function
const big1: bigint = BigInt(200);
// creation via the literal syntax
let big2: bigint = 200n;

const uninitialisedValue: undefined = undefined;

const absentValue: null = null;

// any
let value: any;
// all the below are type-correct
value.trim();
value[0];
value.property.does.not.exist;
new value();

// unknown
let value1: unknown;
// the following operations are no longer considered type-correct (value1[0] would not be type-correct with the strictNullChecks option on)
value1.trim();
value1[0]; // strict null checks in ts config will make this type incorrect
value1.property.does.not.exist;
new value1();

// unknown type pt2
// set unknown type to default of null for this example
let userInput: unknown = null;
// variable userInput can be any specific type, so all the below work fine
userInput = "mumbo jumbo";
userInput = 10;
userInput = true;

// simple typeof checks for an unknown type, also known as type narrowing
if (typeof userInput === "boolean") {
    // TS knows that userInput is a boolean now
    // we can save this in a new const (or let) now we know the type and value
    const userInputBool: boolean = userInput;
    // within this typeof check block, you cannot assign userInput to another type
    // the following will show a type error
    const userInputNumber: number = userInput;
}

// arrays
// method 1
let arr1: number[] = [1, 2, 3];
// method 2, using generics
let arr2: Array<number> = [1, 2, 3];

// tuples
let person: [string, number];
// initialise in the correct order
person = ["Bob", 18];
// attempt to initialise in the incorrect order, gives us type errors
person = [18, "Bob"];
// attempt to initialise it as empty, gives us type errors
person =[];
// access correct element at index, correct type is retrieved and we can do an operation on the string
person[0].substring(1);
// attempt to access the same substring element at the incorrect index, and we get a type error
person[1].substring(1);
// attempt to access element outside the set of known indicies will error
person[3];

// enums
// enums begin numbering their members starting at 0 by default
enum Colour {
    Green, // 0
    Amber, // 1
    Red, // 2
}
// call element by index
console.log (Colour[0]) // Green
// you can manually set the values in the enum
enum roomInMetres {
    Floor1 = 100,
    Floor2 = 321,
    Floor3 = 5,
}
// call element by it's name
console.log(roomInMetres.Floor2) // 321

// union types
let age: string | number;
// set to a string 
age = 25;
// set to a number
age = "twenty five";
// attempt to set to boolean, gives us a type error
age = false; 

// discriminated union
interface Fish {
    weight: number;
    numberOfScales: number;
    canSwim: boolean;
}
interface Bird {
    weight: number;
    canFly: boolean;
}
let randomAnimal: Fish | Bird;
// type `randomAnimal.` below, without the backticks to see what properties you can access
randomAnimal
// only the weight property is allowed on randomAnimal as it's the only common property between the types in the union

// casting
let year: number = 2022;
// TypeScript will still attempt to typecheck casts to prevent casts that don't seem correct
console.log((year as string).length); 
// alternatively you can cast with <>, this will still be typechecked
console.log((<string>year).length);
// you can override the typechecking with force casting, first cast to unkown, then target type
console.log(((year as unknown) as string).length); 

// classes
class Greeter {
    greeting: string;
   
    constructor(message: string) {
      this.greeting = message;
    }
   
    greet() {
      return "Hello, " + this.greeting;
    }
  }
   
let greeter = new Greeter("world"); // Hello, world