/*
    Type Inferrence

    When you don't explicitly define the type of a variable, TypeScript will try
    to figure out the type of the variables enforce type checks.
*/
let n: number = 50;
let halfN = n / 2;  // number is inferred from the type of n

let s = "test";     // string is inferred from the initial value
let halfS = s / 2;  // error: string doesn't support this operation
s = 100;            // error: number not assignable to string

function foo(bar=1000): void {
    console.log(Math.sqrt(bar));    // typeof bar is inferred from default value
}
foo("test");                        // error: foo() expects a number

let arr = [0, 1, 2, 3];     // number[]
let arr2 = [2, "things"];   // (number | string)[]
for (const e of arr2) {
    let x = 2 * e;              // error: string doesn't support this
    let y = e.substring(0, 3);  // error: number doesn't support this

    /*
        Type guards can be used in these circumstances where a variable can be
        one of several types.
    */
    if (typeof e === 'number') {
        let z = 2 * e;              // z is a number
        console.log(z);
    } else if (typeof e === 'string') {
        let z = e.substring(0, 3);  // z is a string
        console.log(z);
    }
}

