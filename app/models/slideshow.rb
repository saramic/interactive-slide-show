class Slideshow < ApplicationRecord
  belongs_to :user
  has_many :slides
end
