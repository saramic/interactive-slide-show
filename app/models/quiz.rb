class Quiz < ApplicationRecord
  belongs_to :quizzable, polymorphic: true
  has_many :quiz_options
  has_many :presented_quizzes

  enum quiz_type: {
         poll: 0,
         choice: 1,
         worm: 2,
       }
end
