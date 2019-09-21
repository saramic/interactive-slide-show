class Slide < ApplicationRecord
  belongs_to :slideshow

  before_create :increment_ordinal

  def next
    current_index = slideshow.slides.find_index { |slide| slide == self }
    slideshow.slides.slice(current_index + 1, 2)
  end

  private

  def increment_ordinal
    self.ordinal = slideshow.slides.length
  end
end
