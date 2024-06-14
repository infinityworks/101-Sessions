/*
    Type Declarations

    So we've seen how adding types to our code can help make things better, but
    what about libraries?
    
    Having types for the parts of your application that aren’t your code will
    greatly improve your TypeScript experience. 
    Where do these types come from?
*/
let x = Math.max(1, 20, 8, 70);

let y = Math.abs(1, 20, 8, 70);     // error: Expected 1 arg but got 4

/*
    How did typescript know?

    Ctrl+Click into the definition of Math.abs and you can see the types
    which have been added as declarations for the standard Math
    implementation:

        abs(x: number): number;

    Most modules will export a `.d.ts` type declaration file which makes
    working with that library in typescript much easier.
*/