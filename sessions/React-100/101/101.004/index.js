import React, { useState } from 'react';
//NEW: import { useState }
import ReactDOM from 'react-dom';
import Header from './components/header'
import IncrementButton from './components/incrementButton'
import CountDisplay from './components/countDisplay'

const App = () => {
  const [count, setCount] = useState(0); // Initial count of zero.

  // Function to increment the count.
  const incrementer = () => setCount(count + 1);

  return (
    <div>
      <Header />
      <CountDisplay count={count} />
      <IncrementButton incrementer={incrementer} />
    </div>
  );
}

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}