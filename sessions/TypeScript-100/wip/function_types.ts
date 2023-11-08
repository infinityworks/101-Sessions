/*
    Function Types

    Since functions are first class in JS you can create function variables,
    and TypeScript supports this by letting you define function types:

        (param: type, param: type) => type
*/

let add: (a: number, b: number) => number;
add = (a, b) => a + b;

function combineNumbers(
    x: number,
    y: number,
    combiner: (a: number, b: number) => number
): number {
    return combiner(x, y);
}

console.log( combineNumbers(10, 20, add) );

console.log(
    combineNumbers(10, 20,
        (a, b) => a * b // types inferred as numbers
    )
);