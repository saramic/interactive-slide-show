FactoryBot.define do
  factory :slideshow do
    sequence(:title) { |n| "Slideshow #{n}" }
  end
end
