import React from "react";
import { Mutation, useQuery } from "react-apollo";
import { gql } from "apollo-boost";
import { string } from "prop-types";
import { Col, Row } from "reactstrap";

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
          result {
            count
            presentedQuizOption {
              id
              text
            }
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
          <Row>
            <Col>
              {quiz.title}
              {quiz.presentedQuizOptions.map(presentedQuizOption => (
                <button
                  type="button"
                  className="btn btn-primary btn-lg btn-block"
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
            </Col>
          </Row>
          <hr />
          <Row>
            {quiz.result.map(resultValue => (
              <Col key={resultValue.id}>
                <p className="h3">{resultValue.count}</p>
                <p className="h3">{resultValue.presentedQuizOption.text}</p>
              </Col>
            ))}
            {loading && <p>Loading...</p>}
            {error && <p>Error :( Please try again</p>}
          </Row>
        </>
      )}
    </Mutation>
  );
};

export default function Viewing({ viewingId }) {
  const { data, loading, error } = useQuery(GET_VIEWING, {
    variables: { id: viewingId },
    pollInterval: 1000
  });

  if (loading) return "loading...";
  if (error) return "error...";

  return (
    <div className="container container-fluid">
      <Row>
        <Col>
          <h3>{data.viewing.presentation.slide.title}</h3>
          <p>{data.viewing.presentation.slide.content}</p>
          {data.viewing.presentation.presentedQuizzes.map(presentedQuiz => (
            <Quiz key={presentedQuiz.id} quiz={presentedQuiz} />
          ))}
        </Col>
        <Col className="d-sm-none d-md-none d-md-block">
          <dl>
            <dt>viewers:</dt>
            <dd>{data.viewing.users.length}</dd>
          </dl>
          {data.viewing.users.map(viewer => (
            <div key={viewer.id}>{viewer.email}</div>
          ))}
        </Col>
      </Row>
    </div>
  );
}

Viewing.propTypes = {
  viewingId: string
};

Viewing.defaultProps = {
  viewingId: undefined
};
