import React from 'react';
import ReactDOM from 'react-dom';

class Hello extends React.Component {
    render() {
      return (
        <div>
          Hello {this.props.name}
        </div>
      );
    }
  }

// As a stateless functional component.
const HelloWorld = ({name}) => (
    <div>
        Hello {name}
    </div>
);

ReactDOM.render(<Hello name="Mr Anderson" />, document.getElementById('app'));

if (module.hot) {
    module.hot.accept();
}