require "rails_helper"

feature "RORO presentation Wed 30th October", js: true do
  context "Michael has an account setup" do
    before do
      @michael = create :user, email: "saramic@gmail.com", password: "1password"
    end

    scenario "Michael with collaboration with Tilda and Felix create a couple of slideshows and run an audience through the presentations" do
      When "Michael signs in" do
        visit root_path
        focus_on(:landing).form_action("create")
        focus_on(:landing).form_action(
          "Sign in",
          Email: "saramic@gmail.com",
          Password: "1password",
        )
      end

      When "he creates an intro slideshow" do
        sleep(1) # TODO: is something loading and the form field cannot be filled in?
        focus_on(:dashboard).form_action(
          "Create Slideshow",
          Title: "Intro Slideshow",
        )
      end

      Then "the slideshow is created" do
        wait_for do
          focus_on(:dashboard).messages
        end.to eq "Slideshow was successfully created."
      end

      When "he adds slides" do
        focus_on(:dashboard).add_slide(
          Slideshow: "Intro Slideshow",
          Title: "Intro",
          Content: "http://bit.ly/roro-44",
        )
      end

      # TODO: maybe do this in a before block
      And "he creates the kids slideshow" do
        focus_on(:dashboard).form_action("Slideshows")
        focus_on(:dashboard).form_action("New slideshow")
        focus_on(:dashboard).form_action(
          "Create Slideshow",
          Title: "Code for RailsCamp",
        )
        focus_on(:dashboard).add_slide(
          Slideshow: "Code for RailsCamp",
          Title: "All the slides",
          Content: "TODO...",
        )
      end

      And "he creates an intermission slideshow" do
        focus_on(:dashboard).form_action("Slideshows")
        focus_on(:dashboard).form_action("New slideshow")
        focus_on(:dashboard).form_action(
          "Create Slideshow",
          Title: "Intermission",
        )
        focus_on(:dashboard).add_slide(
          Slideshow: "Intermission",
          Title: "Itermission",
          Content: "... now for dad",
        )
      end

      # TODO: maybe do this in a before block
      And "he creates the how slideshow works slideshow" do
        focus_on(:dashboard).form_action("Slideshows")
        focus_on(:dashboard).form_action("New slideshow")
        focus_on(:dashboard).form_action(
          "Create Slideshow",
          Title: "How slideshow",
        )
        focus_on(:dashboard).add_slide(
          Slideshow: "How slideshow",
          Title: "All gthe slides",
          Content: "TODO...",
        )
      end

      And "he creates a finale slideshow" do
        focus_on(:dashboard).form_action("Slideshows")
        focus_on(:dashboard).form_action("New slideshow")
        focus_on(:dashboard).form_action(
          "Create Slideshow",
          Title: "Finale",
        )
        focus_on(:dashboard).add_slide(
          Slideshow: "Finale",
          Title: "Finale",
          Content: "one more thing...",
        )
      end

      Then "there are 5 slideshows" do
        focus_on(:dashboard).form_action("Slideshows")
        wait_for do
          focus_on(:dashboard).table_rows.map { |row| row.slice(:Title) }
        end.to eq([
                    { "Title" => "Intro Slideshow" },
                    { "Title" => "Code for RailsCamp" },
                    { "Title" => "Intermission" },
                    { "Title" => "How slideshow" },
                    { "Title" => "Finale" },
                  ])
      end

      When "he creates a viewing and adds the slideshows"

      Then "he has a viewing"

      When "he starts a viewing"

      And "users register for it"

      Then "he sees registered users"

      # Then "he is informed he needs to sign in or sign up" do
      #   wait_for do
      #     focus_on(:landing).messages
      #   end.to eq "Please sign in to continue."
      # end

      # When "he goes to sign up" do
      #   focus_on(:landing).form_action("Sign up")
      # end

      # And "signs up with his email and a password" do
      #   focus_on(:landing).form_action(
      #     "Sign in",
      #     Email: "saramic@gmail.com",
      #     Password: "1password",
      #   )
      # end

      # Then "he is signed in and can create a slideshow" do
      #   wait_for do
      #     focus_on(:dashboard).navigation.account
      #   end.to eq "Signed in as: saramic@gmail.com"
      #   wait_for { focus_on(:dashboard).title }.to eq "New Slideshows"
      #   # TODO: auto associate slideshow with user who is signed in
      # end

      # When 'he creates a slideshow "My slideshow software"' do
      #   focus_on(:dashboard).form_action(
      #     "Create Slideshow",
      #     Title: "My slideshow software",
      #   )
      # end

      # Then "the slideshow is successfully created" do
      #   dashboard = focus_on(:dashboard)
      #   wait_for do
      #     dashboard.messages
      #   end.to eq "Slideshow was successfully created."
      #   wait_for do
      #     dashboard.details
      #   end.to match(hash_including(
      #     TITLE: "My slideshow software",
      #   ))
      # end

      # When "he adds some slides" do
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "Intro",
      #     Content: "My slideshow software",
      #   )
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "Inspiration",
      #     Content: "Inspiration - kahoots and multi person cart",
      #   )
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "Architecture",
      #     Content: "Rails React GraphQL and Apollo",
      #   )
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "Next steps",
      #     Content: "service on line and plugin to work",
      #   )
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "Testing approach",
      #     Content: "light sprinkle of high level BDD",
      #   )
      #   focus_on(:dashboard).add_slide(
      #     Slideshow: "My slideshow software",
      #     Title: "The End",
      #     Content: "Thankyou",
      #   )
      # end

      # And "he goes to the slides show and gets the start slideshow link" do
      #   focus_on(:dashboard).go_to_slideshow("My slideshow software")
      #   @start_link = focus_on(:dashboard).start_slideshow_link
      # end

      # And "he logs out" do
      #   focus_on(:dashboard).form_action("Sign out")
      # end

      # Then "he is on the landing page"

      # When "his friend Ambrose follows his slide show start link" do
      #   visit @start_link
      # end

      # Then "he is asked to sign in or sign up" do
      #   wait_for do
      #     focus_on(:landing).messages
      #   end.to eq "Please sign in to continue."
      # end

      # When "Ambrose signs up" do
      #   focus_on(:landing).form_action("Sign up")
      #   focus_on(:landing).form_action(
      #     "Sign up",
      #     Email: "ambrose@gmail.com",
      #     Password: "1password",
      #   )
      # end

      # Then "he sees the first slide of the slide show" do
      #   wait_for do
      #     focus_on(:slideshow).content
      #   end.to eq "My slideshow software"
      # end

      # When "he goes through all the slides" do
      #   [
      #     "Inspiration",
      #     "Architecture",
      #     "Next steps",
      #     "Testing approach",
      #     "The End",
      #   ].each do |next_slide_link_text|
      #     focus_on(:slideshow).choose(next_slide_link_text)
      #   end
      # end

      # Then "he is on the last slide" do
      #   wait_for { focus_on(:slideshow).content }.to eq "Thankyou"
      # end

      # When "he clicks on start" do
      #   focus_on(:slideshow).form_action("start")
      # end

      # Then "he sees the first slide again" do
      #   wait_for do
      #     focus_on(:slideshow).content
      #   end.to eq "My slideshow software"
      # end

      # When "he clicks on home" do
      #   focus_on(:slideshow).form_action("home")
      # end

      # Then "he sees the landing page" do
      #   wait_for { focus_on(:landing).title }.to eq "Interactive Slide Show"
      # end

      # And "Connectivity statistics"
      # # TODO: how to test with multiple users logged in?
    end

    context "everything is hacked in to run an audience through presentations" do
      before do
        @viewing = Viewing.create(presenter: @michael)
        @slideshow_intro = create(
          :slideshow, user: @michael, title: "Intro Slideshow",
        )
        @slideshow_intro.slides << build(:slide, title: "Intro")
        @intro_slide = @slideshow_intro.slides.first
        @intro_slide.quizzes << Quiz.new(title: "Test Quiz",
                                         quiz_type: :poll,
                                         quiz_options: [
                                           QuizOption.new(text: "A"),
                                           QuizOption.new(text: "B"),
                                         ])
        @intro_quiz = @intro_slide.quizzes.first
        @slideshow_intro.slides << build(:slide, title: "Intro")
        @intro_slide = @slideshow_intro.slides.first
        @intro_slide.quizzes << Quiz.new(title: "Test Quiz",
                                         quiz_type: :poll,
                                         quiz_options: [
                                           QuizOption.new(text: "A"),
                                           QuizOption.new(text: "B"),
                                         ])
        @intro_quiz = @intro_slide.quizzes.first
      end

      scenario "Michael shares the link and runs the presentation" do
        When "the link http://bit-ly/roro-44 is shared" do
          visit viewing_path(id: @viewing.id)
        end

        And "Ambrose, Gracie and Sarah join in" do
        end

        Then "there are 3 registered viewers on the presentation" do
        end
      end
    end
  end
end
