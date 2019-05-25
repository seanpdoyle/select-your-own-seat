class Floor < ApplicationRecord
  belongs_to :venue

  has_many :sections
  has_many :seats, through: :sections
end
