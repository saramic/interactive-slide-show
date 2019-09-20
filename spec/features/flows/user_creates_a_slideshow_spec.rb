require "rails_helper"

feature "User creates a slideshow", js: true do
  scenario "Michael creates a slideshow about his slideshow software" do
    # TODO: add ability to authenticate
    When "Michael creates a slideshow" do
      # TODO: title
      # TODO: styling
      visit root_path
      focus_on(:landing).follow_action("create")
    end

    Then "he is informed he needs to sign in or sign up" do
      wait_for { focus_on(:landing).messages }.to eq "Please sign in to continue."
    end

    When "he goes to sign up" do
      focus_on(:landing).follow_action("Sign up")
    end

    And "signs up with his email and a password" do
      focus_on(:landing).sign_up(
        Email: "saramic@gmail.com",
        Password: "1password",
      )
    end

    Then "he is signed in and can create a slideshow" do
      pending "add flash messages to administrate"
      wait_for { focus_on(:landing).messages }.to eq "Signed in as: saramic@gmail.com"
      # TODO: auto associate slideshow with user who is signed in
    end

    # give it a name: My Slideshow software

    And "adds a beginning slide"
    { short: "Intro", long: "My slideshow software", type: "1st" }

    And "adds slides about every aspect of the slideshow software"
    { short: "Inspiration", long: "Inspiration - kahoots and multi person cart", type: "normal" }
    { short: "Architecture", long: "Rails React GraphQL and Apollo", type: "normal" }
    { short: "Next steps", long: "service on line and plugin to work", type: "normal" }
    { short: "Testing approach", long: "light sprinkle of high level BDD", type: "normal" }

    And "adds an ending slide"
    { short: "The End", long: "Thankyou", type: "last" }

    And "hits publish"

    Then "The slide show is published"

    When "Michael views the slideshow"
    Then "The first slide is shown"
    And "Connectivity statistics"
    # TODO: how to test with multiple users logged in?
  end
end
