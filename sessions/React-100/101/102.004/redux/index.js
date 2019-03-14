import { combineReducers } from 'redux';
import colorReducer from './color'
import counterReducer from './counter'

export default combineReducers({
  counter: counterReducer,
  colorpicker: colorReducer,
});
