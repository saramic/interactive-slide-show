require "rails_helper"

feature "User creates a slideshow and another user views it", js: true do
  scenario "Michael creates a slideshow about his slideshow software" do
    When "Michael creates a slideshow" do
      # TODO: styling
      visit root_path
      focus_on(:landing).form_action("create")
    end

    Then "he is informed he needs to sign in or sign up" do
      wait_for do
        focus_on(:landing).messages
      end.to eq "Please sign in to continue."
    end

    When "he goes to sign up" do
      focus_on(:landing).form_action("Sign up")
    end

    And "signs up with his email and a password" do
      focus_on(:landing).form_action(
        "Sign up",
        Email: "saramic@gmail.com",
        Password: "1password"
      )
    end

    Then "he is signed in and can create a slideshow" do
      wait_for do
        focus_on(:dashboard).navigation.account
      end.to eq "Signed in as: saramic@gmail.com"
      wait_for { focus_on(:dashboard).title }.to eq "New Slideshows"
      # TODO: auto associate slideshow with user who is signed in
    end

    When 'he creates a slideshow "My slideshow software"' do
      focus_on(:dashboard).form_action(
        "Create Slideshow",
        Title: "My slideshow software"
      )
    end

    Then "the slideshow is successfully created" do
      dashboard = focus_on(:dashboard)
      wait_for do
        dashboard.messages
      end.to eq "Slideshow was successfully created."
      wait_for do
        dashboard.details
      end.to match(hash_including(
                     TITLE: "My slideshow software"
                   ))
    end

    When "he adds some slides" do
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Intro",
        Content: "My slideshow software"
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Inspiration",
        Content: "Inspiration - kahoots and multi person cart"
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Architecture",
        Content: "Rails React GraphQL and Apollo"
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Next steps",
        Content: "service on line and plugin to work"
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Testing approach",
        Content: "light sprinkle of high level BDD"
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "The End",
        Content: "Thankyou"
      )
    end

    And "he goes to the slides show and gets the start slideshow link" do
      focus_on(:dashboard).go_to_slideshow("My slideshow software")
      @start_link = focus_on(:dashboard).start_slideshow_link
    end

    And "he logs out" do
      focus_on(:dashboard).form_action("Sign out")
    end

    Then "he is on the landing page"

    When "his friend Ambrose follows his slide show start link" do
      visit @start_link
    end

    Then "he is asked to sign in or sign up" do
      wait_for do
        focus_on(:landing).messages
      end.to eq "Please sign in to continue."
    end

    When "Ambrose signs up" do
      focus_on(:landing).form_action("Sign up")
      focus_on(:landing).form_action(
        "Sign up",
        Email: "ambrose@gmail.com",
        Password: "1password"
      )
    end

    Then "he sees the first slide of the slide show" do
      wait_for do
        focus_on(:slideshow).content
      end.to eq "My slideshow software"
    end

    When "he goes through all the slides" do
      [
        "Inspiration",
        "Architecture",
        "Next steps",
        "Testing approach",
        "The End"
      ].each do |next_slide_link_text|
        focus_on(:slideshow).choose(next_slide_link_text)
      end
    end

    Then "he is on the last slide" do
      wait_for { focus_on(:slideshow).content }.to eq "Thankyou"
    end

    When "he clicks on start" do
      focus_on(:slideshow).form_action("start")
    end

    Then "he sees the first slide again" do
      wait_for do
        focus_on(:slideshow).content
      end.to eq "My slideshow software"
    end

    When "he clicks on home" do
      focus_on(:slideshow).form_action("home")
    end

    Then "he sees the landing page" do
      wait_for { focus_on(:landing).title }.to eq "Interactive Slide Show"
    end

    And "Connectivity statistics"
    # TODO: how to test with multiple users logged in?
  end
end
