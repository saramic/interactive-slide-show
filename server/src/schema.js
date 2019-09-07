const { gql } = require("apollo-server");
const typeDefs = gql`
  type Query {
    me: User
    getVotes: [Vote]!
  }

  type User {
    id: ID!
    email: String!
  }

  type Vote {
    id: ID!
    option: String!
  }

  type Mutation {
    login(email: String): String # login token
    castVote(option: String): String # success message
  }
`;

module.exports = typeDefs;
