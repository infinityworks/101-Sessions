import React from 'react';
import Button from './updownbutton'
import Adapter from 'enzyme-adapter-react-16';
import { configure, shallow, mount } from 'enzyme';
import renderer from 'react-test-renderer'

configure({ adapter: new Adapter() });

describe('Components/Button', () => {
  it('should match the snapshot', () => {
    const snapshot = (Tree) => renderer.create(Tree).toJSON();
    const button = snapshot(<Button label="Hello" />);
    expect(button).toMatchSnapshot();
  });

  it('should execute onClick', () => {
    //TODO: replace with jest.fn
    let onClickCalled = false;
    const onClick = () => {
      onClickCalled = true;
    }
    const button = shallow(<Button label="Hello" onClick={onClick} />);
    button.simulate('click');
    expect(onClickCalled).toBe(true);
  });

  it('should be disabled when disabled is set to true', () => {
    const button = mount(<Button label="Hello" disabled={true} />);
    expect(button.find('button').prop('disabled')).not.toBeUndefined();
  });
});
