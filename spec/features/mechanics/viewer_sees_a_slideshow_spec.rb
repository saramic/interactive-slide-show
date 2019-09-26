require "rails_helper"

feature "Viwer can page through a slideshow", js: true do
  context "Thor, a user, has created a slideshow" do
    before do
      # TODO: bring in factory bot
      user_thor = User.create!(
        email: "thor@email.com",
        password: "1password"
      )
      slideshow = Slideshow.create!(title: "Viking God's", user: user_thor)
      [
        { title: "slide 1", content: "1" },
        { title: "slide 2", content: "2" },
        { title: "slide 3", content: "3" },
        { title: "slide 4", content: "4" }
      ].each do |args|
        slideshow.slides << Slide.create(args)
      end
      @start_link = slideshow_slide_path(
        slideshow_id: slideshow.id,
        id: slideshow.slides.first
      )
    end

    scenario "Hod, a viewer, sees the sildes in Thor's slideshow" do
      When "Hod visits the start link he was shared by Thor" do
        visit @start_link
      end

      # TODO: start a logged in session
      Then "he is asked to sign in or sign up" do
        wait_for do
          focus_on(:landing).messages
        end.to eq "Please sign in to continue."
      end

      When "Hod signs up" do
        focus_on(:landing).form_action("Sign up")
        focus_on(:landing).form_action(
          "Sign up",
          Email: "hod@gmail.com",
          Password: "1password"
        )
      end

      Then "he sees the first slide of the slide show" do
        wait_for do
          focus_on(:slideshow).content
        end.to eq "1"
      end

      When "he goes through all the slides" do
        [
          "slide 2",
          "slide 3",
          "slide 4"
        ].each do |next_slide_link_text|
          focus_on(:slideshow).choose(next_slide_link_text)
        end
      end

      Then "he is on the last slide" do
        wait_for { focus_on(:slideshow).content }.to eq "4"
      end

      When "he clicks on start" do
        focus_on(:slideshow).form_action("start")
      end

      Then "he sees the first slide again" do
        wait_for do
          focus_on(:slideshow).content
        end.to eq "1"
      end
    end
  end
end
