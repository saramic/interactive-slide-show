module Types
  class PresentedQuiz < Types::BaseObject
    field :id, ID, null: false
    field :quiz, Types::Quiz, null: false
    field :presented_quiz_options, [Types::PresentedQuizOption], null: true
  end
end
