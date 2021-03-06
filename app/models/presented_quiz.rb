class PresentedQuiz < ApplicationRecord
  belongs_to :quiz
  belongs_to :quizzable, polymorphic: true
  has_many :presented_quiz_options
  has_many :votes

  def result
    return result_cumulative if quiz.quiz_type == "poll"
    return result_over_time if quiz.quiz_type == "worm"
  end

  alias original_presented_quiz_options presented_quiz_options

  def presented_quiz_options
    if quiz.quiz_type == "choice" && original_presented_quiz_options.empty?
      (quiz.quizzable.reload.slides -
       quizzable.presentation.presented_slides.map(&:slide))
        .sample(2)
        .each do |slide|
        original_presented_quiz_options << PresentedQuizOption.new(text: slide.title)
      end
    end
    original_presented_quiz_options
  end

  private

  def result_cumulative
    # TODO: why does a join group sum not work?
    # votes.joins(:quiz_option).group(quiz_option: :text).sum
    results = votes
      .each_with_object({}) do |vote, acc|
      acc[vote.presented_quiz_option.id] ||= {
        id: vote.presented_quiz_option.id,
        count: 0,
        presented_quiz_option: vote.presented_quiz_option,
      }
      acc[vote.presented_quiz_option.id][:count] += 1
    end
    results.values
  end

  def result_over_time
    votes
      .each_with_object({}) do |vote, acc|
      acc[vote.updated_at] ||= {}
      acc[vote.updated_at][vote.presented_quiz_option] ||= 0
      acc[vote.updated_at][vote.presented_quiz_option] += 1
    end
  end
end
