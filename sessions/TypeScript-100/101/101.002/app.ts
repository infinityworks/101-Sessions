/*
 Really simple type checking
*/
function halve(x: number) {
    console.log(x / 2);
}

halve(10); // 5.0
halve("some string"); // compile error: Argument of type 'string' is not assignable to parameter of type 'number'.

/*
 A bit more complicated
*/
const obj = {
    name: "Test Object",
    age: 42
};

console.log(obj.name);
console.log(obj.size); // compile error: Property 'size' does not exist on type '{ name: string; age: number; }'.

/*
 A tiny bit more complicated again
*/
function printSize(obj: { size: number }) {
    console.log(obj.size);
}

const x = {size: 10};
printSize(x); // 10

const y = {size: "10"};
printSize(y); // compile error: Type 'string' is not assignable to type 'number'.

const z = {age: 42};
printSize(z); // compile error: Property 'size' is missing in type '{ age: number; }' but required in type '{ size: number; }'.


/*
    Defines a type of object which has a `sayHello` function which
    accepts a string and returns a string.
*/
type CanSayHello = {
    sayHello(name: string): string
}

function callSayHello(
    obj: CanSayHello
) {
    const name: string = "world";
    const greeting: string = obj.sayHello(name); // call function on the object
    console.log(greeting);
}

const csh: CanSayHello = {
    sayHello(name: string): string {
        return `hello ${name}`;
    }
};
callSayHello(csh);

