const { paginateResults } = require("./utils");

module.exports = {
  Query: {
    me: async (_, __, { dataSources }) =>
      dataSources.votingAPI.findOrCreateUser()
  },
  Mutation: {
    login: async (_, { email }, { dataSources }) => {
      const user = await dataSources.votingAPI.findOrCreateUser({ email });
      if (user) return Buffer.from(email).toString("base64");
    }
  }
};
