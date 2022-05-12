# Hello, World!
The code in this directory is a really basic hello world script showing how TypeScript adds compile-time types to JavaScript.

```
function hello(name: string) // typescript
```
vs.
```
function hello(name) // plain JS
```

The TypeScript code will compile down to the plain JS version, but having types at compile-time gives you a bit more safety and some useful dev tools as well.

## Running the code
### TS Playground
Go to `https://www.typescriptlang.org/play` and copy the code from `app.ts` into the editor.

You'll see the compiled version of the code in the `JS` tab on the right-hand side.

Hit run to execute the code and see the output in the `Logs` tab.

### Locally
You can run this locally by installing TypeScript with `npm`.
```
$ npm install -g typescript

... wait while node downloads the world...

$ tsc --v
Version 4.6.3
```

Then you can run the code with:
```
$ tsc
$ node app.js
```
`tsc` runs the TypeScript compiler and outputs the compiled JavaScript as `app.js`, then we run the code with Node.