import { getColor } from "./colorPicker";

describe("selectors > colorPicker", () => {
  it("should get the color from the state object", () => {
    const state = {
      colorPicker: {
        color: "blue"
      }
    };

    expect(getColor(state)).toEqual("blue");
  });
});
