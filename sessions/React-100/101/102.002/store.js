import { createStore, applyMiddleware, compose } from "redux";
import rootReducer from "./reducers";
import logger from "redux-logger";
import { apiMiddleware } from "redux-api-middleware";

export default createStore(
  rootReducer,
  {},
  compose(applyMiddleware(logger, apiMiddleware), window.devToolsExtension ? window.devToolsExtension() : (f) => f)
);
