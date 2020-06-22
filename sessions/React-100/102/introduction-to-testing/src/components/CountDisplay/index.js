import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div``;

const CountDisplay = ({count}) => (
  <Wrapper>
    <h3>Current Count: {count}</h3>
  </Wrapper>
);

export default CountDisplay;