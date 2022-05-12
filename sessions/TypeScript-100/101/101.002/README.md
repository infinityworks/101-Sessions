# Simple type checks
One of the big benefits of TypeScript over plain JavaScript is that you get compile-time type safety (you know what type something is before you inspect it).

Depending on your development environment you may also get hints and warnings from your IDE as you're writing the code - much nicer than waiting until runtime to find out you made a mistake.

## Really simple type checking
Take the trivial function below for example: totally valid JavaScript, but it's not going to do what you want.
```
function halve(x) {
    console.log(x / 2);
}
halve(10); // 5
halve("some string"); // NaN
```

In TypeScript, you can specify the type of the argument to `halve` as a `number`:
```
function halve(x: number) {
    ...
```
And then you'll get a compile-time error when you try to pass a `string`.
```
$ tsc
app.ts:5:7 - error TS2345: Argument of type 'string' is not assignable to parameter of type 'number'.

5 halve("some string");
        ~~~~~~~~~~~~~
```

## A bit more complicated
The compiler makes working with more complex types easier by checking what properties they have.

For example, accessing a property that the object doesn't have, gives a type error:
```
const obj = {
    name: "Test Object",
    age: 42
};
console.log(obj.name);
console.log(obj.size); // compile error: Property 'size' does not exist on type '{ name: string; age: number; }'.
```

## A tiny bit more complicated again
You can use this kind of complex type checking in your function definitions as well. 

This lets you say something like _"this function accepts an object which has a `size` property which is a `number`"_:
```
function printSize(obj: {size: number}) {
    console.log(obj.size);
}

const x = { size: 10 };
printSize(x); // 10

const y = { size: "10" };
printSize(y); // compile error: Type 'string' is not assignable to type 'number'.

const z = { age: 42 };
printSize(z); // compile error: Property 'size' is missing in type '{ age: number; }' but required in type '{ size: number; }'.
```

You can also use this to check the function properties an object has:
```
function callSayHello(
    obj: {sayHello(name: string): string}
) {
    const name: string = "world";
    const greeting: string = obj.sayHello(name); // call function on the object
    console.log(greeting);
}

callSayHello({
    // object knows how to say hello
    sayHello(name: string): string {
        return `hello ${name}`;
    }
});
```