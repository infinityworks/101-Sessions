import React from "react";
import { Link } from "react-router-dom";
import { Query } from "react-apollo";
import { gql } from "apollo-boost";

const ProductList = () => (
  <Query
    query={gql`
      # get products here
    `}
  >
    {({ loading, error, data }) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;

      return data.getProducts.map(({ name, image, price, sku }, index) => (
        <div className="product" key={index}>
          <Link to={`/product/${sku}`}>
            <img src={image} width="160" height="160" alt=""/>
            <p>
              <b>{name}</b>
            </p>
            <p>${price}</p>
          </Link>
        </div>
      ));
    }}
  </Query>
);

export default ProductList;
