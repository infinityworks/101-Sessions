import React from 'react';

import Header from './Header';
import Footer from './Footer';
import ProductList from './ProductList';

const HomePage = () => (
  <div className="App">
    <Header />
    <div className="products">
      <ProductList />
    </div>
    <Footer />
  </div>
);

export default HomePage;