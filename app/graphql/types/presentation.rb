module Types
  class Presentation < Types::BaseObject
    field :id, ID, null: false
    field :slide, Types::Slide, null: false
    field :presented_quizzes, [Types::PresentedQuiz], null: true
  end
end
