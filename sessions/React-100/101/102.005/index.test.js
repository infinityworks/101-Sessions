import React from 'react';
import { createStore} from 'redux';
import { Provider } from 'react-redux';
import ReactDOM from 'react-dom';
import { App } from './app';

describe('<App />', () => {
  it('renders without crashing', () => {
    const div = document.createElement('div');
    ReactDOM.render(<App count={1} color={"#ff0000"} fetchCount={jest.fn()} />, div);
    ReactDOM.unmountComponentAtNode(div);
  });
});
