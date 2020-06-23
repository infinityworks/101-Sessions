import { COLOR_PICKER_CHANGE_COLOR } from "../actionTypes";

export default (state, action) => {
  switch (action.type) {
    case COLOR_PICKER_CHANGE_COLOR:
      return { ...state, color: action.color };
    default:
      return state || { color: "#ffffff" };
  }
};
