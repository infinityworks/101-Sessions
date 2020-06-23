import colorPicker from "./colorPicker";
import { COLOR_PICKER_CHANGE_COLOR } from "../actionTypes";

describe("reducers > colorPicker", () => {
  it("should return default state when no action provided and no state exists", () => {
    const state = undefined;
    const action = {};
    const expectedState = { color: "#ffffff" };

    expect(colorPicker(state, action)).toMatchObject(expectedState);
  });

  it("should return current state when no action provided but state exists", () => {
    const existingState = { color: "green" };
    const action = {};
    const expectedState = { color: "green" };

    expect(colorPicker(existingState, action)).toMatchObject(expectedState);
  });

  it("should return new state when change color happens on unset state", () => {
    const state = undefined;
    const color = "red";
    const action = {
      type: COLOR_PICKER_CHANGE_COLOR,
      color
    };

    const expectedState = { color: "red" };

    expect(colorPicker(state, action)).toMatchObject(expectedState);
  });

  it("should return new state when change color happens on an existing state", () => {
    const existingState = { color: "green" };
    const color = "red";
    const action = {
      type: COLOR_PICKER_CHANGE_COLOR,
      color
    };

    const expectedState = { color: "red" };

    expect(colorPicker(existingState, action)).toMatchObject(expectedState);
  });
});
