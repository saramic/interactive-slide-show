const { paginateResults } = require("./utils");

module.exports = {
  Query: {
    me: async (_, __, { dataSources }) =>
      dataSources.votingAPI.findOrCreateUser(),
    getVotes: async (_, __, { dataSources }) =>
      dataSources.votingAPI.getVotes()
  },
  Mutation: {
    login: async (_, { email }, { dataSources }) => {
      const user = await dataSources.votingAPI.findOrCreateUser({ email });
      if (user) return Buffer.from(email).toString("base64");
    },
    castVote: async (_, { option }, { dataSources }) => {
      const results = await dataSources.votingAPI.castVote({ option });
      return "vote placed successfully";
    }
  }
};
