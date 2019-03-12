# React example using JSX

Add unit tests

```bash
yarn global add jest
yarn remove babel-preset-env babel-preset-preact cross-env
yarn add --dev jest babel-jest @babel/plugin-transform-runtime @babel/preset-env @babel/preset-react enzyme enzyme-adapter-react-16 chai
yarn add @babel/runtime
```

Note the updated .babelrc

```json
{
  "presets": ["@babel/env", "@babel/react"],
  "plugins": ["@babel/plugin-transform-runtime"]
}
```

I've moved the `App` component into its own file and added a `index.test.js`.

## Setup

* Run the tests:

```bash
jest
```

## Learn

* Add more tests to test that other components are rendered within the app.
* Run code coverage with `jest --coverage`
