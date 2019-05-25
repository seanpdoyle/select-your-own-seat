class Venue < ApplicationRecord
  has_many :floors

  def to_param
    slug
  end
end
