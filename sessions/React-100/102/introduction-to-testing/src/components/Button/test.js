import { shallow, mount } from 'enzyme';
import React from 'react';
import Button from '.';

const onClick = jest.fn();

describe('Button', () => {
	let element;
	const button = {
		text: 'Button Text',
		onClick
	};

	beforeEach(() => {
		element = shallow(<Button {...button} />);
	});
	it('fires the onClick event when clicked', () => {
		expect(onClick).not.toHaveBeenCalled();
		element.find('CustomButton').prop('onClick')();
		expect(onClick).toHaveBeenCalledTimes(1);
	});
	it('should render children as text', () => {
		expect(
			element
				.find('CustomButton')
				.render()
				.text()
		).toEqual('Hello');
	});
	it('should render pointer', () => {
		element = mount(<Button {...button}> Hello </Button>);
		expect(element.find('CustomButton')).toHaveStyleRule(
			'cursor',
			'pointer'
		);
	});
	it('should render pointer', () => {
		element = mount(
			<Button {...button} isDisabled> Hello </Button>
		);
		expect(element.find('CustomButton')).toHaveStyleRule(
			'cursor',
			'not-allowed'
		);
	});
});
