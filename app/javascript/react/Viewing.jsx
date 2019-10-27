import React from "react";
import { useQuery } from "react-apollo";
import { gql } from "apollo-boost";
import { string } from "prop-types";

const GET_VIEWING = gql`
  query viewing($id: ID!) {
    viewing(id: $id) {
      id
      users {
        id
        email
      }
    }
  }
`;

export default function Viewing({ viewingId }) {
  const { data, loading, error } = useQuery(GET_VIEWING, {
    variables: { id: viewingId },
    pollInterval: 1000
  });
  if (loading) return "loading...";
  if (error) return "error...";

  return (
    <>
      {data.viewing.users.map(viewer => (
        <div>{viewer.email}</div>
      ))}
    </>
  );
}

Viewing.propTypes = {
  viewingId: string
};

Viewing.defaultProps = {
  viewingId: undefined
};
