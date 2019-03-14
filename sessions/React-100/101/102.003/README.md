# React example using JSX

Breaking up the app into two sections, to add a colour picker.

At this point, it makes sense to break the state up into multiple sections, one bit for the color picker, the other bit of state for the counter.

## Setup

* Run the code with `yarn start`.

## Learn

* Replace the dispatch code with "action creator" functions:

```js
const mapDispatchToProps = dispatch => ({
  onIncrement: (amount = 1) => dispatch({ type: 'increment', amount }),
  onDecrement: (amount = 1) => dispatch({ type: 'decrement', amount }),
  onChangeColor: color => dispatch({ type: 'changeColor', color }),
})
```

To something like:

```js
// Action creators
const createIncrement = (amount) => ({ type: ACTION_INCREMENT, amount });

const mapDispatchToProps = {
  onIncrement: createIncrement,
  onDecrement: ...,
  onChangeColor: ...,
}
```

* Use combineReducers and move reducers to their own file.

```js
const rootReducer = (state, action) => {
  switch(action.type) {
    case 'increment':
      return { ...state, counter: { ...state.counter, count: state.counter.count + action.amount } }; // WTF?
    case 'decrement':
      return { ...state, counter: { ...state.counter, count: state.counter.count - action.amount } };
    case 'changeColor':
      return { ...state, colorpicker: { ...state.colorpicker, color: action.color } };
  }
  return state;
}
```
