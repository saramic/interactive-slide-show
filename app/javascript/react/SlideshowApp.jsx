import React from "react";
import { Router } from "@reach/router";
import { ApolloProvider } from "react-apollo";
import ApolloClient from "../api/ApolloClient";
import Slideshow from "./Slideshow";

export default function SlideshowApp() {
  return (
    <ApolloProvider client={ApolloClient}>
      <Router>
        <Slideshow path="slideshows/:slideshowId/slides/:slideId" />
      </Router>
    </ApolloProvider>
  );
}
