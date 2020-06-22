import React, { useState } from 'react';

import Header from './components/Header';
import Button from './components/Button';
import CountDisplay from './components/CountDisplay';


function App() {
  const [count, setCount] = useState(0);

  const incrementer = () => {
    setCount(count + 1)
  }

  const decrementer = () => {
    setCount(count - 1)
  }

  return (
    <React.Fragment>
      <Header textAlign="center" />
      <CountDisplay count={count} />
      <Button onClick={incrementer} text="Increase Count" />
      <Button onClick={decrementer} text="Decrease Count" />
    </React.Fragment>
  );
}

export default App;
