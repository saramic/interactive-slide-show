import React from "react";
import { Router } from "@reach/router";
import { ApolloProvider } from "react-apollo";
import ApolloClient from "../api/ApolloClient";
import Viewing from "./Viewing";

export default function ViewingApp() {
  return (
    <ApolloProvider client={ApolloClient}>
      <Router>
        <Viewing path="viewings/:viewingId" />
      </Router>
    </ApolloProvider>
  );
}
