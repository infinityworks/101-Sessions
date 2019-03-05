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

const apiCountGetter = async (setCount) => {
  const result = await fetch(baseURL, {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  const data = await result.json();
  setCount(data.count);
};

const apiCountIncrementer = async (setCount) => {
  const result = await fetch(baseURL + '/increment', {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  const data = await result.json();
  setCount(data.count);
};

const apiCountDecrementer = async (setCount) => {
  const result = await fetch(baseURL + '/decrement', {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
  });
  const data = await result.json();
  setCount(data.count);
};

const App = ({countGetter, countIncrementer, countDecrementer}) => {
  const [count, setCount] = useState(0);
  const [incrementing, setIncrementing] = useState(false);
  const [decrementing, setDecrementing] = useState(false);

  // Functions to increment and decrement the count.
  const incrementer = () => setIncrementing(true);
  const decrementer = () => setDecrementing(true);
 
  // Get details on load.
  useEffect(() => {
    countGetter(setCount);
  }, []);

  useEffect(() => {
    if (!incrementing) {
      return;
    }
    countIncrementer(setCount);
    setIncrementing(false);
  }, [ incrementing ]);

  useEffect(() => {
    if (!decrementing) {
      return;
    }
    countDecrementer(setCount);
    setDecrementing(false);
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