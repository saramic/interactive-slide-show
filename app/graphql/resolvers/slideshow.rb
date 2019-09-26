module Resolvers
  class Slideshow < Resolvers::BaseResolver
    description "Find slideshow"

    argument :id, ID, required: true

    type Types::Slideshow, null: false

    def resolve(id:)
      ::Slideshow
        .includes(:slides)
        .find(id)
    end
  end
end
