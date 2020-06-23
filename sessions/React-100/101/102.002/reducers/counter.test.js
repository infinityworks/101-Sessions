import counter from "./counter";
import { COUNTER_INCREMENT, COUNTER_DECREMENT } from "../actionTypes";

describe("reducers > counter", () => {
  it("should return default state when no action provided and no state exists", () => {
    const state = undefined;
    const action = {};
    const expectedState = { count: 0 };

    expect(counter(state, action)).toMatchObject(expectedState);
  });

  it("should return current state when no action provided but state exists", () => {
    const existingState = { count: 2 };
    const action = {};
    const expectedState = { count: 2 };

    expect(counter(existingState, action)).toMatchObject(expectedState);
  });

  it("should return new state when counter increment action happens on default state", () => {
    const state = { count: 0 };
    const amount = 1;
    const action = {
      type: COUNTER_INCREMENT,
      amount
    };

    const expectedState = { count: 1 };

    expect(counter(state, action)).toMatchObject(expectedState);
  });

  it("should return new state when counter increment action happens on existing state", () => {
    const state = { count: 10 };
    const amount = 1;
    const action = {
      type: COUNTER_INCREMENT,
      amount
    };

    const expectedState = { count: 11 };

    expect(counter(state, action)).toMatchObject(expectedState);
  });

  it("should return new state when counter decrement action happens on default state", () => {
    const state = { count: 0 };
    const amount = 1;
    const action = {
      type: COUNTER_DECREMENT,
      amount
    };

    const expectedState = { count: -1 };

    expect(counter(state, action)).toMatchObject(expectedState);
  });

  it("should return new state when counter decrement action happens on existing state", () => {
    const state = { count: 10 };
    const amount = 1;
    const action = {
      type: COUNTER_DECREMENT,
      amount
    };

    const expectedState = { count: 9 };

    expect(counter(state, action)).toMatchObject(expectedState);
  });
});
