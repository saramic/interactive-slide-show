// TODO: this did not work but the next 2 lines did?
// import ApolloClient, { gql } from 'apollo-client';
import ApolloClient from "apollo-client";
import { createHttpLink } from "apollo-link-http";
import { setContext } from "apollo-link-context";
import { InMemoryCache } from "apollo-cache-inmemory";

const httpLink = createHttpLink({
  uri: "/graphql"
});

const authLink = setContext((_, { headers }) => {
  // get the authentication token from local storage if it exists
  // const token = localStorage.getItem('token');
  // TODO: currently just hacking along with the xCsrfToken
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers
    }
  };
});

// uri: 'http://localhost:3000/graphql',
const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache()
});

export default client;
