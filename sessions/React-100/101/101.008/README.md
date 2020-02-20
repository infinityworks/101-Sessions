# React example using JSX

Shows the use of Node.js tooling such as `parcel` to convert JSX into minified `React.createElement` statements.

## Setup

* Install `node.js`
* Install `yarn`
* Install global dependencies
   * `yarn add global cross-env parcel`
* Install project dependencies
   * `yarn install`
   * This will take a while, since it's got to download all dependencies
* Run the app
  * `yarn start`

## Learn

* Inspect `package.json`, note how the dependencies for the `Node.js` app are listed.
* Inspect `package.json`, review the scripts section.
* Learn how `yarn` can be used to replace `npm` in the Node.js ecosystem.
* Try out hot reloading.
* Replace the `Hello` component with the `HelloWorld` component. Notice that they provide the same functionality.
* Learn how React classes can be replaced with functions versions.
* Note how `parcel` creates a `dist` directory containing readable versions of the code.
* Try out `parcel build index.html` and inspect the minified output.
* Run a web server in the `dist` directory to run a production version.
