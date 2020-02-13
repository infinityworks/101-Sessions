import React from 'react';
import ReactDOM from 'react-dom';

// Convert to ES6 const
function HelloWorld (props) {
  return (
    <div>
      Hello {props.name}
    </div>
  )
}

ReactDOM.render(<HelloWorld name="Mr Anderson" />, document.getElementById('app'));

if (module.hot) {
    module.hot.accept();
}