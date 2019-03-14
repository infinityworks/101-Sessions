export default (state, action) => {
  switch(action.type) {
    case 'changeColor':
      return { ...state, color: action.color };
  }
  return state || { color: "#ffffff" }
};

export const changeColor = color => ({ type: 'changeColor', color });
