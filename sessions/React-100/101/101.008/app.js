import React, { useState, useEffect } from 'react';
import CssBaseline from '@material-ui/core/CssBaseline';
import Header from './components/header';
import UpDownButton from './components/updownbutton';
import CountDisplay from './components/countDisplay';

export default ({countGetter, countIncrementer, countDecrementer}) => {
  const [count, setCount] = useState(0);
  const [incrementing, setIncrementing] = useState(false);
  const [decrementing, setDecrementing] = useState(false);

  // Functions to increment and decrement the count.
  const incrementer = () => setIncrementing(true);
  const decrementer = () => setDecrementing(true);
 
  const fetchCount = async () => 
    setCount((await countGetter()).count);

  // Get details on load.
  useEffect(() => {
    fetchCount();
  }, []);

  const incrementCount = async() => {
    if (!incrementing) {
      return;
    }
    setCount((await countIncrementer()).count);
    setIncrementing(false);
  }

  useEffect(() => {
    incrementCount()
  }, [ incrementing ]);

  const decrementCount = async() => {
    if (!decrementing) {
      return;
    }
    setCount((await countDecrementer()).count);
    setDecrementing(false);
  }

  useEffect(() => {
    decrementCount()
  }, [ decrementing ]);

  return (
    <React.Fragment>
      <CssBaseline />
      <Header />
      <CountDisplay count={count} />
      <UpDownButton label="Up" action={incrementer} disabled={incrementing} />
      <UpDownButton label="Down" action={decrementer} disabled={decrementing} />
    </React.Fragment>
  );
};