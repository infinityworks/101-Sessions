import React from 'react';

const Button = ({ label, action }) => (
  <input type="button" value={label} onClick={action}/>
);

export default Button;

// `
//   display: inline-block;
//   border-radius: 3px;
//   padding: 0.5rem 0;
//   margin: 0.5rem 1rem;
//   width: 11rem;
//   background: black;
//   color: white;
//   border: 2px solid white;
// `