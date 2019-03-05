import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import Header from './components/header'
import UpDownButton from './components/updownbutton'
import CountDisplay from './components/countDisplay'
// NEW: Let's make our app look better.
import styled, { createGlobalStyle } from 'styled-components';

// Configure global styles.
const GlobalStyle = createGlobalStyle`
    body {
        font-family: sans-serif
    }
`;

// Top-level styles.
const AppContainer = styled.div`
    padding: 30px;
    padding-top: 10px;
    background-color: #eeeeee;
`;

const App = ({ name }) => {
  const [count, setCount] = useState(0); // Initial count of zero.

  // Functions to increment and decrement the count.
  const incrementer = () => setCount(count + 1);
  const decrementer = () => setCount(count - 1);

  return (
    <AppContainer>
      <GlobalStyle />
      <Header />
      <div>
        <CountDisplay count={count} />
      </div>
      <div>
        <UpDownButton label="Up" action={incrementer} />
        <UpDownButton label="Down" action={decrementer} />
      </div>
    </AppContainer>
  );
}

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}