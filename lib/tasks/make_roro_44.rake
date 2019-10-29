desc "all the things for roro"
namespace :roro do
  task :all_the_things => :environment do
    michael = User.find_by(email: "saramic@gmail.com")
    slideshow = Slideshow.create!(user: michael, title: "RORO 44")
    slideshow.slides << Slide.create(title: "Who takes the tickets?")
    slideshow.slides.first.quizzes << Quiz.create(title: "Quiz")

    viewing = Viewing.create!(presenter: michael)

    presentation = Presentation.create!(viewing: viewing, slideshow: slideshow)
    presentation.next!
    presentation.presented_quizzes << PresentedQuiz.create(quiz: presentation.slide.quizzes.first)
    %w(Matilda Felix Michael).each do |name|
      presentation
        .presented_quizzes
        .first
        .presented_quiz_options << PresentedQuizOption.create(text: name)
    end

    viewing.presentation = presentation
    viewing.save!
    puts viewing.id
  end
end
