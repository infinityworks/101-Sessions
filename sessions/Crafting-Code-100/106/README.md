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

1. ???

### Getting Started

Pull down the kata files, and ensure you can run the Golden Master test.



### Tips

Any tips on navigating the task more easily

### Resources

* any links to helpful resources
