module Types
  class Viewing < Types::BaseObject
    field :id, ID, null: false
    field :users, [Types::Viewer], null: true
    field :presentation, Types::Presentation, null: true
  end
end
