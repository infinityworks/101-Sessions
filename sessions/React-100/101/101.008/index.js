import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import fetch from 'isomorphic-fetch';
import App from './App'

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

ReactDOM.render(<App
  countGetter={apiCountGetter}
  countIncrementer={apiCountIncrementer}
  countDecrementer={apiCountDecrementer}
/>, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}