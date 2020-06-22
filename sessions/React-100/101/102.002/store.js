import { createStore } from "redux";
import rootReducer from "./reducers";

const defaultState = {
  count: 0,
  incrementing: false, // Don't worry about these for now, the decrement and increment is instant.
  decrementing: false,
  color: "#ffffff"
};

export default createStore(
  rootReducer,
  defaultState,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);
