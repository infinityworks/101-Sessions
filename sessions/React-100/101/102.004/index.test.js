import React from 'react';
import { createStore} from 'redux';
import { Provider } from 'react-redux';
import ReactDOM from 'react-dom';
import App from './app';

describe('<App />', () => {
  it('renders without crashing', () => {
    const div = document.createElement('div');
    const defaultState = {
      counter: {
        count: 0,
      },
      colorpicker: {
        color: "#000000",
      }
    };
    const rootReducer = state => state;
    const store = createStore(rootReducer, defaultState);
    ReactDOM.render(
      <Provider store={store}><App /></Provider>, div);
    ReactDOM.unmountComponentAtNode(div);
  });
  it('dispatches an increment action when the increment button is clicked', () => {
    const div = document.createElement('div');
    const defaultState = {
      counter: {
        count: 0,
      },
      colorpicker: {
        color: "#000000",
      }
    };
    let incrementHappened = false;
    const rootReducer = (state, action) => {
      switch(action.type) {
        case 'increment':
          incrementHappened = true;
      }
      return state;
    };
    const store = createStore(rootReducer, defaultState);
    store.dispatch({ type: 'increment' })
    ReactDOM.render(<Provider store={store}><App /></Provider>, div);
    ReactDOM.unmountComponentAtNode(div);
    expect(incrementHappened).toBe(true);
  });
});
