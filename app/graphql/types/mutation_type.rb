module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    # rubocop:disable Layout/AlignHash
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
    # rubocop:enable Layout/AlignHash
  end
end
