const { gql } = require("apollo-server");
const typeDefs = gql`
  type Query {
    me: User
  }

  type User {
    id: ID!
    email: String!
  }

  type Mutation {
    login(email: String): String # login token
  }
`;

module.exports = typeDefs;
