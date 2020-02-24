import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import CssBaseline from '@material-ui/core/CssBaseline';
import Header from './components/header'
import UpDownButton from './components/updownbutton'
import CountDisplay from './components/countDisplay'

const App = () => {
  const [count, setCount] = useState(0); // Initial count of zero.

  // Functions to increment and decrement the count.
  const incrementer = () => setCount(count + 1);
  const decrementer = () => setCount(count - 1);

  return (
    <React.Fragment>
      <CssBaseline />
      <Header/>
      <CountDisplay count={count} />
      <UpDownButton label="Up" action={incrementer} />
      <UpDownButton label="Down" action={decrementer} />
    </React.Fragment>
  );
};

ReactDOM.render(<App />, document.getElementById('app'));

if (module.hot) {
  module.hot.accept();
}