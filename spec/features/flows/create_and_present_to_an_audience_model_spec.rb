require "rails_helper"

describe "Create and present to an audience", type: :model do
  scenario "Create and present to an audience" do
    Given "A creator creates a number of slideshows" do
      @creator = create :user
      @slideshow_intro = create :slideshow, user: @creator, title: "Intro Slideshow"
      # if created as part of slideshow
      #   slides: [build(:slide), build(:slide)]
      # seem to have issue with sequential oridinals and cannot
      # ovewrite them
      @slideshow_intro.slides << build(:slide, title: "Intro")
      @intro_slide = @slideshow_intro.slides.first
      @intro_slide.quizzes << Quiz.new(title: "Test Quiz",
                                       quiz_type: :poll,
                                       quiz_options: [
                                         QuizOption.new(text: "A"),
                                         QuizOption.new(text: "B"),
                                       ])
      @intro_quiz = @intro_slide.quizzes.first

      @slideshow_worm = create :slideshow, user: @creator, title: "Worm Slideshow"
      @slideshow_worm.quizzes << Quiz.new(title: "test worm",
                                          quiz_type: :worm,
                                          quiz_options: [
                                            QuizOption.new(text: "presenter A"),
                                            QuizOption.new(text: "presenter B"),
                                          ])
      @worm_quiz = @slideshow_worm.quizzes.first

      @slideshow_worm.slides << build(:slide)
      @slideshow_worm.slides << build(:slide)
      @slideshow_worm.slides << build(:slide)
      @slideshow_worm.slides << build(:slide)

      @slideshow_intermission = create :slideshow, user: @creator, title: "Intermission Slideshow"
      @slideshow_intermission.slides << build(:slide,
                                              title: "Intermission")

      @slideshow_choice = create :slideshow, user: @creator, title: "Choice Slideshow"
      @slideshow_choice.quizzes << Quiz.new(title: "test choice",
                                            quiz_type: :choice)
      @choice_quiz = @slideshow_choice.quizzes.first

      @slideshow_choice.slides << build(:slide)
      @slideshow_choice.slides << build(:slide)
      @slideshow_choice.slides << build(:slide)
      @slideshow_choice.slides << build(:slide)

      @slideshow_finale = create :slideshow, user: @creator, title: "Finale Slideshow"
      @slideshow_finale.slides << build(:slide, title: "Finale")
    end

    And "Creates a viewing for an audience with the slideshow presentations" do
      @viewing = create :viewing,
                        presenter: @creator,
                        presentations: [
                          build(:presentation, slideshow: @slideshow_intro),
                          build(:presentation, slideshow: @slideshow_worm),
                          build(:presentation, slideshow: @slideshow_intermission),
                          build(:presentation, slideshow: @slideshow_choice),
                          build(:presentation, slideshow: @slideshow_finale),
                        ]
      @presentation_1 = @viewing.presentations.first
      @presentation_worm = @viewing.presentations.second
      @presentation_3 = @viewing.presentations.third
      @presentation_choice = @viewing.presentations.first(4).last
    end

    When "3 viewers join the viewing" do
      @viewer_1 = build(:viewer, viewer: create(:user))
      @viewer_2 = build(:viewer, viewer: create(:user))
      @viewer_3 = build(:viewer, viewer: create(:user))
      # other viewer
      @viewer_4 = build(:viewer, viewer: create(:user))
      @viewing.viewers << @viewer_1 << @viewer_2 << @viewer_3
    end

    Then "the joined viewers are listed as the viewers for the viewing" do
      expect(@viewing.viewers.map(&:id)).to eq([
        @viewer_1.id, @viewer_2.id, @viewer_3.id,
      ])
    end

    And "the viewing presentation is not set" do
      expect(@viewing.presentation).to be_nil
    end

    When "the creator starts a presentation" do
      @slides = []
      @viewing.next!
      @slides << @viewing.presentation.slide
    end

    Then "the viewing presentation is the first presentation" do
      expect(@viewing.presentation).to eq(@presentation_1)
    end

    And "the viewing presentation display is the first slide" do
      expect(
        @viewing.presentation.slide
      ).to eq(@presentation_1.slideshow.slides.first)
    end

    And "the associated quizzes are shown for the slide" do
      expect(
        @viewing.presentation.quizzes.map(&:quiz)
      ).to eq([@intro_quiz])
      @intro_presented_quiz = @viewing.presentation.quizzes.first
    end

    When "the audience votes on the intro quiz" do
      options = @intro_presented_quiz.presented_quiz_options
      @presented_quiz_option_a = options.first
      @presented_quiz_option_b = options.last
      @intro_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: options.first)
      @intro_presented_quiz.votes << Vote.new(viewer: @viewer_2, presented_quiz_option: options.first)
      @intro_presented_quiz.votes << Vote.new(viewer: @viewer_3, presented_quiz_option: options.last)
    end

    Then "the results are available for the quiz" do
      expect(@intro_presented_quiz.result).to eq(
        @presented_quiz_option_a => 2,
        @presented_quiz_option_b => 1,
      )
    end

    When "the creator executes next on the viewing" do
      @viewing.next!
      @slides << @viewing.presentation.slide
    end

    Then "the first presentation is complete so the second presentation is active" do
      expect(@viewing.presentation.slideshow.title).to eq(@presentation_worm.slideshow.title)
    end

    When "the second presentation is cycled through and viewers vote on the worm" do
      minute = 0
      while (@viewing.presentation == @presentation_worm &&
             @viewing.presentation.has_more_slides?)
        @viewing.next!
        @slides << @viewing.presentation.slide

        current_slide = @viewing.presentation.presented_slides.last
        current_presented_quiz = @viewing.presentation.presented_quizzes.last
        # have problems finding the slideshow quiz on each presented slide?
        # @worm_quiz is reset to a Slide from a Slideshow
        options = current_presented_quiz.presented_quiz_options
        @worm_option_1 = options.first
        @worm_option_2 = options.last
        Timecop.freeze(Time.parse(sprintf("2019-10-30 08:%02d:00", minute))) do
          current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @worm_option_1)
          current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @worm_option_2)
          current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @worm_option_1)
        end
        minute += 1
      end
    end

    Then "each slide is played in order" do
      expect(@slides).to eq([
        @slideshow_intro.slides.first,
        @slideshow_worm.slides.first,
        @slideshow_worm.slides[1],
        @slideshow_worm.slides[2],
        @slideshow_worm.slides.last,
      ])
      expect(
        @viewing.presentation.presented_slides.map(&:slide)
      ).to eq([
        @slideshow_worm.slides.first,
        @slideshow_worm.slides[1],
        @slideshow_worm.slides[2],
        @slideshow_worm.slides.last,
      ])
    end

    And "a worm result is visible" do
      @worm_presented_quiz = @worm_quiz.presented_quizzes.first
      expect(@worm_presented_quiz.result).to eq(
        Time.parse("2019-10-30 08:00:00") => {
          @worm_option_1 => 2,
          @worm_option_2 => 1,
        },
        Time.parse("2019-10-30 08:01:00") => {
          @worm_option_1 => 2,
          @worm_option_2 => 1,
        },
        Time.parse("2019-10-30 08:02:00") => {
          @worm_option_1 => 2,
          @worm_option_2 => 1,
        },
      )
    end

    When "the intermission is played" do
      @viewing.next!
      @slides << @viewing.presentation.slide
      while (@viewing.presentation == @presentation_3 &&
             @viewing.presentation.has_more_slides?)
        @viewing.next!
        @slides << @viewing.presentation.slide
      end
    end

    Then "then the intermission is shown" do
      expect(
        @slides.last
      ).to eq(@slideshow_intermission.slides.first)
    end

    When "the choice presentation is played" do
      @viewing.next!
      @slides << @viewing.presentation.slide
      while (@viewing.presentation == @presentation_choice &&
             @viewing.presentation.has_more_slides?)
        @viewing.next!
        @slides << @viewing.presentation.slide

        current_presented_quiz = @viewing.presentation.presented_slides.last.presented_quizzes.first
        options = current_presented_quiz.presented_quiz_options
        @choice_option_1 = options.first
        @choice_option_2 = options.last
        # TODO do something clever with the votes
        current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @choice_option_1)
        current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @choice_option_1)
        current_presented_quiz.votes << Vote.new(viewer: @viewer_1, presented_quiz_option: @choice_option_1)
      end
    end

    When "the remaining presentations are cycled through" do
      while (@viewing.has_more_presentations?)
        @viewing.next!
        @slides << @viewing.presentation.slide
      end
    end

    Then "each slide is played in order" do
      expect(@slides).to eq([
        @slideshow_intro.slides.first,
        @slideshow_worm.slides.first,
        @slideshow_worm.slides[1],
        @slideshow_worm.slides[2],
        @slideshow_worm.slides.last,
        @slideshow_intermission.slides.first,
        @slideshow_choice.slides.first,
        @slideshow_choice.slides[1],
        @slideshow_choice.slides[2],
        @slideshow_choice.slides.last,
        @slideshow_finale.slides.first,
      ])
    end
  end
end
