class Section < ApplicationRecord
  belongs_to :floor

  has_many :seats
end
