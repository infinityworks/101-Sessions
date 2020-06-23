import { COUNTER_INCREMENT, COUNTER_DECREMENT } from "../actionTypes";

export default (state, action) => {
  switch (action.type) {
    case COUNTER_INCREMENT:
      return { ...state, count: state.count + action.amount };
    case COUNTER_DECREMENT:
      return { ...state, count: state.count - action.amount };
    default:
      return state || { count: 0 };
  }
};
