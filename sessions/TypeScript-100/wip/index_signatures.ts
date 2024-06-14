/*
    Index Signatures

    Index signatures in TypeScript give you a way of dealing with types where
    you know the shape of the type, but you're not sure what all of the
    properties will be.
    This feature lets you keep your type safety when accessing the properties
    of the object by index - without this, you'd get any back.
*/
function averageGrades(
    studentMarks: { 
        [index: string]: number 
    } 
): number {
    let total = 0, 
        count = 0;
    for (const subject in studentMarks) {
        let subjectMarks: number = studentMarks[subject];
        total += subjectMarks;
        count++;
    }
    return (count > 0) ? total / count : 0;
}

let studentMarks = {
    science: 85,
    maths: 35,
    english: 45
};
let studentAverageMark: number = averageGrades(studentMarks);

let studentMarks2 = {
    name: "Charlie",
    science: 25,
    art: 95,
    music: 105,
};
let studentAverageMark2: number = averageGrades(studentMarks2);

/*
    You can achieve a similar thing using the Record<Keys, Type> utility type.
*/
function averageGrades2(
    studentMarks: Record<string, number>
): number {
    let total = 0, 
        count = 0;
    for (const subject in studentMarks) {
        let subjectMarks: number = studentMarks[subject];
        total += subjectMarks;
        count++;
    }
    return (count > 0) ? total / count : 0;
}

averageGrades2(studentMarks);
averageGrades2(studentMarks2);

/*
    You can use this as well as named properties.
*/
interface Indexed {
    id: number;
    name: string;
    [index: number]: string;
};

let x: Indexed = {
    id: 1,
    name: "thing",
    42: "test"
}
let y: string = x[42]; // type information provided by index signature.

/*
    This won't work if you declare that you're using string keys.
    Then you're effectively giving conflicting type information.
*/
interface BrokenIndexed {
    id: number;
    [index: string]: string;
}