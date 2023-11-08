/*
    Generics

    Generics give us a way to write a function which can operate on any
    type but still gives us type safety.

    For example the following function returns a random element from an
    array of numbers:
*/
function getRandomNumberElement(items: number[]): number {
    let randomIndex = Math.floor(Math.random() * items.length);
    return items[randomIndex];
}
let numbers = [1, 5, 7, 4, 2, 9];
let randomNumber: number = getRandomNumberElement(numbers);

// But how can we change this to support strings as well?
let strings = ["a", "b", "c"];
let randomString: string;
// randomString = getRandomNumberElement(strings); // won't compile

/*
    We could write the same function again with the types as string[] and
    string, but this adds duplicated code.

    We could change the existing function to use the any type:
*/
function getRandomAnyElement(items: any[]): any {
    let randomIndex = Math.floor(Math.random() * items.length);
    return items[randomIndex];
}
let x: any = getRandomAnyElement(strings);   // typeof x is any

/*
    But now we've lost our type information and we'd need to force the any
    back into a type we know to use it safely.
    
    This would be simple enough here, but could get very fiddly with more
    complicated functions and would add a lot of verbose casts.

    The solution is to make the function Generic.
    This preserves the type safety of our function and allows easy reuse.
*/
function getRandomElement<T>(items: T[]): T {
    let randomIndex = Math.floor(Math.random() * items.length);
    return items[randomIndex];
}
let y: number = getRandomAnyElement(numbers);
let z: string = getRandomElement(strings);

/*
    Generics can allow you to limit the arguments to a function based on
    inheritance.
*/
function displayPerson<T extends Person>(per: T): void {
    console.log(`Person: ${per.name}, ${per.age}`);
}

function displayName<T extends Named>(named: T): void {
    console.log(`Named: ${named.name}`);
}

interface Named {
    name: string
}
class Person implements Named {
    name: string;
    age: number;

    constructor (name: string, age: number) { 
        this.name = name;
        this.age = age;
    }
}

let dee = new Person("Dee", 42);
displayPerson(dee);     // Type safe operation a Person
displayName(dee);       // Type safe operation a Named object

/*
    Generics can also be used to create general purpose classes.

    You can then reuse the class with a variety of types as needed, but without
    resorting to passing around `any` variables and sacrificing type safety.
*/
class Pair<K, V> {
    key: K;
    value: V;
    
    constructor (key: K, value: V) {
        this.key = key;
        this.value = value;
    }
}

let pair = new Pair(1, "things");
let k1: number = pair.key;
let v1: string = pair.value;

let pair2 = new Pair(2, new Pair("nested", "pair"));
let k2: number = pair2.key;
let v2: Pair<string, string> = pair2.value;
