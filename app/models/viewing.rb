class Viewing < ApplicationRecord
  belongs_to :presenter, class_name: :User, foreign_key: "user_id"
  has_many :presentations
  has_many :viewers
  has_many :users, through: :viewers, source: :viewer
  belongs_to :presentation, optional: true

  def next!
    index = 0
    if presentation
      if presentation.has_more_slides?
        presentation.next!
        return
      else
        index = presentations.find_index(presentation) + 1
      end
    end
    self.presentation = presentations[index]
    presentation.presented_quizzes << presentation.slideshow.quizzes.map do |quiz|
      PresentedQuiz.new(
        quiz: quiz,
        presented_quiz_options: quiz.quiz_options.map do |quiz_option|
          PresentedQuizOption.new(text: quiz_option.text)
        end
      )
    end
    presentation.next!
  end

  def has_more_presentations?
    presentations.length > presentations.find_index(presentation) + 1
  end
end
