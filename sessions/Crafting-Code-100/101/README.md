# Improving our delivery of Software through Test Driven Development and Kata

This first session serves as an introduction to practising our software delivery through code katas, and learn how Test Driven Development (TDD) can help us when things go wrong.

## TDD

The premise of Test Driven Development is to write our tests before the implementation code, as opposed to writing the tests after we have written the implementation code (or not at all!).

Writing code with TDD has us following these steps:

1. RED: Write a failing test
2. GREEN: Make the tests pass in the simplest manner (this step could be described as "shameful green": it passes, but we're not happy with the solution!)
3. REFACTOR: manipulate the existing code, shaping it in a way that is "better" (we'll look at what "better" might mean later)

Repeat these steps, until we have written enough tests to cover our requirements.

## What does "Good Code" look like?

Sometimes it is difficult to describe what good looks like, but we can all identify when something is not right! 

> Optional Exercise: get everyone to write post-its describing examples of bad code, group similarities and have a quick chat about each one.

Some examples of bad code include:

* difficult to read
* over-commented code
* components are tightly coupled - you can't change one without changing the other
* really long classes/functions
* brittle tests
* poor naming
* components do too much
* ambiguous magic strings/numbers
* too much abstraction
* inconsistent abstraction
* hidden side effects
* code is too clever!

## TDD Key Points

* Write the simplest scenario to make your implementation code fail the tests. Calling the non-existent function that is being tested is a failing test! 
* Only add enough complexity to pass the tests
* Your tests are production code too - they need to easily readable and extensible; refactor the tests are you progress, but don't reduce coverage
* Don't spend too much time with failing tests. Failing tests during TDD or refactoring suggests you've taken things a step too far. Comment out the latest test, and revert the breaking changes, and try and refactor towards a structure that will accomodate the requirements of the next test.

### Benefits of this Approach

* 100% coverage - assuming you only write enough complexity to satisfy the tests, you automatically get 100% coverage for the system under test.
* Safe space to refactor - so long as you keep the tests green, you are free to refactor the code, safe in the knowledge you haven't inadvertently introduced a regression ie something that was previously working is now broken
* Tests as documentation - writing your tests to describe and confirm the behaviour of your system doubles up as documentation for your system, reducing the need for comments and 

## Katas

"Kata" is a word from the Japanese language to describe a "form" or "pattern". It is probably most recognisable in relation to [martial arts, where a kata is a sequence of moves and techniques](https://www.youtube.com/watch?v=YOcVfmmMBLY). This sequence is practised repeatedly to attempt to achieve mastery in the individual techniques, as well as wider concepts.

In a software context, code katas describe a set of requirements around a particular domain eg a shopping basket, or card game. By practising a given kata repeatedly, we gain familiarity of the domain, and are then free to focus on improving the process of writing and designing our code.

## Sessions Objectives

* Learn the benefits of TDD
* Practise the TDD process and build "muscle" memory

## Task

1. Choose a simple kata (eg FizzBuzz or Checkout)
1. Follow the TDD process to move towards satisfying all of the requirements in the problem, whilst avoiding the traits of bad code identified earlier
1. ...
1. ~~Profit~~ Have fun!

### Getting Started

* Setup/pull down a base repo with a test framework and a way to run the tests automatically when you save a file.

### Tips

Any tips on navigating the task more easily

### Resources

* [javascript kata base](https://github.com/vincelee888/tdd-kata-base-js)
