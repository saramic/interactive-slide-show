module Mutations
  class VoteOnQuiz < Mutations::BaseMutation
    argument :presentedQuizId, ID, required: true
    argument :presentedQuizOptionId, ID, required: true

    field :vote, Types::Vote, null: true

    def resolve(presented_quiz_id:, presented_quiz_option_id:)
      vote = ::Vote.create!(
        viewer_id: Viewer.where(user_id: context[:current_user].id).first.id,
        presented_quiz_id: presented_quiz_id,
        presented_quiz_option_id: presented_quiz_option_id,
      )
      {
        vote: vote,
      }
    end
  end
end
