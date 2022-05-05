/*
    Type Assertions

    This is a way of forcing the compiler to treat a variable as a specific
    type, i.e. overriding the type inference.

    This can be used to force an `any` into a known type to help catch errors,
    e.g.
*/
const json = `{ "color": "pink", "type": "fluff" }`;

let obj = JSON.parse(json);     // obj is `any` so we get no help from the compiler
console.log(obj.colour);        // typo not caught by type checks. :(

interface Thing {
    type: string,
    color: string
}
let typedObj = JSON.parse(json) as Thing;   // type is now `Thing`
console.log(typedObj.colour);               // so the compiler catches our bug

/*
    This seems quite similar to what you can achieve by just specifying the
    types of your variables, but asserting is a little more flexible:
*/
interface Person {
    name: string;
}

const dennis: Person = {  // error - object literal specified unknown property
    name: "Dennis", 
    email: "dennis@example.com"
};
const mac = {     // OK
    name: "Mac", 
    email: "mac@example.com"
} as Person;

/*
    A word of warning though... 

    You're effectively telling the compiler "I know what I'm doing, trust me",
    this can easily lead to issues at runtime

    e.g.
*/
function foo(bar: any): void {
    let x = bar as string;
    console.log(x.substring(0,3));
}

foo("things");  // Prints 'thi'
foo(123456);    // TypeError as substring isn't a function of number.