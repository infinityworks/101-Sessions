/*
    Interfaces

    Interfaces are veeery similar to Types shown above, effectively just
    providing a more familar syntax around the same idea.
*/
interface Flavoured { 
    flavour: ("Strawberry" | "Chocolate" | "Banana")
};
interface Sized { 
    size: ("S" | "M" | "L")
};
interface Scooped {
    scoops: (1 | 2 | 3)
};

/*
    Much like the & syntax from types you can create an intersection interface
    using extends.
*/
interface Milkshake extends Flavoured, Sized {
};
let milkshake: Milkshake = {
    flavour: "Strawberry",
    size: "L"
}

let brokenMilshake: Milkshake = {   // error: missing required property from Sized
    flavour: "Chocolate"
}

/*
    But there's no equivalent for the | syntax with interfaces.
    This is because an interface needs to have a definite list of properties.
*/
interface IceCream extends Flavoured, Sized, Scooped {
};
let dessert: IceCream = {
    flavour: "Chocolate",
    scoops: 3
};

/*
    Again these are Types and so they don't exist at runtime so `typeof` and
    `instanceof` checks won't work with them.
*/
console.log(typeof dessert); // object
console.log(dessert instanceof IceCream); // Compile error: IceCream is a type not a value.

/*
    If a type needs to have some optional properties, this is supported with
    the `name?: type` syntax.

    You can also add readonly fields with the `readonly` keyword.
*/
interface Customer {
    name: string,
    email: string,
    mobile: string,
    landline?: string   // because it's the 21st century
    readonly dateOfBirth: Date
};

let c: Customer = {
    name: "Frank",
    email: "frank@example.com",
    mobile: "3482398472",
    dateOfBirth: new Date("1970-01-01T00:00:00.000Z")
}

c.dateOfBirth = new Date(); // can't edit a readonly field

/*
    As well as declaring variables of your types, you can create classes
    which extend them.
*/
class CustomerObj implements Customer {
    name: string;
    email: string;
    mobile: string;
    landline?: string;
    dateOfBirth: Date;

    constructor (name: string, email: string, mobile: string, dob: Date) {
        this.name = name;
        this.email = email;
        this.mobile = mobile;
        this.dateOfBirth = dob;
    }
}

let cObj: Customer = new CustomerObj("name", "email", "mobile", new Date());

/*
    One thing that you can do with interfaces which you can't achieve with
    types, is Declaration Merging - combining multiple interfaces with the
    same name into a single one at runtime.

    With types you'd need to rename them and union them together.
*/
interface Point {
    x: number
};
interface Point {
    y: number
}

let p: Point = {    // Fields from both declarations
    x: 10,
    y: 10
};