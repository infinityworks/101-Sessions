// Inner html of a classs
<div>
  <p>Hello World</p>
  <p>The world says hello {name}</p>
</div>

// How to write in JS
React.createElement(
  "div", 
  null, 
  React.createElement("p", null, "Hello World"), 
  React.createElement("p", null, "The world says hello ", name)
);