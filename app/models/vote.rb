class Vote < ApplicationRecord
  belongs_to :viewer
  belongs_to :presented_quiz
  belongs_to :presented_quiz_option
end
