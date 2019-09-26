module Types
  class Slide < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :content, String, null: true
  end
end
