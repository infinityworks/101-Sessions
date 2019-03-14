# React example using JSX

Refactor to use Redux to make it easier to test.

```bash
yarn add redux react-redux
```

Removed almost all of the code from `App`, we're going back to a simple state, no API.

Completely rewritten `index.js` to add a default state, reducer, and wrap the `App` in a `Provider` which provides the state.

Note that the app's properties aren't set at all. The app is now going to get its properties from the redux store.

In the `App`, it's been rewritten to lose any concept about state, and just receive properties (props).

## Setup

* Run the code with `yarn start`.

## Learn

* Add another button and count property to the state, increment it by dispatching an action which is handled by a reducer.