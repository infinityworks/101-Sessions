import { ITEMS_GET_REQUEST, ITEMS_GET_SUCCESS, ITEMS_GET_FAILURE } from "../actionTypes";

export default (state, action) => {
  switch (action.type) {
    case ITEMS_GET_REQUEST:
      return {
        ...state,
        isLoading: true
      };
    case ITEMS_GET_SUCCESS:
      console.log("ACTION", action);
      return {
        ...state,
        isLoading: false,
        data: action.payload
      };
    case ITEMS_GET_FAILURE:
      return {
        ...state,
        isLoading: false,
        data: []
      };
    default:
      return (
        state || {
          isLoading: false,
          data: []
        }
      );
  }
};
