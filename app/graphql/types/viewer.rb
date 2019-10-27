module Types
  class Viewer < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
  end
end
