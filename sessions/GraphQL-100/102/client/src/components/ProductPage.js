import React from "react";
import { Query, Mutation } from "react-apollo";
import { gql } from "apollo-boost";

import Header from "./Header";
import Footer from "./Footer";

const GET_PRODUCT = gql`
  # get product here
`;

const CREATE_ORDER = gql`
  # mutation here
`;

const ProductPage = props => (
  <div className="App">
    <Header />
    <Query
      query={GET_PRODUCT}
      variables={{ sku: parseInt(props.match.params.id) }}
    >
      {({ loading, error, data }) => {
        console.log(props.match.params.id, "<<<");
        if (loading) return <p>Loading...</p>;
        if (error) return <p>Error :(</p>;

        return (
          <div className="product">
            <img src={data.getProduct.image} width="160" height="160" alt=""/>
            <p>
              <b>{data.getProduct.name}</b>
            </p>
            <p>${data.getProduct.price}</p>
            {data.getProduct.inStock ? (
              <Mutation
                mutation={CREATE_ORDER}
                variables={{ sku: parseInt(props.match.params.id) }}
                onError={() => {}}
              >
                {(newOrder, result) => {
                  const { data, loading, error, called } = result;

                  if (!called) {
                    return (
                      <div className="buy-button" onClick={newOrder}>
                        Buy Now
                      </div>
                    );
                  }

                  if (loading) {
                    return <div className="buy-button">Loading...</div>;
                  }

                  if (error) {
                    return <div className="buy-button">Error...</div>;
                  }

                  const { createOrder } = data;

                  if (createOrder) {
                    const { id } = createOrder;

                    return <div>{`Created order with id ${id}`}</div>;
                  } else return null;
                }}
              </Mutation>
            ) : (
              "Not available :("
            )}
          </div>
        );
      }}
    </Query>
    <Footer />
  </div>
);

export default ProductPage;
