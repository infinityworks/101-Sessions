import React from 'react';
import Enzyme, { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import App from './App';

Enzyme.configure({ adapter: new Adapter()})

test('renders learn react link', () => {
  const element = shallow(<App />)
  expect(element.find("Header").exists()).toBe(true)
});
