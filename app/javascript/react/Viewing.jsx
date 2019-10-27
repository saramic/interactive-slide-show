import React from "react";
import { Mutation, useQuery } from "react-apollo";
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
      presentation {
        id
        slide {
          id
          title
          content
          quizzes {
            id
            title
            quizOptions {
              id
              text
            }
          }
        }
        presentedQuizzes {
          id
          quiz {
            id
            title
          }
          presentedQuizOptions {
            id
            text
          }
        }
      }
    }
  }
`;

const VOTE_ON_QUIZ = gql`
  mutation VoteOnQuiz($presentedQuizId: ID!, $presentedQuizOptionId: ID!) {
    voteOnQuiz(
      presentedQuizId: $presentedQuizId
      presentedQuizOptionId: $presentedQuizOptionId
    ) {
      vote {
        id
      }
    }
  }
`;

const Quiz = ({ quiz }) => {
  const onVoteClick = ({
    voteOnQuiz,
    presentedQuizId,
    presentedQuizOptionId
  }) => {
    voteOnQuiz({ variables: { presentedQuizId, presentedQuizOptionId } });
  };

  return (
    <Mutation mutation={VOTE_ON_QUIZ}>
      {(voteOnQuiz, { loading, error }) => (
        <>
          {quiz.title}
          {quiz.presentedQuizOptions.map(presentedQuizOption => (
            <button
              type="button"
              key={presentedQuizOption.id}
              onClick={event =>
                onVoteClick({
                  voteOnQuiz,
                  presentedQuizId: quiz.id,
                  presentedQuizOptionId: presentedQuizOption.id,
                  event
                })}
            >
              {presentedQuizOption.text}
            </button>
          ))}
          {loading && <p>Loading...</p>}
          {error && <p>Error :( Please try again</p>}
        </>
      )}
    </Mutation>
  );
};

export default function Viewing({ viewingId }) {
  const { data, loading, error } = useQuery(GET_VIEWING, {
    variables: { id: viewingId },
    pollInterval: 10000
  });

  if (loading) return "loading...";
  if (error) return "error...";

  return (
    <>
      <dl>
        <dt>viewers:</dt>
        <dd>{data.viewing.users.length}</dd>
      </dl>
      {data.viewing.users.map(viewer => (
        <div key={viewer.id}>{viewer.email}</div>
      ))}
      {data.viewing.presentation.slide.title}
      {data.viewing.presentation.slide.content}
      {data.viewing.presentation.presentedQuizzes.map(presentedQuiz => (
        <Quiz key={presentedQuiz.id} quiz={presentedQuiz} />
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
