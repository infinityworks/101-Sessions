import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App'
// New
import { createStore } from 'redux';
import { Provider } from 'react-redux';

const defaultState = {
  count: 0,
  incrementing: false, // Don't worry about these for now, the decrement and increment is instant.
  decrementing: false,
};

const rootReducer = (state, action) => {
  switch(action.type) {
    case 'increment':
      return { ...state, count: state.count + action.amount };
    case 'decrement':
      return { ...state, count: state.count - action.amount };
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