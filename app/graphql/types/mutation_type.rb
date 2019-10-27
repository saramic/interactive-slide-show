module Types
  class MutationType < Types::BaseObject
    field :vote_on_quiz, mutation: Mutations::VoteOnQuiz
  end
end
