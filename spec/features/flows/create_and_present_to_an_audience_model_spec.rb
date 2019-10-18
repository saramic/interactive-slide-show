require "rails_helper"

describe "Create and present to an audience", type: :model do
  scenario "Create and present to an audience" do
    Given "A creator creates a number of slideshows" do
      @creator = create :user
      @slideshow = create :slideshow, user: @creator
      # if created as part of slideshow
      #   slides: [build(:slide), build(:slide)]
      # seem to have issue with sequential oridinals and cannot
      # ovewrite them
      @slideshow.slides << build(:slide)
      @slideshow.slides << build(:slide)
      @slideshow.slides << build(:slide)
    end

    And "Creates a viewing for an audience"
    And "adds the slideshows as presnetations for the vieweing"

    When "visitors join the viewing"
    Then "the creator sees a list of viewers"
    And "visitors see the viewing default page"

    When "the creator starts a presentation"
    Then "the creator sees the first slide of the presentation"
    And "the visitors see the first slide visitor view"
    And "the visitors see associated quizzes"

    When "the visitors interact with the quiz"
    Then "the creator sees the result of the quiz interaction"
  end
end
