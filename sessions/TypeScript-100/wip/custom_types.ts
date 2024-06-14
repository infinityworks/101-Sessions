/*
    Type Aliases

    You can create your own custom types and then combine these to allow reuse.

    (this example uses literal types to limit the values to those defined)
*/
type Flavoured = { flavour: ("Strawberry" | "Chocolate" | "Banana") };
type Sized = { size: ("S" | "M" | "L") };
type Scooped = { scoops: (1 | 2 | 3) };

/*
    The & syntax creates a type which is the intersection of two existing ones.
*/
type Milkshake = Flavoured & Sized;
let milkshake: Milkshake = {
    flavour: "Strawberry",
    size: "L"
}

let brokenMilshake: Milkshake = {   // error: missing required property from Sized
    flavour: "Chocolate"
}

/*
    The | syntax creates a type which is the union of two existing ones.
*/
type IceCream = Flavoured & ( Sized | Scooped );
let dessert: IceCream = {
    flavour: "Chocolate",
    scoops: 3
};

let strangeDessert: IceCream = {
    flavour: "Banana",
    size: "S"
    // metaphor breaks down here since you can say:
    , scoops: 3
    // which would make little sense.
}

/*
    All of these are Types and so they don't exist at runtime - `typeof` and
    `instanceof` checks won't work with them.
*/
console.log(typeof dessert); // object
console.log(dessert instanceof IceCream); // Compile error: IceCream is a type not a value.

/*
    If a type needs to have some optional properties, this is supported with
    the `name?: type` syntax.
    
    You can also add readonly fields with the `readonly` keyword.
*/
type Customer = {
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