import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App'
import { createStore } from 'redux';
import { Provider } from 'react-redux';

const defaultState = {
  counter: {
    count: 0,
  },
  colorpicker: {
    color: "#000000",
  },
};

const rootReducer = (state, action) => {
  switch(action.type) {
    case 'increment':
      return { ...state, counter: { ...state.counter, count: state.counter.count + action.amount } }; // WTF?
    case 'decrement':
      return { ...state, counter: { ...state.counter, count: state.counter.count - action.amount } };
    case 'changeColor':
      return { ...state, colorpicker: { ...state.colorpicker, color: action.color } };
  }
  return state;
}

const store = createStore(rootReducer, defaultState,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__())

ReactDOM.render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('app')
);

if (module.hot) {
  module.hot.accept();
}