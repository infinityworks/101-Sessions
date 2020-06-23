import "isomorphic-fetch";
import { createAction } from "redux-api-middleware";
import { ITEMS_GET_REQUEST, ITEMS_GET_SUCCESS, ITEMS_GET_FAILURE } from "../actionTypes";

export const getItems = () =>
  createAction({
    endpoint: "http://5826ed963900d612000138bd.mockapi.io/items",
    method: "GET",
    types: [ITEMS_GET_REQUEST, ITEMS_GET_SUCCESS, ITEMS_GET_FAILURE]
  });
