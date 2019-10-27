module Resolvers
  class Viewing < Resolvers::BaseResolver
    description "Find viweing"

    argument :id, ID, required: true

    type Types::Viewing, null: false

    def resolve(id:)
      ::Viewing
        .includes(:users)
        .find(id)
    end
  end
end
