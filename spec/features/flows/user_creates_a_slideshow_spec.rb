require "rails_helper"

feature "User creates a slideshow", js: true do
  scenario "Michael creates a slideshow about his slideshow software" do
    # TODO: add ability to authenticate
    When "Michael creates a slideshow" do
      # TODO: title
      # TODO: styling
      visit root_path
      focus_on(:landing).form_action("create")
    end

    Then "he is informed he needs to sign in or sign up" do
      wait_for {
        focus_on(:landing).messages
      }.to eq "Please sign in to continue."
    end

    When "he goes to sign up" do
      focus_on(:landing).form_action("Sign up")
    end

    And "signs up with his email and a password" do
      focus_on(:landing).form_action(
        "Sign up",
        Email: "saramic@gmail.com",
        Password: "1password",
      )
    end

    Then "he is signed in and can create a slideshow" do
      wait_for {
        focus_on(:dashboard).navigation.account
      }.to eq "Signed in as: saramic@gmail.com"
      wait_for { focus_on(:dashboard).title }.to eq "New Slideshows"
      # TODO: auto associate slideshow with user who is signed in
    end

    When 'he creates a slideshow "My slideshow software"' do
      focus_on(:dashboard).form_action(
        "Create Slideshow",
        Title: "My slideshow software",
      )
    end

    Then "the slideshow is successfully created" do
      dashboard = focus_on(:dashboard)
      wait_for {
        dashboard.messages
      }.to eq "Slideshow was successfully created."
      wait_for { dashboard.details }.to match(hash_including(
        TITLE: "My slideshow software",
      ))
    end

    When "he adds some slides" do
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Intro",
        Content: "My slideshow software",
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Inspiration",
        Content: "Inspiration - kahoots and multi person cart",
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Architecture",
        Content: "Rails React GraphQL and Apollo",
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Next steps",
        Content: "service on line and plugin to work",
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "Testing approach",
        Content: "light sprinkle of high level BDD",
      )
      focus_on(:dashboard).add_slide(
        Slideshow: "My slideshow software",
        Title: "The End",
        Content: "Thankyou",
      )
    end

    And "hits publish"

    Then "The slide show is published"

    When "Michael views the slideshow"
    Then "The first slide is shown"
    And "Connectivity statistics"
    # TODO: how to test with multiple users logged in?
  end
end
