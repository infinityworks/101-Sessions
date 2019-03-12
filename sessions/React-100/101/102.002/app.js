import React from 'react';
// NEW: Import the connect function to load the state from redux.
import { connect } from 'react-redux';
import CssBaseline from '@material-ui/core/CssBaseline';
import Header from './components/header';
import UpDownButton from './components/updownbutton';
import CountDisplay from './components/countDisplay';

const App = ({ count, incrementer, decrementer }) => (
  <React.Fragment>
    <CssBaseline />
    <Header />
    <CountDisplay count={count} />
    <UpDownButton label="Up" onClick={() => incrementer()} />
    <UpDownButton label="Down" onClick={() => decrementer()} />
  </React.Fragment>
);

const mapStateToProps = state => ({
  count: state.count,
});

const mapDispatchToProps = dispatch => ({
  incrementer: (amount = 1) => dispatch({ type: 'increment', amount }),
  decrementer: (amount = 1) => dispatch({ type: 'decrement', amount }),
})

export default connect(mapStateToProps, mapDispatchToProps)(App);
