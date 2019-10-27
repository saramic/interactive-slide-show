module Types
  class PresentedQuizOption < Types::BaseObject
    field :id, ID, null: false
    field :text, String, null: true
  end
end
