import React from "react";
import CountDisplay from "./countDisplay";
import UpDownButton from "./upDownButton";

export default ({ count, incrementing, decrementing, onIncrement, onDecrement, backgroundColor }) => (
  <div style={{ backgroundColor: backgroundColor }}>
    <CountDisplay count={count} />
    <UpDownButton label="Up" onClick={() => onIncrement()} disabled={incrementing} />
    <UpDownButton label="Down" onClick={() => onDecrement()} disabled={decrementing} />
  </div>
);
