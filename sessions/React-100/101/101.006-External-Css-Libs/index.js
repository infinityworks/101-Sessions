import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import Header from './components/Header'
import Button from './components/Button'
import CountDisplay from './components/CountDisplay'

const App = () => {
  const [count, setCount] = useState(0); // Initial count of zero.

  // Functions to increment and decrement the count.
  const incrementer = () => setCount(count + 1);
  const decrementer = () => setCount(count - 1);

  return (
    <>
    <h1>this</h1>
      <Header/>
      <CountDisplay count={count} />
      <Button label="Up" action={incrementer} />
      <Button label="Down" action={decrementer} />
    </>
  );
};

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}