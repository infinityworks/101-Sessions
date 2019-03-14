export default (state, action) => {
  switch(action.type) {
    case 'increment':
      return { ...state, count: state.count + action.amount };
    case 'decrement':
      return { ...state, count: state.count - action.amount };
  }
  return state || { count: 0 }
};

export const increment = (amount = 1) => ({ type: 'increment', amount });
export const decrement = (amount = 1) => ({ type: 'decrement', amount });
