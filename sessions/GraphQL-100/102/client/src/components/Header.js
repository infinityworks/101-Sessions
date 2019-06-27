import React from 'react';
import { Link } from 'react-router-dom';

const Header = () => (
  <header className="App-header">
    <h1>
      <a href="/">{`<StickerSwag />`}</a>
    </h1>
    <div className="App-navigation">
      <Link to="/">Products</Link>
      <Link to="/orders">Orders</Link>
    </div>
  </header>
);

export default Header;