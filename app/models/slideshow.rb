class Slideshow < ApplicationRecord
  belongs_to :user
  has_many :slides, -> { order(:ordinal) }
  has_many :quizzes, as: :quizzable
end
