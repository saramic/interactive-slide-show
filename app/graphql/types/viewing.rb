module Types
  class Viewing < Types::BaseObject
    field :id, ID, null: false
    field :users, [Types::Viewer], null: true
  end
end
