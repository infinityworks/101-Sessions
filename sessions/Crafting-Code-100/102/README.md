# TDD as if you mean it with the Baby Steps constraint

The red/shameful green/refactor process is all well and good, but its often tempting to rush ahead and try and code for future tests, or refactor too early and get stuck in a mess of failing tests.

This session seeks to keep that temptation in check by adding the `TDD as if you mean it` constraint, ensuring we only write enough code to satisfy the tests.

## Benefits of the approach

* Relax in the reassuring warmth of green tests, safe in the knowledge that our code works as expected
* Ensure we have maximum coverage by only writing enough code to pass the tests
* Easily revert breaking changes, and come back to safety without minimal 

## Task

1. Perform a kata of your choice
1. In the green phase, be conscious of only writing enough code to pass the tests
1. Refactor as you like, but do not inadvertently add extra complexity eg an extra `if` clause
1. If your tests are red, be conscious of the amount of time they are red. If they red after 5-10 minutes, revert your changes, comment out the last test, and see if there are any refactorings you can make that gets you closer to passing that last test

### Getting Started

We'll enforce the last item on the task description above using the `test && commit || revert` script in the [Resources folder](../Resources/tcr.sh).

* Ensure your kata directory is initialised as a git repository
* Copy and paste the `tcr.sh` file into the root of your kata directory
* Ensure the `tcr.sh` script has execure permissions by running `chmod a+x tcr.sh`
* Run the script `./tcr.sh 300` (the 300 corresponds to the number of seconds you have before it runs the test cycle)
* Have fun!
