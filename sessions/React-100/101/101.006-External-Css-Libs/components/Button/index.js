import React from 'react';

const Button = ({ label, action }) => (
  <input type="button" value={label} onClick={action}/>
);

export default Button;
