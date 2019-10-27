module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :slideshow, resolver: Resolvers::Slideshow
    field :viewing, resolver: Resolvers::Viewing
  end
end
