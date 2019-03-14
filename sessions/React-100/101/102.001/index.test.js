import React from 'react';
import App from './app';
import Header from './components/header';
import { configure, shallow, mount, render } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });

describe('<App />', () => {
  it('renders a <Header /> component', () => {
    const wrapper = shallow(<App />);
    expect(wrapper.find(Header).length).toBe(1);
  });
  //TODO: Check that the App has rendered other important components.
});
