# Dealing With No Tests - Golden Master

We need to add a new feature to the system to enable a massive marketing campaign scheduled in for next week. "Easy!" we say, "Its similar to existing behaviour, so will just be a few lines to add..." 

We open up the core component of the system, that the whole company is built upon, only to discover its a complete mess in there, and to rub salt into the wound: there are no tests either!

## Golden Master to the Rescue!

We know that everything is working in there, but the current implementation is impossible to read and add this new feature safely.

With the Golden Master approach, we write a test that exercises the entirety of the system under test, and capture its behaviour in the form of a text file.

As we refactor the code, we can compare the old output (the Golden Master) with the output from our updated code, and so long as they are identical, we are safe to continue.

## Benefits of the approach

* We can create a safety net for the whole system, whilst we tidy up, and add our own, faster-running, suite of tests.

## Sessions Objectives

* Understand how we can wrap legacy code with a comprehensive, if a little slow, test.
* Practice refactoring code
* Practice writing tests that serve as documentation

## Task

We're going to help out the [Gilded Rose](https://github.com/seppevs/gildedrose-js/tree/master) shop expand their product range.

> Note: The initial test output has the new item in it, but it behaves as if it were a standard item

1. Take baby steps and refactor the code, ensuring the latest output matches the original output ie the Shop is behaving as it should be.
1. Once you are happy with the refactored code, update the original output to reflect how the new item should behave, and implement the new feature.

The Golden Master is a great tool to give us that safety net to refactor legacy code. However, it is too slow for a good CI/CD pipeline. We should be good scouts and leave a comprehensive suite of tests behind, documenting the code and describing its behaviour.

### Getting Started

Pull down the kata files, and ensure you can run the Golden Master test.

### Resources

* [The original Gilded Rose kata in C#](https://github.com/NotMyself/GildedRose)
* Emily Bache has [translated the kata into a lots of different languages](https://github.com/emilybache/GildedRose-Refactoring-Kata/), but the Golden Master is written to stdout, rather than a text file
