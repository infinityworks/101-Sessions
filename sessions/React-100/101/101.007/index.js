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

const App = () => {
  const [count, setCount] = useState(0);
  const [incrementing, setIncrementing] = useState(false);
  const [decrementing, setDecrementing] = useState(false);

  // Functions to increment and decrement the count.
  const incrementer = () => setIncrementing(true);
  const decrementer = () => setDecrementing(true);

  // When the app loads, get the current count.
  const apiGetter = async () => {
    const result = await fetch(baseURL, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    });
    const data = await result.json();
    setCount(data.count);
  };
  
  // Get details on load.
  useEffect(() => {
    apiGetter();
  }, []);

  const apiIncrementer = async () => {
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

  useEffect(() => {
    if (!incrementing) {
      return;
    }
    apiIncrementer();
    setIncrementing(false);
  }, [ incrementing ]);

  const apiDecrementer = async () => {
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

  useEffect(() => {
    if (!decrementing) {
      return;
    }
    apiDecrementer();
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

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}