
# Module 102: Common Types

## Primitives

Along with this file, there are code examples of each type in [common-types-examples.ts](./common-types-examples.ts).


Similar to JavaScript, there are 3 commonly used primitives
- `boolean`
	- Same as JavaScript, simple true/false value
- `number`
    - There is no int or float, everything is number to JavaScript /TS
- `string`
	- Like JavaScript , strings can use single quotes or double quotes    
	- Template string using backticks and the ${} syntax
- `symbol `
	- There is a primitive in JavaScript used to create a globally unique reference via the function Symbol()
	- Symbol represenTypeScript unique tokens that can be used as keys for object properties.
- `bigint` 
	- Introduced in TypeScript 3.2, it provides a way to represent whole numbers larger than 253.
	- You can get a bigint in 2 ways:
		- Calling the BigInt() function    
		- Writing a BigInt literal by adding `n` to the end of any numeric integer
	- NOTE: You can use the bigint only if you are targeting version ESNext.
- `null`
	- Like JavaScript, null is used to indicate an absent value
- `undefined`
	- Like JavaScript, undefined is used to indicate an uninitialised value

Note: `null` and `undefined` depend on whether you have the [strictNullChecks](https://www.typescriptlang.org/tsconfig#strictNullChecks) option on (this will be covered in a later module)
- `any`
	- A top type of TypeScript's type system (aka universal supertype)  
	- This type allows TypeScript to work with existing JavaScript , with any you can essentially opt-out of type checking during compilation.
	- any represents all possible JavaScript values; primitives, objects, arrays, functions, errors, symbols, etc
	- As developers, this gives us a ton of freedom: TypeScript lets us perform any operation we want on values of type any without having to perform any kind of checking beforehand.
	- In most cases, this is too permissive and can be problematic at runtime. There is not much protection offered from TypeScript when using the any type
- `unknown`
	- Another top type of TypeScript's type system
	- If a variable is not known at the time of writing (e.g. accepting all values from user input) we can use the unknown type here
	- You can narrow your unknown type variable to something more specific by doing typeof checks, comparison checks, or more advanced type guards
	- This is similar to any, as the value can be of any type but it is essentially safe by default
- `objects`
	- Everything that isn’t a primitive type in TypeScript is a subclass of the object type. Examples are class, Interface, function, constructor, array, tuple, etc. We will cover these later.
	- i.e. anything that is not number, string, boolean, bigint, symbol, null, or undefined.
- `arrays`
	- TypeScript allows you to work with an array of values similar to JavaScript
	- There are 2 ways to write an array type
		- Use the type of elements followed by square brackets
		- Use the generic array type (generics will be covered later in the module)
- `tuples`
	- A tuple type allows you to express an array with a fixed number of elements, of which the types are known.    
	- For example, you can represent a string and number type in an array
- `enums`
	- Unlike most TypeScript features, this is not a type-level addition to JavaScript but something added to the language and runtime.    
	- As in languages like C#, an enum is a way of giving more friendly names to sets of numeric values.
	- Read more about enums here [https://www.typescriptlang.org/docs/handbook/enums.html](https://www.typescriptlang.org/docs/handbook/enums.html)
- `union type`
	- A simple way to combine types is called a union type. 
	- This is created from 2 or more types
		- e.g. variableName: type1 | type2;
	- More reading on union types here [https://www.typescriptlang.org/docs/handbook/2/everyday-types.html#union-types](https://www.typescriptlang.org/docs/handbook/2/everyday-types.html#union-types)
- `discriminated unions`
	- Similar to union type, but only allows access to shared properties.
- `casting`
	- Typecasting allows you to convert types and provide consistent (expected) results. 
		- Example use cases:
		    - concatenation of a number and string
			- convert arrays of numbers to strings for formatting and display
	- Force Casting
		- To override type errors that TypeScript may throw when casting, first cast to unknown, then to the target type
- `classes`
	- Starting with ECMAScript 2015 (aka ECMAScript 6), JavaScript programmers can build their applications using this object-oriented class-based approach. In TypeScript, it allows developers to use these techniques now and compile them down to JavaScript that works across all major browsers and platforms, without having to wait for the next version of JavaScript 
	- Access modifiers
		- Access modifiers change the visibility of the properties and methods of a class.
			- `private`
				- Limits the visibility to the same class only.
			- `protected`
				- allows properties and methods of a class to be accessible within same class and within subclasses
			- `public`
				-	allows class properties and methods to be accessible from all locations. If you don’t specify any access modifier for properties and methods, they will take the public modifier by default.
