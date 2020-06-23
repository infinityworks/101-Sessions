import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  
`;

const Header = ({ textAlign }) => (
  <Wrapper textAlign={textAlign}>
    <h1>Couter</h1>
  </Wrapper>
);

export default Header;