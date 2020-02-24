import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import Header from './components/header'
import Button from './components/Button'
import CountDisplay from './components/countDisplay'

// APP WRAPPER CSS
  // padding: 30px;
  // padding-top: 10px;
  // background-color: #eeeeee;

const App = () => {
  // Initial count of zero.
  const [count, setCount] = useState(0); 

  // Functions to increment and decrement the count.
  const incrementer = () => setCount(count + 1);
  const decrementer = () => setCount(count - 1);

  return (
    <div>
      <Header />
      <div>
        <CountDisplay count={count} />
      </div>
      <div>
        <Button label="Up" action={incrementer} />
        <Button label="Down" action={decrementer} />
      </div>
    </div>
  );
}

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}