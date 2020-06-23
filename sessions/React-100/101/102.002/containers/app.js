import React from "react";
// NEW: Import the connect function to load the state from redux.
import { connect } from "react-redux";
import CssBaseline from "@material-ui/core/CssBaseline";
import { increment, decrement } from "../actions/counter";
import { changeColor } from "../actions/colorPicker";
import { getCount } from "../selectors/counter";
import { getColor } from "../selectors/colorPicker";
import Header from "../components/header";
import Counter from "../components/counter";
import ColorPicker from "../components/colorPicker";

const App = ({ count, onIncrement, onDecrement, color, onChangeColor }) => (
  <React.Fragment>
    <CssBaseline />
    <Header />
    <Counter count={count} onIncrement={onIncrement} onDecrement={onDecrement} backgroundColor={color} />\
    <ColorPicker color={color} onChangeColor={onChangeColor} />
  </React.Fragment>
);

const mapStateToProps = (state) => ({
  count: getCount(state),
  color: getColor(state)
});

const mapDispatchToProps = {
  onIncrement: increment,
  onDecrement: decrement,
  onChangeColor: changeColor
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
