import { COUNTER_INCREMENT, COUNTER_DECREMENT, COLOR_PICKER_CHANGE_COLOR } from "../actionTypes";

const rootReducer = (state, action) => {
  switch (action.type) {
    // Counter reducer
    case COUNTER_INCREMENT:
      return { ...state, count: state.count + action.amount };
    case COUNTER_DECREMENT:
      return { ...state, count: state.count - action.amount };

    // Color picker reducer
    case COLOR_PICKER_CHANGE_COLOR:
      return { ...state, color: action.color };
  }
  return state;
};

export default rootReducer;
