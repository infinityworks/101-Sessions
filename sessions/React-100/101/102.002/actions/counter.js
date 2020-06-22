import { COUNTER_DECREMENT, COUNTER_INCREMENT } from "../actionTypes";

export const increment = (amount) => ({
  type: COUNTER_INCREMENT,
  amount
});
export const decrement = (amount) => ({
  type: COUNTER_DECREMENT,
  amount
});
