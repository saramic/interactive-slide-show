module Types
  class Slideshow < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :slides, [Types::Slide], null: true
  end
end
