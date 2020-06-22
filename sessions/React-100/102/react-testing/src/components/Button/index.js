import React from 'react';
import styled from 'styled-components';

const CustomButton = styled.button`
  text-align: center;
  color: white;
  cursor: pointer;
  background-color: green;
  padding: 15px;
  margin: 10px;
  border: 0;
  border-radius: 10px;
  transition: background-color 0.25s, border-color 0.25s, color 0.25s;

  :hover {
    background-color: lime;
  }

  :disabled {
    background-color: gray;
	}
`;
CustomButton.displayName = 'CustomButton';

const Button = ({text, onClick, isDisabled = false}) => (
  <CustomButton onClick={onClick} disabled={isDisabled}>
    {text}
  </CustomButton>
);

export default Button;