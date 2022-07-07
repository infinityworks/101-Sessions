# Inside Out

Having tried using an [Outside In](../104/) approach, this session with tackle the problem from the other direction, focussing on the smallest type/class in the kata, and exploring its behaviour, before working our way out towards the end solution.

## Benefits of the approach

* Establishes core responsibilities early
* Helps to limit the amount of information shared between collaborators

## Downsides of the approach

* We don't get any shippable software until the end! 

## Sessions Objectives

* Understand what an inside-out approach helps us with
* Gain insight into where it might be useful

## Task

1. Determine the smallest entity within the kata
1. Use TDD to build out this entity's behaviour, keeping in mind what it should and shouldn't know about
1. Once you have exhausted this entity's responsibilities, choose the next largest entity that collaborates with the previous completed entity
1. Continue working your way out, until the kata is complete 

### Getting Started

This session is best done on a kata the group have already completed a few times, so as to have them comfortable on how to solve - or at least make good progress in - the kata.

The kata should have sufficient complexity where two or more collaborators are to be created. I would suggest the Game of Life or Mars Rover kata for this session.

### Tips

Be mindful of minimising the amount of information that is exposed to the first entity, and the amount of work it has to do.

### Resources

* NA
