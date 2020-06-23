const { COLOR_PICKER_CHANGE_COLOR } = require("../actionTypes");

import { changeColor } from "./colorPicker";

describe("actions > colorPicker", () => {
  it("should return the Redux action ", () => {
    const color = "red";
    const expectedAction = {
      type: COLOR_PICKER_CHANGE_COLOR,
      color
    };

    expect(changeColor(color)).toMatchObject(expectedAction);
  });
});
