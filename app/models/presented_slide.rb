class PresentedSlide < ApplicationRecord
  belongs_to :presentation
  belongs_to :slide
  has_many :presented_quizzes, as: :quizzable
end
