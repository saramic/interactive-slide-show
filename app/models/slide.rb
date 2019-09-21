class Slide < ApplicationRecord
  belongs_to :slideshow

  before_create :increment_ordinal

  private

  def increment_ordinal
    self.ordinal = slideshow.slides.length
  end
end
