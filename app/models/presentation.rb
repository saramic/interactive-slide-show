class Presentation < ApplicationRecord
  belongs_to :viewing
  belongs_to :slideshow
  belongs_to :slide, optional: true
  has_many :presented_slides
  has_many :presented_quizzes, as: :quizzable

  def next!
    index = 0
    index = slideshow.slides.find_index(slide) + 1 if slide
    self.slide = slideshow.slides[index]
    presented_slides << PresentedSlide
      .new(slide: slide,
           presented_quizzes: slide.quizzes.map do |quiz|
             quiz.presented_quizzes.first || PresentedQuiz.new(
               quiz: quiz,
               presented_quiz_options: quiz.quiz_options.map do |quiz_option|
                 PresentedQuizOption.new(text: quiz_option.text)
               end,
             )
           end.concat(
             slideshow.quizzes.select { |quiz| quiz.quiz_type == "choice" }.map do |quiz|
               #  quiz.presented_quizzes.first ||
               PresentedQuiz.new(
                 quiz: quiz,
                 presented_quiz_options: quiz.quiz_options.map do |quiz_option|
                   PresentedQuizOption.new(text: quiz_option.text)
                 end,
               )
             end
           ))
    save!
    presented_slides.last
  end

  def quizzes
    presented_slides.last.presented_quizzes
  end

  def has_more_slides?
    slideshow.slides.length > slideshow.slides.find_index(slide) + 1
  end
end
