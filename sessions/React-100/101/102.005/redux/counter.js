import 'isomorphic-fetch';
import { RSAA } from 'redux-api-middleware';
import { combineReducers } from '../../../../../../../Library/Caches/typescript/3.3/node_modules/redux';

const baseURL = 'http://localhost:3000/count';

export const COUNT_GET_REQUEST = '@@count/COUNT_GET_REQUEST'
export const COUNT_GET_SUCCESS = '@@count/COUNT_GET_SUCCESS'
export const COUNT_GET_FAILURE = '@@count/COUNT_GET_FAILURE'

export const getCount = () => ({
  [RSAA]: {
    endpoint: baseURL,
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
    types: [
      COUNT_GET_REQUEST,
      COUNT_GET_SUCCESS,
      COUNT_GET_FAILURE
    ]
  }
});

export const COUNT_INCREMENT_REQUEST = '@@count/COUNT_INCREMENT_REQUEST'
export const COUNT_INCREMENT_SUCCESS = '@@count/COUNT_INCREMENT_SUCCESS'
export const COUNT_INCREMENT_FAILURE = '@@count/COUNT_INCREMENT_FAILURE'

export const increment = () => ({
  [RSAA]: {
    endpoint: baseURL + '/increment',
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    types: [
      COUNT_INCREMENT_REQUEST,
      COUNT_INCREMENT_SUCCESS,
      COUNT_INCREMENT_FAILURE
    ]
  }
});

export const COUNT_DECREMENT_REQUEST = '@@count/COUNT_DECREMENT_REQUEST'
export const COUNT_DECREMENT_SUCCESS = '@@count/COUNT_DECREMENT_SUCCESS'
export const COUNT_DECREMENT_FAILURE = '@@count/COUNT_DECREMENT_FAILURE'

export const decrement = () => ({
  [RSAA]: {
    endpoint: baseURL + '/decrement',
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    types: [
      COUNT_DECREMENT_REQUEST,
      COUNT_DECREMENT_SUCCESS,
      COUNT_DECREMENT_FAILURE
    ]
  }
});

const count = (state, action) => {
  switch(action.type) {
    case COUNT_GET_SUCCESS:
      return action.payload.count;
    case COUNT_INCREMENT_SUCCESS:
      return state + 1;
    case COUNT_DECREMENT_SUCCESS:
      return state - 1;
  }
  return state || 0;
};

const error = (state, action) => {
  switch(action.type) {
    case COUNT_GET_FAILURE:
    case COUNT_INCREMENT_FAILURE:
      return "bad things";
    case COUNT_DECREMENT_REQUEST:
    case COUNT_INCREMENT_REQUEST:
      return "";
  }
  return state || ""
};

export default combineReducers({
  count,
  error,
});