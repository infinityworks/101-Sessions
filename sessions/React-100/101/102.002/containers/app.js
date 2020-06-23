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
import { getItems } from "../actions/items";
import { Button } from "@material-ui/core";
const renderItems = (items) => {
  return (
    <ul>
      {items.map((item, key) => (
        <li key={key}>{item.label}</li>
      ))}
    </ul>
  );
};

const App = ({ count, onIncrement, onDecrement, color, onChangeColor, itemsLoading, onClickItems, items }) => (
  <React.Fragment>
    <CssBaseline />
    <Header />
    <Counter count={count} onIncrement={onIncrement} onDecrement={onDecrement} backgroundColor={color} />\
    <ColorPicker color={color} onChangeColor={onChangeColor} />
    <div>
      <Button variant="contained" color="primary" onClick={onClickItems}>
        Get me some items NOW!!
      </Button>
      {itemsLoading && <span>LOADING!</span>}
      {items && renderItems(items)}
    </div>
  </React.Fragment>
);

const mapStateToProps = (state) => ({
  count: getCount(state),
  color: getColor(state),
  itemsLoading: state.items.isLoading,
  items: state.items.data
});

const mapDispatchToProps = {
  onIncrement: increment,
  onDecrement: decrement,
  onChangeColor: changeColor,
  onClickItems: getItems
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
