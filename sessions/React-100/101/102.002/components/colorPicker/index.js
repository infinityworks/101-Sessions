import React from "react";

export default ({ color, onChangeColor }) => (
  <React.Fragment>
    <input type="color" onChange={(e) => onChangeColor(e.target.value)} value={color} />
  </React.Fragment>
);
