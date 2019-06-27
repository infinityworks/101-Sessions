import React from "react";
import { Query, Subscription } from "react-apollo";
import { gql } from "apollo-boost";
import moment from "moment";

import Header from "./Header";
import Footer from "./Footer";

const GET_ORDERS = gql`
  {}
`;

const OrdersPage = props => (
  <div className="App">
    <Header />
    <h2>Orders</h2>
    <Query query={GET_ORDERS}>
      {({ loading, error, data }) => {
        if (loading) return <p>Loading...</p>;
        if (error) return <p>Oops something went wrong 😵</p>;
        console.log(data.getOrders);
        return data.getOrders.map(order => (
          <div key={order.id} className="orderRow">
            <p>Order ID: {order.id}</p>
            <p>{moment(parseInt(order.orderDate)).format("HH:mm D/M/YY")}</p>
            <p>Product: {order.product.name}</p>
          </div>
        ));
      }}
    </Query>
    <Footer />
  </div>
);

export default OrdersPage;
