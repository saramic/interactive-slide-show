module Types
  class Quiz < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :quiz_options, [Types::QuizOption], null: true
  end
end
