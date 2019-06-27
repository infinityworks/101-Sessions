import React from "react";
import "./App.css";
import { ApolloProvider } from "react-apollo";
import client from "./apolloClient";
import { BrowserRouter as Router, Route } from "react-router-dom";

import ProductPage from "./components/ProductPage";
import OrdersPage from "./components/OrdersPage";
import HomePage from "./components/HomePage";

function App() {
  return (
    <ApolloProvider client={client}>
      <Router>
        <Route path="/" exact component={HomePage} />
        <Route path="/product/:id" component={ProductPage} />
        <Route path="/orders" component={OrdersPage} />
      </Router>
    </ApolloProvider>
  );
}

export default App;
