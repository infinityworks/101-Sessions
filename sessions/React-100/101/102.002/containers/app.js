import React from "react";
// NEW: Import the connect function to load the state from redux.
import { connect } from "react-redux";
import CssBaseline from "@material-ui/core/CssBaseline";
import Header from "../components/header";
import { increment, decrement } from "../actions/counter";
import { getCount } from "../selectors/counter";
import Counter from "../components/counter";

const App = ({ count, onIncrement, onDecrement }) => (
  <React.Fragment>
    <CssBaseline />
    <Header />
    <Counter count={count} onIncrement={onIncrement} onDecrement={onDecrement} backgroundColor="green" />
  </React.Fragment>
);

const mapStateToProps = (state) => ({
  count: getCount(state)
});

const mapDispatchToProps = (dispatch) => ({
  onIncrement: (amount = 1) => dispatch(increment(amount)),
  onDecrement: (amount = 1) => dispatch(decrement(amount))
});

export default connect(mapStateToProps, mapDispatchToProps)(App);
