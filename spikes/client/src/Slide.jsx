import React, { useState } from "react";
import { ApolloClient } from "apollo-client";
import {
  ApolloProvider,
  useQuery,
  useMutation
} from "@apollo/react-hooks";
import { InMemoryCache } from "apollo-cache-inmemory";
import { HttpLink } from "apollo-link-http";
import gql from "graphql-tag";

const cache = new InMemoryCache();
const link = new HttpLink({
  uri: "http://localhost:4000/graphql"
});

const client = new ApolloClient({
  cache,
  link
});

const GET_VOTES = gql`
  query getVotes {
    getVotes {
      id
      option
    }
  }
`;

const VOTE = gql`
  mutation castVote($option: String!) {
    castVote(option: $option)
  }
`;

client
  .query({
    query: GET_VOTES
  })
  .then(result => console.log(result));

const Display = ({ counts }) => {
  const { data, loading, error, fetchMore } = useQuery(GET_VOTES, {
    pollInterval: 1000
  });
  if (loading) return "loading...";
  if (error) return "error...";

  return (
    <div className='flex items-stretch-'>
      {JSON.stringify(data)}
      {JSON.stringify(data.getVotes.length)}
      <div
        className={`flex-1 ${counts[0] < counts[1] &&
          "text-gray-500"} text-center px-4 py-2 m-2`}
      >
        {counts[0]}
      </div>
      <div
        className={`flex-1 ${counts[0] > counts[1] &&
          "text-gray-500"} text-center px-4 py-2 m-2`}
      >
        {counts[1]}
      </div>
    </div>
  );
};

const Progress = ({ timeLeft }) => (
  <div className='flex items-stretch'>
    <div className='flex-1 bg-gray-300'>
      <div
        className='bg-gray-700'
        style={{ width: `${100 - timeLeft}%`, height: "3px" }}
      />
    </div>
    <div className='flex-1 bg-gray-700'>
      <div
        className='bg-gray-300'
        style={{ width: `${timeLeft}%`, height: "3px" }}
      />
    </div>
  </div>
);

const Choice = ({ index }) => {
  const [response, { data }] = useMutation(VOTE);

  return (
    <div
      className='flex-1 text-center px-4 py-2 m-2'
      onClick={() =>
        console.log(response({ variables: { option: `choice ${index}` } }))
      }
    >
      choice {index}
    </div>
  );
};

const Choices = props => (
  <div className='flex items-stretch h-16'>
    {[0, 1].map(index => (
      <Choice key={index} index={index} />
    ))}
  </div>
);

const Slide = () => {
  const [counts, setCounts] = useState([0, 0]);
  const [timeLeft, setTimeLeft] = useState(100);

  return (
    <ApolloProvider client={client}>
      <div className='text-gray-100'>
        <Display counts={counts} />
        <div className='w-full pin-b absolute bottom-0 left-0'>
          <Progress timeLeft={timeLeft} />
          <Choices />
        </div>
      </div>
    </ApolloProvider>
  );
};

export default Slide;
