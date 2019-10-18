FactoryBot.define do
  factory :slide do
    sequence(:title) { |n| "Slide #{n}" }
    sequence(:ordinal, &:to_s)
  end
end
