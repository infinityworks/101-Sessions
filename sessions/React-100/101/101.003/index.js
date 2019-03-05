import React from 'react';
import ReactDOM from 'react-dom';
import Header from './components/header'
// pre-ES6 syntax:
// var Header = require('./components/header').default;

const Hello = ({ name }) => (
  <div>
    Hello {name}
  </div>
);

const App = ({ name }) => (
  <div>
    <Header />
    <Hello name={name} />
  </div>
);

ReactDOM.render(<App name="Mr Anderson" />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}