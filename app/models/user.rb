class User < ApplicationRecord
  include Clearance::User
  has_many :viewings
end
