import React, { useEffect } from 'react';
import { connect } from 'react-redux';
import CssBaseline from '@material-ui/core/CssBaseline';
import Header from './components/header';
import UpDownButton from './components/updownbutton';
import CountDisplay from './components/countDisplay';
import { increment, decrement, getCount } from './redux/counter';
import { changeColor } from './redux/color';

const Counter = ({ count, incrementing, decrementing, onIncrement, onDecrement, backgroundColor }) => (
  <div style={{ backgroundColor: backgroundColor }}>
    <CountDisplay count={count} />
    <UpDownButton label="Up" onClick={() => onIncrement()} disabled={incrementing} />
    <UpDownButton label="Down" onClick={() => onDecrement()} disabled={decrementing} />
  </div>
);

const ColorPicker = ({ color, onChangeColor }) => (
  <React.Fragment>
    <input type="color" onChange={(e) => onChangeColor(e.target.value)} value={color} />
  </React.Fragment>
);

export const App = ({ count, onIncrement, onDecrement,
  color, onChangeColor, fetchCount }) => {
  useEffect(() => {
    fetchCount();
  }, []);

  return (
    <React.Fragment>
      <CssBaseline />
      <Header />
      <Counter count={count} onIncrement={onIncrement} onDecrement={onDecrement} backgroundColor={color} />
      <ColorPicker color={color} onChangeColor={onChangeColor} />
    </React.Fragment>
  );
};

const mapStateToProps = state => ({
  count: state.counter.count,
  color: state.colorpicker.color,
});

const mapDispatchToProps = {
  onIncrement: increment,
  onDecrement: decrement,
  onChangeColor: changeColor,
  fetchCount: getCount,
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
