# React example without JSX

Demonstrates that JSX is optional, and that you don't _have_ to use any Node.js tooling to use React.
Open html file with web browser
Un-comment jsx code and show error in the web browser

Go to:
https://babeljs.io/en/repl
Copy JSX function which returns 

function HelloWorld() {
  return /*#__PURE__*/React.createElement("div", null, "Hello ", this.props.name);
}

Explain we need a transcompiler to convert into javascript the browser can understand