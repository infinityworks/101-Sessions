import 'babel-polyfill';
//NEW: Required to make async/await work.
import React, { useState, useEffect } from 'react';
//NEW: useEffect
import ReactDOM from 'react-dom';
import CssBaseline from '@material-ui/core/CssBaseline';
import Header from './components/header';
import UpDownButton from './components/updownbutton';
import CountDisplay from './components/countDisplay';
import fetch from 'isomorphic-fetch';

const baseURL = 'http://localhost:3000/count';

const apiCountGetter = async () => {
  const result = await fetch(baseURL, {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  return await result.json();
};

const apiCountIncrementer = async () => {
  const result = await fetch(baseURL + '/increment', {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  return await result.json();
};

const apiCountDecrementer = async () => {
  const result = await fetch(baseURL + '/decrement', {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  return await result.json();
};

const App = ({countGetter, countIncrementer, countDecrementer}) => {
  const [count, setCount] = useState(0);
  const [incrementing, setIncrementing] = useState(false);
  const [decrementing, setDecrementing] = useState(false);

  // Functions to increment and decrement the count.
  const incrementer = () => setIncrementing(true);
  const decrementer = () => setDecrementing(true);
 
  const fetchCount = async () => 
    setCount((await countGetter(setCount)).count);

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
      <Header/>
      <CountDisplay count={count} />
      <UpDownButton label="Up" action={incrementer} disabled={incrementing} />
      <UpDownButton label="Down" action={decrementer} disabled={decrementing} />
    </React.Fragment>
  );
};

ReactDOM.render(<App
  countGetter={apiCountGetter}
  countIncrementer={apiCountIncrementer}
  countDecrementer={apiCountDecrementer}
/>, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}