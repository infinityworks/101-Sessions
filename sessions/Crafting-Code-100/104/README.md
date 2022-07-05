# Outside In - a Mockist Approach

In this session, we'll use a Mockist approach to defer complexity, allowing us to continue to take baby steps towards completing the kata.

Most people will approach a kata "Outside In", where we start with a function or class that is the public API of our system under test, and add functionality as we go. This starts to produce a suite of tests as we refactor out new functions and classes to encapsulate parts of the puzzle. 

These tests can be considered "black box" in that our tests only know what goes in, and what comes out; they don't care how that is achieved.

As we work our way through a sufficiently complex kata, we will come to the crux of the problem where we are unable to proceed with the standard Red, Green, Refactor approach without writing lots of code and/or spending too long with failing test - we have an idea of what we want to do, but its too great of a leap to implement it.

## Enter the Mock

At this point, we know that we need a new function/class to take care of this. The Mockist approach is to mock this new function/class, and using it to return what we want it to do, without having to worry _how_ at this stage. With this mock in place, we can get the tests green again, and continue building out our solution.

## A Very Brief History of the TDD Wars

"Mockist" refers to one of two supposed schools of TDD, where the other was "Classicist". These two approaches may also be referred to London (Mockist) and Detroit (Classicist). Like all differing approaches, warring tribes formed on both sides, friends were lost, whilst the core ideals of the thing under contention [were forgotten](https://vimeo.com/68375232).

## Benefits of the approach

* Continue building out our design incrementally
* Defer solving complexity until more context is understood
* Start to establish where responsibilities lie, decoupling components and allowing for easier changes in the future

## Sessions Objectives

* Understand how using Mocks can help us continue to build our design out, whilst retaining the safety net of passing tests.

## Task

1. Begin the kata as normal: writing the simplest, failing test
2. Continue through the red, green, refactor process
3. Eventually, you will hit the crux of the kata, where you need to calculate something, but don't know how to do it
4. Encapsulate this complexity into a new function, and mock its behaviour
5. Continue the kata, using the mock to return what you would expect it to, in the given scenario being tested
6. Once the requirements of the kata are met, replace each instance of the mock with the real implementation, using the now complete suite of tests as your safety net.

### Getting Started

This session is best done on a kata the group have already completed a few times, so as to have them comfortable on how to solve, or at least make good progress in, the kata.

The kata should have sufficient complexity where two or more algorithms to be created.

Be sure you are comfortable with how create and use mocks in your chosen language. 

### Tips

You may find that is appropriate to keep the mocks, and write tests around the mocked function. A situation where this is appropriate is when the mocked function may be replaced with different version eg an algorithm that works for a 2D grid, may be replaced with one that works for a 3D grid.

### Resources

* [Ian Cooper - TDD: Where Did it All Go Wrong?](https://vimeo.com/68375232)
