import { COUNTER_DECREMENT, COUNTER_INCREMENT } from "../actionTypes";

export const increment = (amount = 1) => ({
  type: COUNTER_INCREMENT,
  amount
});
export const decrement = (amount = 1) => ({
  type: COUNTER_DECREMENT,
  amount
});
