class Section < ApplicationRecord
  belongs_to :floor, touch: true

  has_many :seats
end
