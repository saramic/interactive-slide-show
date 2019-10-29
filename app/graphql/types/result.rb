module Types
  class Result < Types::BaseObject
    field :id, ID, null: false
    field :count, Integer, null: true
    field :presented_quiz_option, Types::PresentedQuizOption, null: true
  end
end
